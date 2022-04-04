INCLUDE irvine32.inc
INCLUDE logic.inc

.code
;// outputs pointer to random word in wordlist to act as word chooser
SelectRandomWord PROC USES eax ebx
    mov eax, 18
    call RandomRange
    ;// saving random num in ebx
    mov ebx, eax
    mov eax, 6
    ;// multiplying eax with ebx
    mul ebx
    mov edx, OFFSET wordlist
    ;// adding offset
    add edx, eax
    ret
SelectRandomWord ENDP
;// check if letter is in word
CharInWord PROC USES eax ecx esi, Char: BYTE, WordCheck : DWORD
    mov ecx, 5
    mov esi, WordCheck
    CharInWordLoop:
        mov ah, [esi]
        cmp ah, Char
        je CharInWordEnd
        inc esi
        loop CharInWordLoop
    CharInWordEnd:
    ret
CharInWord ENDP
;// check if letter in same spot
CharInSamePos PROC USES eax, Char1: BYTE, Char2 : BYTE
    mov ah, word1
    cmp ah, word2
    ret
CharInSamePos ENDP
END