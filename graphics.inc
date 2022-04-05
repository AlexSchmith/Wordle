


; wod = word of day
; iterate through the word and for each char return 
CheckWord PROTO, current_word: DWORD, wod: DWORD

; Takes in the result of a character and the character itself
; color_bg is 0 for not in word, 1 for in word, and 2 for in correct position and in word
DisplayChar PROTO, color_bg: BYTE, char: BYTE



; Changes the background and sets the cursor to the right position also creates a box and ascii art
SetDisplay PROTO
; ASCII art with results and title screen
Winner PROTO
Loser PROTO, wod: DWORD
Wordle PROTO

OPTION PROC:PRIVATE
