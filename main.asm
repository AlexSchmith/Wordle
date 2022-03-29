.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
wordlist BYTE 100 (?)

.code
main PROC PUBLIC

    INVOKE ExitProcess, 0
main ENDP
END main
