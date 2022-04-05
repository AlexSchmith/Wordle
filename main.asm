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

.code
main PROC PUBLIC
    ;// start by getting random word
    call Randomize
    call SelectRandomWord
    mov wod, edx
    ;// setting display
    call SetDisplay
    LoopRows:
        ;// getting word input
        mov ecx, 5
        mov edx, OFFSET bufferWord
        call ReadString
        ;// moving cursor back to beginning of line
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
        ;// move cursor down 1 row
        inc DH
        call GotoXY
        jl LoopRows
    ;// gone through tries, you have lost
    call Loser
    jmp Stop
    DisplayWinner:
        ;// looks like theyve won. Time to show it
        call Winner
    Stop:
        INVOKE ExitProcess, 0
main ENDP
END main
