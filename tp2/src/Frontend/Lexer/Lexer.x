-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)

-- module header
{
module Frontend.Lexer.Lexer (lexer, Token (..)) where
import Data.Char (toUpper)
}

%wrapper "basic"

-- usefull macros
$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters
$alphaNum = [a-zA-Z0-9] -- alphanumeric characters

@identifier = $alpha[$alphaNum]*
@number = $digit+
@floatPointNumber = [$digit]*\.$digit[$digit]*

-- tokens
tokens :-
  $white+                 ; -- removing whitespace
  "--".*                  ; -- removing comments

  -- values
  @floatPointNumber       { \ s -> FLOAT (floatHandle s)}
  @number                 { \ s -> INT (read s)}
  "true"                  { \ s -> BOOL (read (capitalize s))}
  "false"                 { \ s -> BOOL (read (capitalize s))}
  "null"                  { \ _ -> NULL}

  -- types
  "Int"                   { \ _ -> INTTYPE} 
  "Char"                  { \ _ -> CHARTYPE}
  "Bool"                  { \ _ -> BOOLTYPE}
  "Float"                 { \ _ -> FLOATTYPE}

  -- data & new
  "data"                  { \ _ -> DATA} 
  "new"                   { \ _ -> NEW}

  -- commands
  "if"                    { \ _ -> IF}
  "else"                  { \ _ -> ELSE}
  "then"                  { \ _ -> THEN}
  "iterate"               { \ _ -> ITERATE}
  "read"                  { \ _ -> READ}
  "print"                 { \ _ -> PRINT}
  "return"                { \ _ -> RETURN}
  "skip"                  { \ _ -> SKIP}

  -- operators
  "&&"                    { \ _ -> AND}
  "=="                    { \ _ -> EQUAL}
  "!="                    { \ _ -> DIFTHAN}
  "::"                    { \ _ -> TYPEOF}
  \+                      { \ _ -> PLUS}
  \-                      { \ _ -> MINUS}
  \*                      { \ _ -> MULT}
  \/                      { \ _ -> DIV}
  \%                      { \ _ -> MODULO}
  \!                      { \ _ -> NOT}
  \<                      { \ _ -> LESSTHAN}
  \>                      { \ _ -> GREATERTHAN}
  \(                      { \ _ -> OPENPARENS}
  \)                      { \ _ -> CLOSEPARENS}
  \{                      { \ _ -> OPENBRACES}
  \}                      { \ _ -> CLOSEBRACES}
  \[                      { \ _ -> OPENBRACKETS}
  \]                      { \ _ -> CLOSEBRACKETS}
  \;                      { \ _ -> SEMICOLON}
  \=                      { \ _ -> ATTRIBUTION}
  \:                      { \ _ -> COLON}
  \,                      { \ _ -> COMMA}
  \.                      { \ _ -> DOT}
  \@                      { \ _ -> AT}

  -- identifiers
  @identifier             { \ s -> ID s }

  -- escape chars + \ + '
  \'\\n\'                 { \ s -> CHAR (specialHandle s)}
  \'\\t\'                 { \ s -> CHAR (specialHandle s)}
  \'\\b\'                 { \ s -> CHAR (specialHandle s)}
  \'\\r\'                 { \ s -> CHAR (specialHandle s)}
  \'\\\\\'                { \ s -> CHAR (specialHandle s)}
  \'\\\'\'                { \ s -> CHAR (specialHandle s)}
  \'.\'                   { \ s -> CHAR (secondChar s)} -- normal char

  
-- more Haskell code

{
data Token
  = ID String
  | DATAID String
  | INT Int
  | FLOAT Float
  | CHAR Char 
  | BOOL Bool
  | NULL
  | INTTYPE
  | CHARTYPE
  | BOOLTYPE
  | FLOATTYPE
  | DATA
  | NEW
  | IF
  | ELSE
  | THEN
  | ITERATE
  | READ
  | PRINT
  | SKIP
  | RETURN
  | AND
  | LESSTHAN
  | GREATERTHAN
  | EQUAL
  | DIFTHAN
  | PLUS
  | MINUS
  | MULT
  | DIV
  | MODULO
  | NOT
  | OPENPARENS
  | CLOSEPARENS
  | OPENBRACES
  | CLOSEBRACES
  | OPENBRACKETS
  | CLOSEBRACKETS
  | TYPEOF
  | SEMICOLON
  | ATTRIBUTION
  | COMMA
  | COLON
  | DOT
  | AT
  deriving (Eq, Show)

lexer :: String -> [Token]
lexer = alexScanTokens

secondChar :: String -> Char
secondChar (_:y:_) = y
secondChar _ = '\0'

floatHandle :: String -> Float
floatHandle s@(x:_)
  | x == '.'  = floatHandle ("0"++s)
  | otherwise = ((read s) :: Float)
floatHandle _ = error "Float parsing error"

specialHandle :: String -> Char
specialHandle (_:_:x:_) = specialChar x
specialHandle _ = error ("Non escapable char informed")

specialChar :: Char -> Char
specialChar 'n' = '\n'
specialChar 't' = '\t'
specialChar 'b' = '\b'
specialChar 'r' = '\r'
specialChar x = x

capitalize :: String -> String
capitalize (x:xs) = (toUpper x) : xs
capitalize _ = []
}