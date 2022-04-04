; graphics.asm - module for all graphics
INCLUDE Irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.code

; Function that checks each character in the word and displays them
; Uses esi for the wod and edi for the word
CheckWord PROC, current_word: BYTE, wod: BYTE
	
	;mov esi, 0
    ;mov al, [current_word+esi]
    ;push eax
    
	;mov ebx, testbg
    ;push ebx
    ;call DisplayChar

	mov eax, 5
	add eax, 6

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
	
	correct:
		mov eax, white + (green * 16)
		call SetTextColor
		jmp print
	wrong:
		mov eax, white + (lightGray * 16)
		call SetTextColor
		jmp print
	inword:
		mov eax, white + (yellow* 16)
		call SetTextColor
	print:
		pop eax
		call WriteChar
		add DL, 5
		add DH, 0
		call GotoXY
		mov eax, black + (white * 16)
		call SetTextColor
		ret 

DisplayChar ENDP

; Setup display to set background color and move cursor to the right position
SetDisplay PROC

	mov eax, Gray + (white * 16)
	call SetTextColor
	call Clrscr
	mov DH, 10
    mov DL, 30
    call    GotoXY
	
	ret

SetDisplay ENDP


END
