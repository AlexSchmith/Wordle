.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc

.data
MAX = 5

wordlist BYTE "which",0,"there",0,"their",0,"about",0,"would",0,"these",0,"other",0,"words",0,"could",0,"write",0,"first",0,"water",0,"after",0,"where",0,"right",0,"think",0,"three", 0
testword BYTE "light"
input BYTE 6 DUP (?)


.code
main PROC PUBLIC
    
    call SetDisplay
    call Randomize
    
    mov ecx, 5
    mov edx, OFFSET input
    call ReadString

    mov DH, 15
    mov DL, 50
    call GotoXY

    push OFFSET wordlist
    push OFFSET input
    call CheckWord
    mov eax, 10000
    call Delay

    mov edx, 0

    mov ecx, 17
    mov esi, 0
    mov edx, OFFSET wordlist
   
    call SelectRandomWord
    
    push edx
    mov DH, 50
    mov DL, 0
    call GotoXY
    pop edx
    
    push edx
    call Loser
    mov DH, 30
    mov DL, 0
    call GotoXY
    call Winner
    mov DH, 30
    mov DL, 0
    call GotoXY
 
    INVOKE ExitProcess, 0
main ENDP
END main
