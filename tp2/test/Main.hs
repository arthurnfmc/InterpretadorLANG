-- Arthur Negrao de Faria Martins da Costa (21.1.4001) e Igor Machado Cruz Guimaraes Oliveira (21.1.4012)
module Main (main) where

import Interpreter.ImpInterpreter
import Frontend.Parser.Parser
import Test.Tasty
import Test.Tasty.Golden

execProgram :: String -> String -> IO ()
execProgram path output = do
    program <- Prelude.readFile path
    value <- interpProgram $ impParser $ program
    writeFile output (show value)

goldenFactorialTest :: TestTree
goldenFactorialTest =
  goldenVsFile 
    "Factorial Test" 
    "./test/golden/factorial.golden" 
    "./test/outputs/factorial.output" 
    (execProgram "./test/langFiles/factorialTest.lang" "./test/outputs/factorial.output")

goldenFibonnaciTest :: TestTree
goldenFibonnaciTest =
  goldenVsFile 
    "Fibonnaci Test" 
    "./test/golden/fibonnaci.golden" 
    "./test/outputs/fibonnaci.output" 
    (execProgram "./test/langFiles/fibonnaciTest.lang" "./test/outputs/fibonnaci.output")

goldenSelectionSortTest :: TestTree
goldenSelectionSortTest =
  goldenVsFile 
    "Selection Sort Test" 
    "./test/golden/selectionSort.golden" 
    "./test/outputs/selectionSort.output" 
    (execProgram "./test/langFiles/selectionSortTest.lang" "./test/outputs/selectionSort.output")

goldenStackTest :: TestTree
goldenStackTest =
  goldenVsFile 
    "Stack Test" 
    "./test/golden/stack.golden" 
    "./test/outputs/stack.output" 
    (execProgram "./test/langFiles/stackTest.lang" "./test/outputs/stack.output")

goldenTreeTest :: TestTree
goldenTreeTest =
  goldenVsFile 
    "Tree Test" 
    "./test/golden/tree.golden" 
    "./test/outputs/tree.output" 
    (execProgram "./test/langFiles/treeTest.lang" "./test/outputs/tree.output")

tests :: TestTree
tests = testGroup "Golden Tests" [goldenFactorialTest, 
                                  goldenFibonnaciTest,
                                  goldenSelectionSortTest,
                                  goldenStackTest,
                                  goldenTreeTest]

main :: IO ()
main = defaultMain tests