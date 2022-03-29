INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

;// value for words
EXTERNDEF wordlist:BYTE

;// functions for logic
SelectRandomWord PROTO ;// outputs pointer to random word in wordlist to act as word chooser
CheckDifference PROTO, word1: BYTE, word2: BYTE ;// gets the number of different characters
CharInWord PROTO, char: BYTE, WordCheck: BYTE ;// check if letter is in word
CharInSamePos PROTO, word1: BYTE, word2: BYTE, pos: BYTE ;// check if letter in same spot

OPTION PROC:PRIVATE
