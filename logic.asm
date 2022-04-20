INCLUDE irvine32.inc
INCLUDE logic.inc
INCLUDE wordlist.inc

.code
; outputs pointer to random word in wordlist to act as word chooser
SelectRandomWord PROC USES eax ebx
    mov eax, wordlistSize
    call RandomRange
    ; saving random num in ebx
    mov ebx, eax
    mov eax, 6
    ; multiplying eax with ebx
    mul ebx
    mov edx, OFFSET wordlist
    ; adding offset
    add edx, eax
    ret
SelectRandomWord ENDP
; check if letter is in word
CharInWord PROC USES eax ecx esi, Char: BYTE, WordCheck : DWORD
    ; set limit of loop to 5. The max number of characters to a word
    mov ecx, 5
    mov esi, WordCheck
    CharInWordLoop:
        ; loop through each letter
        mov ah, [esi]
        cmp ah, Char
        ; if chars are equal, go to end. leave cmp value to true
        je CharInWordEnd
        inc esi
        loop CharInWordLoop
    ; if never equal, last cmp statement gives false
    CharInWordEnd:
    ret
CharInWord ENDP
; check if letter in same spot
CharInSamePos PROC USES eax, Char1: BYTE, Char2 : BYTE
    ; simply compare two characters
    mov ah, Char1
    cmp ah, Char2
    ; leave values from cmp to return true or false
    ret
CharInSamePos ENDP
; checks if the given word exists within the list
isWord PROC USES eax ecx, WordCheck: DWORD
    mov ecx, wordlistSize
    mov eax, OFFSET wordlist
    isWordLoop:
        push WordCheck
        push eax
        call Str_compare
        je isWordInList
        add eax, 6
        loop isWordLoop
    isWordInList:
        ret
isWord ENDP
END