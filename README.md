# Lex Bison Compiler

This project implements a simple compiler for parsing arithmetic expressions and generating intermediate code. It consists of a lexical analyzer, a parser, and an intermediate code generator.

## Project Structure

The project is organized into the following files:

- `lexicalPhase.l`: Lex file defining regular expressions and translation rules for tokenizing the input source code.
- `syntaxAna.y`: Bison file containing grammar rules and semantic actions for parsing the tokens and constructing a syntax tree.
- `lexPhase.c`: C file implementing the intermediate code generator and auxiliary functions for arithmetic operations.
- `lexPhase.h`: Header file containing macro definitions, function prototypes, and include statements.

## Struggles and Resolutions

### NUM_TOKEN Macro Issue

I encountered a compilation error related to the `NUM_TOKEN` macro in `lexPhase.h`. The issue was resolved by ensuring the proper macro definition in the header file.

### Type Mismatch in `yylval`

There were type mismatch issues in the Lex file (`lexicalPhase.l`) related to the assignment to `yylval`. These were addressed by modifying the assignment based on the `%union` definition in the Bison file (`syntaxAna.y`).

### Undefined Reference to `yylval`

To resolve the "undefined reference to `yylval`" error, I ensured that the Bison-generated header file (`syntaxAna.tab.h`) was included in the Lex file.

## Compilation

To compile the project, follow these steps:

1. Execute Flex to generate `lex.yy.c` from `lexicalPhase.l`:
   ```bash
   flex lexicalPhase.l
