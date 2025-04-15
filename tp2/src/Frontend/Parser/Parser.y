-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)
{
module Frontend.Parser.Parser (impParser) where

import Frontend.Lexer.Lexer
import Syntax.Syntax
}


%name parser
%tokentype { Token }
%error     {parseError}


%token
      -- values
      floatNum  {(FLOAT $$)} 
      num       {(INT $$)}
      char      {(CHAR $$)}
      'true'    {(BOOL True)}
      'false'   {(BOOL False)}
      'null'    {NULL}

      -- types
      'Int'      {INTTYPE}
      'Char'     {CHARTYPE}
      'Bool'     {BOOLTYPE}
      'Float'    {FLOATTYPE}

      -- data & new
      'data'     {DATA} 
      'new'      {NEW}
      
      -- commands
      'read'    {READ}
      'print'   {PRINT}
      'if'      {IF}
      'then'    {THEN}
      'else'    {ELSE}
      'return'  {RETURN}
      'iterate' {ITERATE}
      'skip'    {SKIP}

      -- operators
      '&&'      {AND}
      '=='      {EQUAL}
      '!='      {DIFTHAN}
      '::'      {TYPEOF}
      '+'       {PLUS}
      '-'       {MINUS}
      '*'       {MULT}
      '/'       {DIV}
      '%'       {MODULO}
      '!'       {NOT}
      '<'       {LESSTHAN}
      '>'       {GREATERTHAN}
      '('       {OPENPARENS}
      ')'       {CLOSEPARENS}
      '{'       {OPENBRACES}
      '}'       {CLOSEBRACES}
      '['       {OPENBRACKETS}
      ']'       {CLOSEBRACKETS}
      ';'       {SEMICOLON}
      '='       {ATTRIBUTION}
      ':'       {COLON}
      ','       {COMMA}
      '.'       {DOT}
      '@'       {AT}

      -- ids
      id        {(ID $$)}


%nonassoc '==' 
%nonassoc '!='
%nonassoc '<'
%left '&&'
%left '+' 
%left '-'
%left '*' 
%left '/' 
%left '%'
%right '!'
%left '['
%left ']' 
%left '.' 
%left '(' 
%left ')'
%%

ProgramStart : Program                             {Program (reverse $1)}

Program : Program Id '(' FArgs ')' RetValsStart CodeBlock { ProgFunc (Function $2 (reverse $4) (reverse $6) $7) : $1 }
    | Program 'data' Id '{' DataDecl '}'           { ProgRegDec (RegisterDeclaration $3 (reverse $5)) : $1} 
    |                                              { [] }

DataDecl : DataDecl Id '::' PTy ';'                { ($2, $4) : $1}
    | DataDecl Id '::' Id ';'                      { ($2, CustomType $4) : $1}
    | Id '::' PTy ';'                              {[($1, $3)]}
    | Id '::' Id ';'                               {[($1, CustomType $3)]}

FArgs : FArgs ',' Id '::' PTy                      {($3, $5) : $1}
    | Id '::' PTy                                  {[($1, $3)]}
    |                                              { [] }

RetValsStart : ':' RetVals                         {$2}
    |                                              { [] }

RetVals : RetVals ',' PTy                          {$3 : $1}
    | PTy                                          {[$1]}

CodeBlock : '{' StmtList '}'                       { Block (reverse $2) }

StmtList : StmtList Stmt                           { $2 : $1 }
         |                                         { [] }

Stmt : 'skip' ';'                                  {Skip}
     | IdAtrib '=' Exp ';'                         {(SimpleVar $1) := $3}
     | MultAtrib '=' Id '(' Exps1 ')' '[' Exps1 ']' ';' {$1 :=- (EFuncResults $3 (reverse $5) (reverse $8))}
     | Id '::' PTy ';'                             {Def $3 $1 Nothing}
     | RegistS '=' Exp ';'                         {(UserRegister $1) := $3}
     | Id '::' Id ';'                              {DefReg $3 $1}
     | 'if' Exp 'then' CodeBlock                   {If $2 $4 (Block [Skip])}
     | 'if' Exp 'then' CodeBlock 'else' CodeBlock  {If $2 $4 $6}
     | 'print' Exp ';'                             {Print $2}
     | 'read'  Id ';'                              {SRead $2}
     | 'iterate' Exp CodeBlock                     {Iterate $2 $3}
     | 'return' Exps1 ';'                          {Return (reverse $2)}
     | Id '(' Exps1 ')' FuncReturns ';'            {FunctionCall $1 (reverse $3) $5}

