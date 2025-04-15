[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/Bo6_M8VO)

# About us
- Arthur Negrão de Faria Martins da Costa - 21.1.4001
- Igor Machado Cruz Guimarães Oliveira - 21.1.4012

# About this project
This project is a [sintatic analyzer](https://www.geeksforgeeks.org/introduction-to-syntax-analysis-in-compiler-design/) + [interpreter](https://www.geeksforgeeks.org/difference-between-compiler-and-interpreter/) implemented in Haskell for Lang Language. It was specified by our professor [Rodrigo G. Ribeiro](https://github.com/rodrigogribeiro) in **BCC328 — Construção de Compiladores I** class, at Ouro Preto Federal University (Universidade Federal de Ouro Preto - UFOP).

In this repo, you can find:
1. All the source code
2. A `CHANGELOG.md` file that summarizes the project construction history
3. A `project-report.pdf` file, which is a report according to the the assignment instructions (written in Portuguese)

# How to use it

**Inside tp2 directory, you can:**

`cabal new-build` will compile the Haskell code

`cabal new-repl` will open an interpreter

`cabal new-test` will run tests

`cabal new-run tp2 -- path_to_file.lang` will execute the program you defined

`cabal new-run tp2` will prompt the terminal for user input

In this repo we have a programs directory with programs you can test. Feel free to use it!

**WARNING:** This project is sensitive to **END OF LINE SEQUENCE (ELS)** changes. Be sure to write your *.lang* files with **LF** els (linux-standard). 

# Docker

`docker run -it arthurnfmc/tp2-compiladores` will start a container with the project!

`cd TP2-COMPILADORES/tp2/` to use it!