INCLUDE logic.inc

.code
;// outputs pointer to random word in wordlist to act as word chooser
SelectRandomWord PROC

SelectRandomWord ENDP
;// gets the number of different characters
CheckDifference PROC, word1: BYTE, word2: BYTE

CheckDifference ENDP
;// check if letter is in word
CharInWord PROC, char: BYTE, WordCheck: BYTE

CharInWord ENDP
;// check if letter in same spot
CharInSamePos PROC, word1: BYTE, word2: BYTE, pos: BYTE

CharInSamePos ENDP
END