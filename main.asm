.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc
INCLUDE colors.inc

.data
wod DWORD ?
bufferWord BYTE 7 DUP (?), 0
tries BYTE 0
square_length BYTE 50
square_height BYTE 15
try_again BYTE "Press y to try again",0

.code
main PROC PUBLIC
    ; start by getting random word
    call Randomize
    GameOn:
        call SelectRandomWord
        mov wod, edx
        mov tries, 0
        ; setting display
        call SetDisplay
    LoopRows:
        mov dh, square_height
        add dh, tries
        mov dl, square_length
        call GotoXY ; dont need to set position because theyre already set
        ; getting word input
        mov ecx, 7
        mov edx, OFFSET bufferWord
        mov eax, (tableBackground * 16) + fontColor
        call SetTextColor
        call ReadString
        ; checking that inputed string is correct size
        cmp eax, 5
        jne Error
        ; checking that word is in dictionary
        push OFFSET bufferWord
        call isWord
        jne Error
        jmp LoopNoError
        Error:
            ; display line too short
            movzx ebx, tries
            push ebx
            call ClearLine
            call DisplayError
            jmp DoLoopRows
        DoLoopRows:
            loop LoopRows
        LoopNoError:
        ; moving cursor back to beginning of line
        mov dh, square_height
        add dh, tries
        mov dl, square_length
        call GotoXY ; dont need to set position because theyre already set
        push wod
        push OFFSET bufferWord
        call CheckWord
        push wod
        push OFFSET bufferWord
        call Str_compare
        je DisplayWinner
        inc tries
        cmp tries, 6
        je DisplayLoser
        ; move cursor down 1 row
        jmp DoLoopRows
    ; gone through tries, you have lost
    DisplayLoser:
        push wod
        call Loser
        jmp Stop
    DisplayWinner:
        ; looks like theyve won. Time to show it
        call Winner
    Stop:
        mov dl, 25
        mov dh, 25
        call GotoXY
        mov eax, fontColor
        call SetTextColor
        mov edx, OFFSET try_again
        call WriteString
        call ReadChar
        cmp al, 'y'
        je GameOn
        INVOKE ExitProcess, 0
main ENDP
END main
