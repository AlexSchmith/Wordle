INCLUDE irvine32.inc
INCLUDE logic.inc

.code
;// outputs pointer to random word in wordlist to act as word chooser
SelectRandomWord PROC USES eax
    mov eax, 18
    call RandomRange
    mov edx, OFFSET wordlist
    add edx, 6 * SIZEOF BYTE
    ret
SelectRandomWord ENDP
;// check if letter is in word
CharInWord PROC, char: BYTE, WordCheck: BYTE
    ret
CharInWord ENDP
;// check if letter in same spot
CharInSamePos PROC USES eax, word1: BYTE, word2 : BYTE
    mov ah, word1
    cmp ah, word2
    ret
CharInSamePos ENDP
END