MultAtrib : IdAtrib ',' MultAtrib1                 {(SimpleVar $1) : $3}
    | RegistS ',' MultAtrib1                       {(UserRegister $1) : $3}

MultAtrib1 : IdAtrib ',' MultAtrib1                {(SimpleVar $1) : $3}
    | RegistS ',' MultAtrib1                       {(UserRegister $1) : $3}
    | RegistS                                      {[UserRegister $1]}
    | IdAtrib                                      {[SimpleVar $1]}

IdAtrib : id                                       {(Var $1)}
    | id '[' Exps ']'                              {(IndVar $1 (reverse $3))}

Id : id                                            {(Var $1)}

RegistS : Regist '.' Id                            {((BaseVar $3) :.: $1)}
    | Regist '.' id '@' '[' Exps ']'               {((BaseVar (IndVar $3 (reverse $6))) :.: $1)}

Regist : Regist '.' Id                             {(BaseVar $3) :.: $1}
    | Regist '.' id '@' '[' Exps ']'               {(BaseVar (IndVar $3 (reverse $6))) :.: $1}
    | Id                                           {BaseVar $1}

FuncReturns : '<' Ids '>'                          {reverse $2}
    |                                              { [] } -- problema se nao considerar o < >

Ids : Ids ',' Id                                   {(PossVar $3) : $1}
    | Ids ',' RegistS                              {(PossReg $3) : $1}
    | Id                                           {[PossVar $1]}
    | RegistS                                      {[PossReg $1]}
    |                                              { [] }

NewDecl : 'Int'                                    {TInt}
    | 'Bool'                                       {TBool}
    | 'Char'                                       {TChar}
    | 'Float'                                      {TFloat}
    | id                                           {CustomType (Var $1)}

PTy : 'Int'                                        {TInt}
    | 'Bool'                                       {TBool}
    | 'Char'                                       {TChar}
    | 'Float'                                      {TFloat}
    | '@' id                                       {CustomType $ Var $ $2}
    | ArrayTy                                      {$1}

ArrayTy : id '[' ']'                               {RegArray (Var $1)}
    | 'Int' '[' ']'                                {Array TInt}
    | 'Bool' '[' ']'                               {Array TBool}
    | 'Char' '[' ']'                               {Array TChar}
    | 'Float' '[' ']'                              {Array TFloat}

Exps : Exps ',' Exp                                { $3 : $1 }
     | Exp                                         { [$1] }
     | '@'                                         { [] }

Exps1 : Exps1 ',' Exp                              { $3 : $1 }
     | Exp                                         { [$1] }
     |                                             { [] }

Exp : num                                          {EValue (EInt $1)}
    | floatNum                                     {EValue (EFloat $1)}
    | char                                         {EValue (EChar $1)}
    | 'true'                                       {EValue (EBool True)}
    | 'false'                                      {EValue (EBool False)}
    | 'null'                                       {EValue ENull}
    | Id                                           {EVar $1}
    | Exp '+' Exp                                  {$1 :+: $3}
    | Exp '*' Exp                                  {$1 :*: $3}
    | Exp '-' Exp                                  {$1 :-: $3}
    | Exp '/' Exp                                  {$1 :/: $3}
    | Exp '<' Exp                                  {$1 :<: $3}
    | Exp '==' Exp                                 {$1 :==: $3}
    | Exp '!=' Exp                                 {$1 :!=: $3}
    | Exp '%' Exp                                  {$1 :%: $3}
    | Exp '&&' Exp                                 {$1 :&&: $3}
    | '-' Exp                                      {ENegative $2}
    | Exp '[' Exp ']'                              {EIndexAccess $1 $3}
    | Id '(' Exps1 ')' '[' Exps1 ']'               {EFuncResults $1 (reverse $3) (reverse $6)}
    | '!' Exp                                      {ENot $2}
    | '(' Exp ')'                                  { $2 }
    | RegistS                                      {EReg $1}
    | 'new' NewDecl '[' Exps1 ']'                  {ENew $2 (reverse $4)}    --pag 9 espec

{
parseError :: [Token] -> a
parseError [] = error "Parse error!"
parseError (t : _) = error $ "Parse error " ++ (show t)


impParser :: String -> Program
impParser = parser . lexer
}
