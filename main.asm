.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc

.data


wordlist BYTE "which",0,"there",0,"their",0,"about",0,"would",0,"these",0,"other",0,"words",0,"could",0,"write",0,"first",0,"water",0,"after",0,"where",0,"right",0,"think",0,"three", 0
wod DWORD ?
bufferWord BYTE 6 DUP (?), 0
tries BYTE 0
square_length BYTE 50
square_height BYTE 15

.code
main PROC PUBLIC
    ;// start by getting random word
    call Randomize
    call SelectRandomWord
    mov wod, edx
    ;// setting display
    call SetDisplay
    LoopRows:
        mov DH, square_height
        add DH, tries
        mov DL, square_length
        call GotoXY ;// dont need to set position because theyre already set
        ;// getting word input
        mov ecx, 6
        mov edx, OFFSET bufferWord
        mov eax, white + (gray * 16)
        call SetTextColor
        call ReadString
        ;// moving cursor back to beginning of line
        mov DH, square_height
        add DH, tries
        mov DL, square_length
        call GotoXY ;// dont need to set position because theyre already set
        push wod
        push OFFSET bufferWord
        call CheckWord
        push wod
        push OFFSET bufferWord
        call Str_compare
        je DisplayWinner
        inc tries
        cmp tries, 5
        je DisplayLoser
        ;// move cursor down 1 row
        loop LoopRows
    ;// gone through tries, you have lost
    DisplayLoser:
        push wod
        call Loser
        jmp Stop
    DisplayWinner:
        ;// looks like theyve won. Time to show it
        call Winner
    Stop:
        INVOKE ExitProcess, 0
main ENDP
END main
