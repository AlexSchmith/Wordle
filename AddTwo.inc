INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

DumpRegs PROTO
AddTwo@8 PROTO


EXTERNDEF sum:DWORD
OPTION PROC:PRIVATE

