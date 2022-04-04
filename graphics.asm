; graphics.asm - module for all graphics
INCLUDE Irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc

ExitProcess PROTO, dwExitCode: DWORD

.code

; Function that checks each character in the word and displays them
; Uses esi for the wod and edi for the word
CheckWord PROC uses esi edi, current_word: DWORD, wod: DWORD
	
	;use al for each individual char
	mov ecx, 5
	mov esi, current_word
	WordLoop:
		mov ah, [esi]
		push eax
		mov ebx, 2 ; set to yellow
		push ebx
		call DisplayChar
		inc esi

		jmp WordLoop

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
		mov eax, white + (green * 16)
		call SetTextColor
		jmp print
	Wrong:
		mov eax, white + (lightGray * 16)
		call SetTextColor
		jmp print
	InWord:
		mov eax, white + (yellow* 16)
		call SetTextColor
	Print:
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
