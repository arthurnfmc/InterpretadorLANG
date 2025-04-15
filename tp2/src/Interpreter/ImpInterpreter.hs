-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)
{-# LANGUAGE FlexibleContexts #-}

module Interpreter.ImpInterpreter (interpProgram) where

import Data.Char
import Data.List (union)
import Syntax.Syntax
import Data.Array

import Data.Map (Map)
import qualified Data.Map as Map

type Env = [(Var, Value)]

type FunctionEnv = Map Var Function

type CustomTypesEnv = Map Var RegisterDeclaration

(.+.) :: Value -> Value -> Value
(EInt n) .+. (EInt m) = EInt (n + m)
(EFloat n) .+. (EFloat m) = EFloat (n + m)
_        .+. _        = error "Type error"

(.*.) :: Value -> Value -> Value
(EInt n) .*. (EInt m) = EInt (n * m)
(EFloat n) .*. (EFloat m) = EFloat (n * m)
_        .*. _        = error "Type error"

(.-.) :: Value -> Value -> Value
(EInt n) .-. (EInt m) = EInt (n - m)
(EFloat n) .-. (EFloat m) = EFloat (n - m)
_        .-. _        = error "Type error"

(./.) :: Value -> Value -> Value
(EInt n) ./. (EInt m) = EInt (div n m)
(EFloat n) ./. (EFloat m) = EFloat (n/m)
_        ./. _        = error "Type error"

(.&&.) :: Value -> Value -> Value
(EBool b1) .&&. (EBool b2) = EBool (b1 && b2)
_          .&&. _         = error "Type error"

(.<.) :: Value -> Value -> Value
(EInt b1) .<. (EInt b2) = EBool (b1 < b2)
(EFloat b1) .<. (EFloat b2) = EBool (b1 < b2)
_         .<. _         = error "Type error"

(.==.) :: Value -> Value -> Value
(EInt b1) .==. (EInt b2) = EBool (b1 == b2)
ENull .==. ENull = (EBool True)
ENull .==. _ = (EBool False)
_ .==. ENull = (EBool False)
(EChar c1) .==. (EChar c2) = (EBool (c1 == c2))
_         .==. _         = error "Type error"

(.!=.) :: Value -> Value -> Value
(EInt b1) .!=. (EInt b2) = EBool (not (b1 == b2))
(EChar c1) .!=. (EChar c2) = (EBool (not (c1 == c2)))
ENull .!=. ENull = (EBool False)
ENull .!=. _ = (EBool True)
_ .!=. ENull = (EBool True)
_         .!=. _         = error "Type error"

(.%.) :: Value -> Value -> Value
(EInt b1) .%. (EInt b2) = EInt (b1 `mod` b2)
_         .%. _         = error "Type error"

printValue :: Value -> IO ()
printValue (EInt n) = print n
printValue (EBool b) = print b
printValue (EFloat n) = print n
printValue (EChar c) = print c
printValue ENull = print "null"
printValue (EUserValue xs) = print xs
printValue (Arr xs) = print xs

readValue :: IO Value
readValue
  = do
      s <- getLine
      if all isDigit s then return $ EInt $ read s
        else if s `elem` ["True", "False"] then return $ EBool $ read s
             else error "type error"

interpBinOp :: FunctionEnv -> CustomTypesEnv-> Env -> (Value -> Value -> Value) -> Exp -> Exp -> IO Value
interpBinOp fEnv tEnv env f e1 e2
  = do
       v1 <- interpExp fEnv tEnv env e1
       v2 <- interpExp fEnv tEnv env e2
       return (f v1 v2)

interpExp :: FunctionEnv -> CustomTypesEnv -> Env -> Exp -> IO Value
interpExp _ _ _  (EValue v) = return v
interpExp _ _ env (EVar v)
  = case lookup v env of
      Just val -> return val
      Nothing  -> error "Undefined variable"
interpExp fEnv tEnv env (e1 :+: e2)
  = do
      v1 <- interpExp fEnv tEnv env e1
      v2 <- interpExp fEnv tEnv env e2
      return (v1 .+. v2)
interpExp fEnv tEnv env (e1 :*: e2)
  = do
      v1 <- interpExp fEnv tEnv env e1
      v2 <- interpExp fEnv tEnv env e2
      return (v1 .*. v2)
interpExp fEnv tEnv env (e1 :-: e2)
  = interpBinOp fEnv tEnv env (.-.) e1 e2
interpExp fEnv tEnv env (e1 :/: e2)
  = interpBinOp fEnv tEnv env (./.) e1 e2
interpExp fEnv tEnv env (e1 :&&: e2)
  = interpBinOp fEnv tEnv env (.&&.) e1 e2
interpExp fEnv tEnv env (e1 :==: e2)
  = interpBinOp fEnv tEnv env (.==.) e1 e2
interpExp fEnv tEnv env (e1 :<: e2)
  = interpBinOp fEnv tEnv env (.<.) e1 e2
interpExp fEnv tEnv env (e1 :!=: e2)
  = interpBinOp fEnv tEnv env (.!=.) e1 e2
interpExp fEnv tEnv env (e1 :%: e2)
  = interpBinOp fEnv tEnv env (.%.) e1 e2
interpExp fEnv tEnv env (ENegative e)
  = interpBinOp fEnv tEnv env (.-.) (EValue (EInt 0)) e
interpExp fEnv tEnv env (EIndexAccess e1 e2)
  = do
      v1 <- interpExp fEnv tEnv env e1
      v2 <- interpExp fEnv tEnv env e2
      case v1 of
        (Arr xs) -> case v2 of
          (EInt i) -> return (xs ! i)
          _ -> error "Type error!"
        _ -> error "Type error!"
interpExp fEnv tEnv env (EFuncResults fnameVar args indexes)
  = case (Map.lookup fnameVar fEnv) of 
      Just function -> do 
          intIndexes <- fromExpsToInt fEnv tEnv env indexes
          vals <- (executeFunction fEnv tEnv env function args)
          let
            res = vals .!!. intIndexes
            s = length res
          case s of
            0 -> error "no return"
            1 -> return (res !! 0)
            _ -> return (Arr (listArray (1, s) (res)))
      _ -> error "Called Function does not exist!"
interpExp fEnv tEnv env (ENot e)
  = do
       v1 <- interpExp fEnv tEnv env e
       case v1 of
         (EBool b) -> return (EBool (not b))
         _         -> error "type error!"
interpExp fEnv tEnv env (EReg reg)
  = do
      rlist <- listifyRegister reg
      case lookup (Var $ unVar $ (head rlist)) env of
        (Just value) -> do
          finalVal <- seqLookups fEnv tEnv env (tail rlist) value
          return finalVal
        _ -> error "reg not found1"
interpExp fEnv tEnv env (ENew ty e) = genNestedArray fEnv tEnv env ty e

seqLookups :: FunctionEnv -> CustomTypesEnv -> Env -> [Var] -> Value -> IO Value
seqLookups _ _ _ _ (ENull) = return ENull -- end of recursion on recursive datatype such as binary tree
seqLookups _ _ _ (v@(Var _) : []) (EUserValue mp) 
  = case Map.lookup v mp of
      (Just val) -> return val
      _ -> error "reg not found2"
seqLookups fEnv tEnv env ((IndVar name index') : []) (EUserValue mp)
  = case Map.lookup (Var name) mp of
      (Just arr@(Arr _)) -> do 
        val <- indexedLookup fEnv tEnv env index' arr
        return val
      _ -> error "type error"
seqLookups fEnv tEnv env (v@(Var _) : xs) (EUserValue mp) 
  = case Map.lookup v mp of
      (Just val) -> seqLookups fEnv tEnv env xs val
      _ -> error "reg not found3"
seqLookups fEnv tEnv env ((IndVar name index') : xs) (EUserValue mp)
  = case Map.lookup (Var name) mp of
      (Just arr@(Arr _)) -> do 
        val <- indexedLookup fEnv tEnv env index' arr
        ret <- seqLookups fEnv tEnv env xs val
        return ret
      _ -> error "type error"
seqLookups _ _ _ _ _ = error "type error"

genNestedArray :: FunctionEnv -> CustomTypesEnv -> Env -> Ty -> [Exp] -> IO Value
genNestedArray fEnv tEnv env t (e : [])
  = do
      size <- interpExp fEnv tEnv env e
      case size of
        (EInt n) -> return (Arr (array (1, n) [(i, (defaultValue tEnv t)) | i <- [1..n]]))
        _ -> error "type error!"
genNestedArray fEnv tEnv env t (e : es)
  = do
      size <- interpExp fEnv tEnv env e
      case size of
        (EInt n) -> do
          nestedArray <- genNestedArray fEnv tEnv env t es
          return (Arr (array (1, n) [(i, nestedArray) | i <- [1..n]]))
        _ -> error "type error!"
genNestedArray _ _ _ _ _ = error "type error"

listifyRegister :: Register -> IO [Var]
listifyRegister r
  = do
    l <- listifyRegister' r
    return (reverse l)

listifyRegister' :: Register -> IO [Var]
listifyRegister' (BaseVar v) = return [v]
listifyRegister' ((BaseVar v) :.: r2) 
  = do
      lr <- listifyRegister' r2
      return (v : lr)
listifyRegister' _ = error "type error"

fromExpsToInt :: FunctionEnv -> CustomTypesEnv -> Env -> [Exp] -> IO [Int]
fromExpsToInt _ _ _ [] = return []
fromExpsToInt fEnv tEnv env (e:es) 
  = do
    v1 <- interpExp fEnv tEnv env e
    v2 <- fromExpsToInt fEnv tEnv env es
    case v1 of
      (EInt i) -> return (i : v2)
      _ -> error "Type error!"

(.!!.) :: [a] -> [Int] -> [a]
[] .!!. _ = []
_ .!!. [] = []
xs .!!. (i : is) = (xs !! i) : (xs .!!. is)

insertVal :: Var -> Value -> Env -> Env
insertVal v val env = (v, val) : env

defaultValue :: CustomTypesEnv -> Ty -> Value
defaultValue _ TInt  = EInt 0
defaultValue _ TBool = EBool False
defaultValue _ TFloat = EFloat 0.0
defaultValue _ TChar = EChar 'a'
defaultValue _ TVoid = ENull
defaultValue _ (Array _) = Arr (array (1, 10) [(i, ENull) | i <-[1..10]])
defaultValue _ (RegArray _) = Arr (array (1, 10) [(i, ENull) | i <-[1..10]])
defaultValue tEnv (CustomType v) = EUserValue (iterativeInserts tEnv (Map.empty :: Map Var Value) v)

iterativeInserts :: CustomTypesEnv -> (Map Var Value) -> Var -> (Map Var Value)
iterativeInserts tEnv mp var = case Map.lookup var tEnv of
  (Just (RegisterDeclaration _ camps)) -> multipleInsert mp camps
  _ -> error "register not found"
  where
    multipleInsert mp' ((key, ty) : xs) = multipleInsert (Map.insert key (defaultValue tEnv ty) mp') xs
    multipleInsert mp' [] = mp'

registerAlteration ::  FunctionEnv -> CustomTypesEnv -> Env -> (Map Var Value) -> [Var] -> Value -> IO (Map Var Value)
registerAlteration _ _ _ mp (v@(Var _) : []) val = return (Map.insert v val mp)
registerAlteration fEnv tEnv env mp ((IndVar name index') : []) val
  = case Map.lookup (Var name) mp of
      (Just arr@(Arr _)) -> do 
        newArr <- indexedAttribution fEnv tEnv env val index' arr
        return (Map.insert (Var name) newArr mp)
      _ -> error "type error"
registerAlteration fEnv tEnv env mp (v@(Var _) : xs) val 
  = do 
    case Map.lookup v mp of
      (Just (EUserValue mp')) -> do 
        newMap <- registerAlteration fEnv tEnv env mp' xs val
        return (Map.insert v (EUserValue newMap) mp)
      _ -> error "type error"
registerAlteration fEnv tEnv env mp ((IndVar name index') : xs) val
  = case Map.lookup (Var name) mp of
      (Just arr@(Arr arr')) -> do 
        depthM <- getMapInDepth fEnv tEnv env arr' index'
        mp' <- (registerAlteration fEnv tEnv env depthM xs val)
        newArr <- indexedAttribution fEnv tEnv env (EUserValue mp') index' arr
        return (Map.insert (Var name) newArr mp)
      _ -> error "type error"
    where
      getMapInDepth :: FunctionEnv -> CustomTypesEnv -> Env -> Array Int Value -> [Exp] -> IO (Map Var Value)
      getMapInDepth fEnv' tEnv' env' arr' (e : [])
        = do
            (EInt i) <- interpExp fEnv' tEnv' env' e
            case (arr' ! i) of
              (EUserValue mp') -> return mp'
              _ -> error "type error"
      getMapInDepth fEnv' tEnv' env' arr' (e : es)
        = do
            (EInt i) <- interpExp fEnv' tEnv' env' e
            case (arr' ! i) of 
              (Arr arr'') -> getMapInDepth fEnv' tEnv' env' arr'' es
              _ -> error "type error"
      getMapInDepth _ _ _ _ _ = error "type error"
registerAlteration _ _ _ _ _ _ = error "type error"

removeVars :: [Var] -> Env -> Env
removeVars vs env
  = foldr removeVar env vs
  where
    removeVar _ [] = []
    removeVar v ((v', val) : env')
      | v == v' = env'
      | otherwise = (v', val) : removeVar v env'

multipleAttribs :: FunctionEnv -> CustomTypesEnv -> Env -> Int -> [AtributionCandidate] -> Array Int Value -> IO (Env, [Var], [Value])
multipleAttribs _ _ env _ [] _ = return (env, [], [])
multipleAttribs fEnv tEnv env i (v:vs) arr
  = do
      (env', vars, values') <- interpStmt fEnv tEnv env (v := (EValue(arr ! i)))
      (env'', vars', values'') <- multipleAttribs fEnv tEnv env' (i+1) vs arr
      return (env'', vars' `union` vars, values'' `union` values' )

interpStmt :: FunctionEnv -> CustomTypesEnv -> Env -> Stmt -> IO (Env, [Var], [Value])
interpStmt _ _ env Skip = return (env, [], [])
interpStmt fEnv tEnv env (Def t v me)
  = case me of
      Just e -> do
        v1 <- interpExp fEnv tEnv env e
        return (insertVal v v1 env, [v], [])
      Nothing -> return (insertVal v (defaultValue tEnv t) env, [v], [])
interpStmt _ tEnv env (DefReg tv v) = return (insertVal v (defaultValue tEnv (CustomType tv)) env, [v], []) 
interpStmt fEnv tEnv env (vs :=- e)
  = do
      eval <- interpExp fEnv tEnv env e
      case eval of
        (Arr arr) -> case (length $ elems $ arr) == (length vs) of
          True -> multipleAttribs fEnv tEnv env 1 vs arr
          _ -> error "mismatch on returns size"
        _ -> error "function does not have multiple returns"
interpStmt fEnv tEnv env ((SimpleVar v@(Var _)) := e)
  = do
      val <- interpExp fEnv tEnv env e
      return (insertVal v val env, [], [])
interpStmt fEnv tEnv env ((SimpleVar (IndVar vName index')) := e)
  = do
      v1 <- interpExp fEnv tEnv env e
      case lookup (Var vName) env of
        (Just ar@(Arr _)) -> do
            newVal <- indexedAttribution fEnv tEnv env v1 index' ar
            return (insertVal (Var vName) newVal env, [], [])
        _ ->  error "type error!"
interpStmt fEnv tEnv env ((UserRegister r@((BaseVar _) :.: _)) := e)
  = do
      v1 <- interpExp fEnv tEnv env e
      rlist <- listifyRegister r
      case lookup (Var $ unVar $ (head rlist)) env of
        (Just (EUserValue mp)) -> do
          newMap <- registerAlteration fEnv tEnv env mp (tail rlist) v1
          return (insertVal (Var $ unVar $ (head rlist)) (EUserValue newMap) env, [], [])
        _ -> error "type error"
interpStmt fEnv tEnv env (If e1 b1 b2)
  = do
      val1 <- interpExp fEnv tEnv env e1
      case val1 of
        EBool True ->
          do
            (env', vars, rtrn) <- interpBlock fEnv tEnv env b1
            return (removeVars vars env', [], rtrn)
        EBool False ->
          do
            (env', vars, rtrn) <- interpBlock fEnv tEnv env b2
            return (removeVars vars env', [], rtrn)
        _           -> error "type error"
interpStmt fEnv tEnv env (Iterate e b)
  = do
       v1 <- interpExp fEnv tEnv env e
       case v1 of 
        (EInt 0) -> return (env, [], [])
        (EInt n) -> if (n<0) then (error "negative iterate exp") else do
          (env1, vars, _) <- interpBlock fEnv tEnv env b
          (env', _, _) <- interpStmt fEnv tEnv env1 (Iterate (EValue (EInt (n-1))) b)
          return (removeVars vars env', [], [])
        _ -> error "type error!"
interpStmt fEnv tEnv env (Print e)
  = do
      v1 <- interpExp fEnv tEnv env e
      printValue v1
      return (env , [], [])
interpStmt _ _ env (SRead x)
  = do
      n <- readValue
      return (insertVal x n env, [], [])
interpStmt fEnv tEnv env (FunctionCall var args rtnVars)
  = do
      case (Map.lookup var fEnv) of 
        Just function -> do
            vals <- executeFunction fEnv tEnv env function args
            if ((length vals) /= (length rtnVars)) && ((length rtnVars) > 0)
              then error "mismatch on return vars and values size!"
              else do
                env' <- atribMultipleVals fEnv tEnv env vals rtnVars
                return (env', [], [])
        _ -> error "Called Function does not exist!"
interpStmt fEnv tEnv env (Return exps)
  = do
      values <- interpretExpList fEnv tEnv env exps
      return (env, [], values)
interpStmt _ _ _ _ = error "type error"

atribMultipleVals :: FunctionEnv -> CustomTypesEnv -> Env -> [Value] -> [PossibleIdentifier] -> IO Env
atribMultipleVals _ _ env [] _ = return env
atribMultipleVals _ _ env _ [] = return env
atribMultipleVals fEnv tEnv env (e:es) ((PossVar var) : xs)
  = do
      (env', _, _) <- interpStmt fEnv tEnv env ((SimpleVar var) := (EValue e))
      atribMultipleVals fEnv tEnv env' es xs
atribMultipleVals fEnv tEnv env (e:es) ((PossReg reg) : xs)
  = do
      (env', _, _) <- interpStmt fEnv tEnv env ((UserRegister reg) := (EValue e))
      atribMultipleVals fEnv tEnv env' es xs

indexedLookup :: FunctionEnv -> CustomTypesEnv -> Env -> [Exp] -> Value -> IO Value
indexedLookup fEnv tEnv env (e : []) ar'
  = do
      case ar' of
        (Arr ar) -> do
          index' <- interpExp fEnv tEnv env e
          case index' of
            (EInt i) -> return (ar ! i)
            _ -> error "invalid index"
        _ -> error "type error"
indexedLookup fEnv tEnv env (e : es) ar'
  = case ar' of
      (Arr ar) -> do
        index' <- interpExp fEnv tEnv env e
        case index' of
          (EInt i) -> indexedLookup fEnv tEnv env es (ar ! i)
          _ -> error "invalid index"
      _ -> error "type error!"
indexedLookup _ _ _ _ _ = error "type error"

indexedAttribution :: FunctionEnv -> CustomTypesEnv -> Env -> Value -> [Exp] -> Value -> IO Value
indexedAttribution fEnv tEnv env val (e : []) ar'
  = do
      case ar' of
        (Arr ar) -> do
          index' <- interpExp fEnv tEnv env e
          case index' of
            (EInt i) -> return (Arr (ar // [(i, val)]))
            _ -> error "invalid index"
        _ -> error "type error"
indexedAttribution fEnv tEnv env val (e : es) ar'
  = case ar' of
      (Arr ar) -> do
        index' <- interpExp fEnv tEnv env e
        case index' of
          (EInt i) -> do
            newArray <- (indexedAttribution fEnv tEnv env val es (ar ! i))
            return (Arr (ar // [(i, newArray)]))
          _ -> error "invalid index"
      _ -> error "type error!"
indexedAttribution _ _ _ _ _ _ = error "type error"

interpBlock :: FunctionEnv -> CustomTypesEnv -> Env -> Block -> IO (Env, [Var], [Value])
interpBlock fEnv tEnv env (Block stms)
  = do
       (env1, vs, rts) <- interpList fEnv tEnv env stms
       return (removeVars vs env1, [], rts)

interpList :: FunctionEnv -> CustomTypesEnv -> Env -> [Stmt] -> IO (Env, [Var], [Value])
interpList _ _ env [] = return (env, [], [])
interpList fEnv tEnv env (s@(Return _) : _)
  = do
      (env1, vs, rts) <- interpStmt fEnv tEnv env s
      return (env1, vs, rts)
interpList fEnv tEnv env (s : ss)
  = do
       (env1, vs, rts) <- interpStmt fEnv tEnv env s
       (env2, vss, rtss) <- interpList fEnv tEnv env1 ss
       return (env2, vs `union` vss, rts++rtss)

defineFuncs :: [ProgramUnit] -> FunctionEnv -> FunctionEnv
defineFuncs ((ProgFunc f@(Function fName _ _ _)):xs) fEnv -- args [(Var, Ty)] ; rets [Ty]
  = defineFuncs xs (Map.insert fName f fEnv)
defineFuncs (_:xs) fEnv = defineFuncs xs fEnv
defineFuncs [] fEnv = fEnv

defineDataTypes :: [ProgramUnit] -> CustomTypesEnv -> CustomTypesEnv
defineDataTypes ((ProgRegDec r@(RegisterDeclaration rName _)) : xs) tEnv
  = defineDataTypes xs (Map.insert rName r tEnv)
defineDataTypes (_:xs) tEnv = defineDataTypes xs tEnv
defineDataTypes [] tEnv = tEnv

interpretExpList :: FunctionEnv -> CustomTypesEnv -> Env -> [Exp] -> IO [Value]
interpretExpList _ _ _ [] = return []
interpretExpList fEnv tEnv env (e : es)
  = do
      v1 <- interpExp fEnv tEnv env e
      v2 <- interpretExpList fEnv tEnv env es
      return (v1 : v2)

executeFunction :: FunctionEnv -> CustomTypesEnv -> Env -> Function -> [Exp] -> IO [Value]
executeFunction fEnv tEnv env (Function _ xs _ blk) args
  = do
      let
        (vars, _) = unzip xs
        vars' =  map PossVar vars
      values <- interpretExpList fEnv tEnv env args
      env' <- atribMultipleVals fEnv tEnv env values vars'
      (_, _, rts) <- interpBlock fEnv tEnv env' blk
      return rts
  
searchMain :: [ProgramUnit] -> Maybe Function
searchMain [] = Nothing
searchMain ((ProgRegDec _) : xs) = searchMain xs
searchMain ((ProgFunc f@(Function (Var name) _ _ _)):xs)
  | name == "main" = Just f
  | otherwise = searchMain xs
searchMain _ = error "type error!"
      
interpProgram :: Program -> IO [Value]
interpProgram (Program program)
  = do
      let
        fEnv = defineFuncs program Map.empty
        tEnv = defineDataTypes program Map.empty
        mainF = searchMain program
      case mainF of
        (Just f) -> do
          vals <- executeFunction fEnv tEnv [] f []
          return vals
        _ -> error "main function not defined"
