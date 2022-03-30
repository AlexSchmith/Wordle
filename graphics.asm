; CheckWord.asm - checks word to see if it is a wordle.
INCLUDE Irvine32.inc
;INCLUDE logic.inc
INCLUDE graphics.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
graphics proc
	mov	eax,5				
	add	eax,6				

	invoke ExitProcess,0
graphics endp


end 
