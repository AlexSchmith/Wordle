INCLUDE logic.inc

.code
;// outputs pointer to random word in wordlist to act as word chooser
SelectRandomWord PROC USES eax
    mov eax, 18
    call RandomRange
    mov edx, OFFSET wordlist
    add edx, 6 * eax * SIZEOF BYTE
    ret
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