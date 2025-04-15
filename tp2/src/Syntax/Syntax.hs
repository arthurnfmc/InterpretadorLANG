-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)
-- |

module Syntax.Syntax where

import Data.Array
import Data.Map (Map)

-- definition of expressions

data AtributionCandidate
  = SimpleVar Var
  | UserRegister Register
  deriving (Eq, Ord, Show)

data Var = Var { unVar :: String } 
          | IndVar {unVar :: String, index :: [Exp]} 
          deriving (Eq, Ord, Show)

data Value
  = EInt Int
  | EFloat Float
  | EBool Bool
  | EChar Char
  | ENull
  | EUserValue (Map Var Value)
  | Arr (Array Int Value)
  deriving (Eq, Ord, Show)

-- pagina 7 da especificacao
data Register 
  = BaseVar Var
  | Register :.: Register
  deriving (Eq, Ord, Show)
  
data Exp
  = EValue Value
  | EVar Var
  | Exp :+: Exp
  | Exp :*: Exp
  | Exp :-: Exp
  | Exp :/: Exp
  | Exp :==: Exp
  | Exp :!=: Exp
  | Exp :<: Exp
  | Exp :%: Exp
  | ENot Exp
  | Exp :&&: Exp
  | ENew Ty [Exp]
  | ENegative Exp
  | EIndexAccess Exp Exp
  | EFuncResults Var [Exp] [Exp]
  | EReg Register
  deriving (Eq, Ord, Show)

-- types

data Ty = TInt 
          | TBool
          | TFloat
          | TChar
          | TVoid
          | Array Ty
          | RegArray Var
          | CustomType Var
          deriving (Eq, Ord, Show)

data PossibleIdentifier
  = PossVar Var
  | PossReg Register
  deriving (Eq, Ord, Show)

-- syntax for statements

newtype Program
  = Program {unProgram :: [ProgramUnit]}
    deriving (Eq, Ord, Show)

newtype Block
  = Block { unBlock :: [Stmt] }
    deriving (Eq, Ord, Show)

data Function
  = Function Var [(Var, Ty)] [Ty] Block
    deriving (Eq, Ord, Show)

data RegisterDeclaration
  = RegisterDeclaration Var [(Var, Ty)]
    deriving (Eq, Ord, Show)

data ProgramUnit
  = ProgFunc Function
  | ProgRegDec RegisterDeclaration
  deriving (Eq, Ord, Show)

data Stmt
  = Skip
  | Def Ty Var (Maybe Exp)
  | AtributionCandidate := Exp
  | [AtributionCandidate] :=- Exp
  | DefReg Var Var
  | If Exp Block Block
  | Print Exp
  | SRead Var
  | Iterate Exp Block
  | Return [Exp]
  | FunctionCall Var [Exp] [PossibleIdentifier]
  deriving (Eq, Ord, Show)
