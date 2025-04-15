-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)
module Main where

import System.Environment
import Interpreter.ImpInterpreter
import Frontend.Parser.Parser

main :: IO ()
main = do
  args <- getArgs
  case (length args) of
    0 -> do
      program <- getLine
      value <- interpProgram $ impParser $ program
      print ("Program Last Return: " ++ (show value))
    1 -> do
      program <- readFile (head args)
      value <- interpProgram $ impParser $ program
      print ("Program Last Return: " ++ (show value))
    _ -> do
      print "ERROR: check program usage:"
      print "cabal new-run tp2 -- <file_path>"
      print "OR"
      print "cabal new-run tp2 (and then enter your program as string)"
