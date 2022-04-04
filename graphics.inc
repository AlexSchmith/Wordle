


; wod = word of day
; iterate through the word and for each char return 
CheckWord PROTO, current_word: BYTE, wod: BYTE

; Takes in the result of a character and the character itself
; color_bg is 0 for not in word, 1 for in word, and 2 for in correct position and in word
DisplayChar PROTO, color_bg: BYTE, char: BYTE
;DisplayChar PROTO, uses eax edx

; Changes the background and sets the cursor to the right position
SetDisplay PROTO

OPTION PROC:PRIVATE
