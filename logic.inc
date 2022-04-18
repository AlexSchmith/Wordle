;// value for words
EXTERNDEF wordlist:BYTE

;// functions for logic
SelectRandomWord PROTO ;// outputs pointer to random word in wordlist to act as word chooser
isWord PROTO, WordCheck: DWORD ;// checks if the given word exists within the list
CharInWord PROTO, Char: BYTE, WordCheck: DWORD ;// check if letter is in word
CharInSamePos PROTO, Char1: BYTE, Char2 : BYTE ;// check if letter in same spot

OPTION PROC:PRIVATE
