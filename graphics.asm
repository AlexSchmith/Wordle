; graphics.asm - module for all graphics
INCLUDE Irvine32.inc
INCLUDE logic.inc
INCLUDE graphics.inc

ExitProcess PROTO, dwExitCode: DWORD

.data

winners BYTE "$$\     $$\                                                           ", 0
winner1 BYTE "\$$\   $$  |                                                          ", 0
winner2 BYTE " \$$\ $$  /$$$$$$\  $$\   $$\       $$\  $$\  $$\  $$$$$$\  $$$$$$$\  ", 0
winner3 BYTE "  \$$$$  /$$  __$$\ $$ |  $$ |      $$ | $$ | $$ |$$  __$$\ $$  __$$\ ", 0
winner4 BYTE "   \$$  / $$ /  $$ |$$ |  $$ |      $$ | $$ | $$ |$$ /  $$ |$$ |  $$ |", 0
winner5 BYTE "    $$ |  $$ |  $$ |$$ |  $$ |      $$ | $$ | $$ |$$ |  $$ |$$ |  $$ |", 0
winner6 BYTE "    $$ |  \$$$$$$  |\$$$$$$  |      \$$$$$\$$$$  |\$$$$$$  |$$ |  $$ |", 0
winner7 BYTE "    \__|   \______/  \______/        \_____\____/  \______/ \__|  \__|", 0




wordy 	BYTE " ___       __   ________  ________  ________  ___       _______      ",0
wordy1	BYTE "|\  \     |\  \|\   __  \|\   __  \|\   ___ \|\  \     |\  ___ \     ",0
wordy2	BYTE "\ \  \    \ \  \ \  \|\  \ \  \|\  \ \  \_|\ \ \  \    \ \   __/|    ",0
wordy3	BYTE " \ \  \  __\ \  \ \  \\\  \ \   _  _\ \  \ \\ \ \  \    \ \  \_|/__  ",0
wordy4	BYTE "  \ \  \|\__\_\  \ \  \\\  \ \  \\  \\ \  \_\\ \ \  \____\ \  \_|\ \ ",0
wordy5	BYTE "   \ \____________\ \_______\ \__\\ _\\ \_______\ \_______\ \_______\",0
wordy6	BYTE "    \|____________|\|_______|\|__|\|__|\|_______|\|_______|\|_______|",0

nomaidens  BYTE " _   _        ___  ___      _     _                ",0
nomaidens1 BYTE "| \ | |       |  \/  |     (_)   | |               ",0
nomaidens2 BYTE "|  \| | ___   | .  . | __ _ _  __| | ___ _ __  ___ ",0
nomaidens3 BYTE "| . ` |/ _ \  | |\/| |/ _` | |/ _` |/ _ \ '_ \/ __|",0
nomaidens4 BYTE "| |\  | (_) | | |  | | (_| | | (_| |  __/ | | \__ \",0
nomaidens5 BYTE "\_| \_/\___/  \_|  |_/\__,_|_|\__,_|\___|_| |_|___/",0
nomaidens6 BYTE "                                                   ",0

ending 	BYTE "Sorry. The Word of the Day was ",0 


empty BYTE "MEME"  

start_box_h BYTE 15

.code

; Function that checks each character in the word and displays them
; Uses esi for the wod and edi for the word
CheckWord PROC uses eax ecx esi edi, current_word: DWORD, wod: DWORD
	
	;use al for each individual char
	mov ecx, 5
	mov esi, current_word
	mov edi, wod
	WordLoop:
		mov al, [esi]
		push [edi]
		push [esi]
		call CharInSamePos
	
		jne NotCorrect
		mov ebx, 2
		jmp Display

		NotCorrect:
		push wod
		push [esi]
		call CharInWord
		jne Wrong
		mov ebx, 1
		jmp Display
		
		Wrong:
		mov ebx, 0
	
		Display:
		push eax
		push ebx
		call DisplayChar
		inc esi
		inc edi
		loop WordLoop

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
		mov eax, white + (lightGreen * 16)
		call SetTextColor
		jmp print
	Wrong:
		mov eax, white + (lightGray * 16)
		call SetTextColor
		jmp print
	InWord:
		mov eax, white + (lightCyan * 16)
		call SetTextColor
	Print:
		pop eax
		call WriteChar
		add DL, 1
		add DH, 0
		call GotoXY
		mov eax, black + (white * 16)
		call SetTextColor
		ret 

DisplayChar ENDP

; Setup display to set background color and move cursor to the right position
SetDisplay PROC uses eax
	
	mov eax, gray + (white * 16)
	call SetTextColor

	call Clrscr
	mov DH, 5
	mov DL, 20
	call GotoXY

	call Wordle
	
	mov DH, 15
    mov DL, 50
    call    GotoXY

	mov eax, gray + (gray * 16)
	call SetTextColor

	mov esi, 0
	mov ecx, 6
	sub DH, 1
	
	BoxLoop:
		mov eax, gray + (gray * 16)
		call SetTextColor
		push edx

		mov edx, OFFSET empty
		call WriteString
		mov edx, 0

		pop edx
		mov eax, white + (white * 16)
		call SetTextColor

		add DH, 1
		mov DL, 50
		call GotoXY

		inc esi
		loop BoxLoop
	
	mov DH, 15
	mov DL, 50
	call GotoXY

	ret

SetDisplay ENDP



Winner PROC
	mov eax, white + (white * 16)
	call SetTextColor
	call ClrScr

	mov eax, green + (white * 16)
	call SetTextColor

	mov DH, 5
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winners
	call WriteString

	mov DH, 6
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner1
	call WriteString

	mov DH, 7
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner2
	call WriteString
	
	mov DH, 8
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner3
	call WriteString
	
	mov DH, 9
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner4
	call WriteString

	mov DH, 10
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner5
	call WriteString

	mov DH, 11
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner6
	call WriteString


	mov DH, 12
	mov DL, 20
	call GotoXY

	mov edx, OFFSET winner7
	call WriteString

	ret
	
Winner ENDP

Loser PROC, wod: DWORD
	mov eax, white + (white * 16)
	call SetTextColor
	call ClrScr

	mov eax, lightRed + (white * 16)
	call SetTextColor

	mov DH, 5
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens
	call WriteString

	mov DH, 6
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens1
	call WriteString

	mov DH, 7
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens2
	call WriteString
	
	mov DH, 8
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens3
	call WriteString
	
	mov DH, 9
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens4
	call WriteString

	mov DH, 10
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens5
	call WriteString

	mov DH, 11
	mov DL, 20
	call GotoXY

	mov edx, OFFSET nomaidens6
	call WriteString

	mov DH, 20
	mov DL, 40
	call GotoXY

	mov edx, OFFSET ending
	call WriteString
	mov edx, wod
	call WriteString

	ret

Loser ENDP




Wordle PROC
	mov eax, lightGreen + (white * 16)
	call SetTextColor

	
	mov edx, OFFSET wordy
	call WriteString
	

	mov DH, 6
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy1
	call WriteString
	

	mov DH, 7
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy2
	call WriteString
	

	mov DH, 8
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy3
	call WriteString
	

	mov DH, 9
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy4
	call WriteString


	mov DH, 10
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy5
	call WriteString


	mov DH, 11
	mov DL, 20
	call GotoXY

	mov edx, OFFSET wordy6
	call WriteString
	

	mov DH, 12
	mov DL, 20
	call GotoXY

	ret

Wordle ENDP



END
