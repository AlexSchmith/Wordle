.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc
.data
wordlist BYTE "which",0,"there",0,"their",0,"about",0,"would",0,"these",0,"other",0,"words",0,"could",0,"write",0,"first",0,"water",0,"after",0,"where",0,"right",0,"think",0,"three", 0

.code
main PROC PUBLIC
    call Randomize
    mov ecx, 17
    mov esi, 0
    mov edx, OFFSET wordlist
    WordlistLoop:
        ;// mov edx, OFFSET wordlist
        call WriteString
        call Crlf
        add edx, 6 * SIZEOF BYTE
        inc esi
        loop WordlistLoop
    INVOKE ExitProcess, 0
main ENDP
END main
