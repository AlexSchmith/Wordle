# Wordle in assembly

*Made by Alex Schmith and Nick Cottrell*

## What is this

This is a recreation of the game wordle in assembly. Because of how small and
compact the program is, there is only a small list of potential words that it
can be (for now!) It works just like the wordle online.

## How do I install this

You will need to build the executable with visual studio. All the necessary
components should be referenced in the project. You will need to install the
irvine32 libraries manually in order to compile this. Once that is done, just
run `build` and youre good to go.

## How do I play

Once you run your EXE, you play it the same way that you play wordle. You have
6 chances to guess the correct word. It will give you green highlights for
letters that are in the right spot and cyan highlights for letters that are in
the word but not in the right position.