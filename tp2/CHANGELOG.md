# Revision history for TP2

* **Project Start**

    At first glance we reviewed the lesson about Parsing - specially about Happy, a parser generator - and Interpreting Programs.

    After that, we made a first design about the project architecture. It has basically 4 layers:

    *The first 2 layers are related to the first project*

    * **IO Layer -** it is responsible to the 'inpure' part of the code that receives the data file from the user, reads it and sends it forward. It is also responsible to output the result of the pipeline.

    * **Lexing Layer -** it is responsible to recognize and list tokens in a string given by the **IO Layer**. They are then used in the **Parsing Layer**.

    * **Parsing Layer -** it is responsible to process the recognized tokens and generate the AST - Abstract Syntax Tree. It can be described as an abstract formal representation of the text code.

    * **Interpreter -** it is responsible to actually "execute the code". According to the instructions informed by the AST, the interpreter executes it, producing the output we expect.

* **Syntax First Implementation**

    We made an initial implementation of syntax data structures. We're not sure if it will remain the same all project long, but we chose to implement it first because the whole project needs it. 

* **Working on Parser Development...**

    We initially started on the parser's construction (since it is needed to create the interpreter). However, we had some struggles with some shift/reduce problems regarding array acess *[]* and could not solve it yet.

* **Parser First Version**

    We finished the implementation and fixed the shift/reduce problems. In the project report we explain how it was solved. We also fixed a problem related to the new keyword (we had forgotten about the *[]* to determine array size, and it took a long while to notice it).

* **Started Working on the Interpreter**

    With the syntax + parser ready, we started to work on the interpreter. We used the [base repo](https://github.com/rodrigogribeiro/bcc328-imp) provided by our professor Rodrigo. We made changes to expression interpretation and modelled/implemented a lot of stuff related to statement interpretation.

* **Working on Interpretation - Part 2**

    We started modelling/implementing registry based variables and indexed access - and it's being quite hard. We're also having problems altering these variables/regs values.

* **Working on Interpretation *(Refactor)* - Part 3**

    We re-analized our syntax model and came to the conclusion that changes we're necessary. We altered registers, variables, type and value models. Consequently, a lot of refactoring was done. Now we think we have a more coerent code base to implement variables/regs access related things we could not do before.

* **Working on Interpretation - Part 4**

    We successfully implemented indexed variables access after a lot of thinking, debugging and troubleshooting. We also started to work on registry definitions, access to reg vars and made changes on the parser to recognize the register type.

* **Working on Interpretation - Part 5**

    With the sucessfull implementation of registers and it's operations (also after a lot of thinking, debugging and troubleshooting), we finally completed the interpreter implementation.

* **Writing Programs on Lang**

    We started coding the first 3 proposed problems: factorial, fibonacci and sorting. No major problems we're encountered on it, only a couple of unexpected behaviours on return keyword that were fixed quite rapidly.

* **Writing Programs on Lang - Part 2**

    We finished writing the last 2 programs: stack and binary tree. They were a little bit harder to implement because they involved registry datatypes and are naturally more complex.

* **IO Cascade**

    To end up, we implemented an IO interface where the user can enter information which the *(lexer->parser->)*interpreter process. It also outputs the result of the computation to the user.

* **Late fixes**

    - Reading the specification again, we encountered some mistakes on the parser's grammar. We fixed it!
    - Added `if` without `else` (we forgot to do it). Added a `testing.lang` file to test any possible future fix!
    - Fixed return join on `interpList` function. It must be ++, not union.
