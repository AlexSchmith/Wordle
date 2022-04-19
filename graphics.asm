; graphics.asm - module for all graphics
INCLUDE Irvine32.inc
INCLUDE colors.inc
INCLUDE logic.inc
INCLUDE graphics.inc
INCLUDE wordart.inc

.data
ending BYTE "Sorry. The Word of the Day was: ",0
empty BYTE "_____",0
why BYTE "________________________________________________________",0
start_box_h BYTE 15

.code
; Function that checks each character in the word and displays them
; Uses esi for the wod and edi for the word
CheckWord PROC uses eax ecx esi edi, current_word: DWORD, wod: DWORD
    ;use al for each individual char
    mov ecx, 5
    mov esi, current_word
    mov edi, wod
    WordLoop:
        mov al, [esi]
        push [edi]
        push [esi]
        call CharInSamePos
        jne NotCorrect
        mov ebx, 2
        jmp Display
        NotCorrect:
        push wod
        push [esi]
        call CharInWord
        jne Wrong
        mov ebx, 1
        jmp Display
        Wrong:
        mov ebx, 0
        Display:
        push eax
        push ebx
        call DisplayChar
        inc esi
        inc edi
        loop WordLoop
    ret
CheckWord ENDP

; Display the character and whether the character is in the word, in the right position or not in the word
; uses eax for color bg and esi for char
DisplayChar PROC uses ebx eax, color_bg: BYTE, char: BYTE
    cmp ebx, 0
    je wrong
    cmp ebx, 1
    je inword
    push eax
    Correct:
        mov eax, (highlightCorrectPos * 16) + fontColor
        call SetTextColor
        jmp print
    Wrong:
        mov eax, (tableBackground * 16) + fontColor
        call SetTextColor
        jmp print
    InWord:
        mov eax, (highlightCorrectChar * 16) + fontColor
        call SetTextColor
    Print:
        pop eax
        call WriteChar
        add DL, 1
        add DH, 0
        call GotoXY
        mov eax, (white * 16) + black
        call SetTextColor
        ret
DisplayChar ENDP

; Setup display to set background color and move cursor to the right position
SetDisplay PROC uses eax edx
    mov eax, backgroundColor * 17
    call SetTextColor
    call Clrscr
    mov DH, 5
    mov DL, 20
    call GotoXY
    call Wordle

    mov DH, 15
    mov DL, 50
    call    GotoXY
    mov ecx, 6
    BoxLoop:
        mov eax, tableBackground * 17
        call SetTextColor
        push edx
        mov edx, OFFSET empty
        call WriteString
        mov edx, 0
        pop edx
        add DH, 1
        mov DL, 50
        call GotoXY
        loop BoxLoop
    mov DH, 15
    mov DL, 50
    call GotoXY

    mov eax, tableBackground * 17
    call SetTextColor
    ret
SetDisplay ENDP

ClearLine PROC uses edx, tries: DWORD
     
     mov eax, backgroundColor * 17
     call SetTextColor

     mov dl, 55
     mov dh, 15
     add dh, byte ptr [tries]
     call GotoXY

     mov edx, OFFSET why
     call WriteString

     mov dl, 50
     mov dh, 15
     add dh, byte ptr [tries]
     call GotoXY

     mov eax, tableBackground * 17
     call SetTextColor

     mov edx, OFFSET empty
     call WriteString

     ret

ClearLine ENDP

Winner PROC USES eax ebx ecx edx esi
    mov eax, backgroundColor * 17
    call SetTextColor
    call ClrScr
    mov eax, (backgroundColor * 16) + winnerFontColor
    call SetTextColor

    mov BH, 5
    mov BL, 20
    mov ecx, 8
    mov esi, OFFSET waWinner
    LoopWinner:
        mov DH, BH
        mov DL, BL
        call GotoXY
        mov edx, esi
        call WriteString
        inc BH
        add esi, waWinnerRowSize
        loop LoopWinner
    ret
Winner ENDP

Loser PROC USES eax ebx ecx edx esi, wod: DWORD
    mov eax, backgroundColor * 17
    call SetTextColor
    call ClrScr
    mov eax, (backgroundColor * 16) + loserFontColor
    call SetTextColor

    mov BH, 5
    mov BL, 20
    mov ecx, 6
    mov esi, OFFSET waNomaidens
    LoopLoser:
        mov DH, BH
        mov DL, BL
        call GotoXY
        mov edx, esi
        call WriteString
        inc BH
        add esi, waNomaidensRowSize
        loop LoopLoser
    ;// finished printing loser ascii, printing correct word
    mov DH, 20
    mov DL, 40
    call GotoXY
    mov edx, OFFSET ending
    call WriteString
    mov edx, wod
    call WriteString
    ret
Loser ENDP

Wordle PROC USES eax ebx ecx edx esi
    mov eax, (backgroundColor * 16) + wordleFontColor
    call SetTextColor

    mov BH, 5
    mov BL, 20
    mov ecx, 7
    mov esi, OFFSET waWordy
    LoopWordleWA:
        mov DH, BH
        mov DL, BL
        call GotoXY
        mov edx, esi
        call WriteString
        inc BH
        add esi, waWordyRowSize
        loop LoopWordleWA
    ret
Wordle ENDP
END
