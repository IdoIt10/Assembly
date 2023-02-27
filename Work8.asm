;
; here write your ID. DOnt forget the name of the file should be your id . asm
; ID  = 209771344

; For tester:
; Tester name = The Joz
; Tester Total Grade = 

 
;---------------------------------------------
; 
; Skelatone Solution for Chapter 8 Work
;  
;----------------------------------------------- 


IDEAL

MODEL small

	stack 256
DATASEG
		 
		 ; Ex1 Variables 
		 aTom db 13 dup(?)  ; example to varible for exercise 1
		 Len1 db $ - aTom
		  
		 ; Ex2 Variables 
		 Array2 db 10 dup(?)
		 Len2 db $ - Array2
		 
		 ; Ex3 Variables 
		 Array3 db 10 dup(?)
		 Len3 db $ - Array3

		 ; Ex4 Variables 
		 Array4 db 101 dup(?)
		 Len4 db $ - Array4
		 
		 ; Ex5 Variables 
		 BufferFrom5 db 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
		 BufferTo5 db 10 dup(?)
		 Len5 db $ - BufferTo5
		 
		 ; Ex6 Variables 
		 BufferFrom6 db 14, 15, 10, 8, 6, 4, 2, -2, -4, -8, 14, 15, 10, 8, 6, 4, 2, -2, -4, -8, 14, 15, 10, 8, 6, 4, 2, -2, -4, -8, 14, 15, 10, 8, 6, 4, 2, -2, -4, -8, 14, 15, 10, 8, 6, 4, 2, -2, -4, -8
		 Len6 db $ - BufferFrom6
		 BufferTo6Len db 0
		 BufferTo6 db ?
		 
		 ; Ex7a Variables 
		 MyLine7 db 1, 2, 3, 4, 5, 13, 6
		 MyLine7Length db ?
		 
		 ; Ex7b Variables
		 MyWords7 dw 1, 2, 3, 4, 5, 0DDDDh, 6
		 MyWords7Length db ?
		 
		 ; Ex8 Variables
		 MyQ8 db 101, 130,30,201, 120, -3,100,255,0
		 
		 ; Ex9 Variables
		 MySet9 dw 1, 2, 3, -2, 0, 0FFFFh
		 Count1 db 0
		 Count2 db 0
		 Count3 db 0
		 
		 ; Ex11 Variables 
		 EndGates11 db 01001000b
		 BothOff db "both 7 and 8 are false$"
		 AtLeastOneOn db "at least one of the bits 7 , 8 - true$"
		 
		 ; Ex13 Variables
		 Word13 db "926!"
		 WordNum13 dw ?
		 
CODESEG

start:
		mov ax, @data
		mov ds,ax

		; next 5 lines: example how to use ShowAxDecimal (you can delete them)
	;	mov al, 73
	;	mov ah,0
	;	call ShowAxDecimal		 
	;	mov ax, 0ffffh
	;	call ShowAxDecimal

		

		call ex1
	 
		call ex2
	 
		call ex3
	 
		call ex4
	 
		call ex5
	 
		call ex6
	 
		call ex7a
		
		call ex7b
	 
		call ex8
	 
		call ex9
	 
		call ex10
	 
		call ex11
	 
		call ex12
	 
		call ex13
		
		call ex14a
	 
		mov ax, 0F70Ch  
 		call ex14c     ; this will call to ex14b and ex14a
		
exit:
		mov ax, 04C00h
		int 21h

		
		
;------------------------------------------------
;------------------------------------------------
;-- End of Main Program ... Start of Procedures 
;------------------------------------------------
;------------------------------------------------





;=====================================================
; Description -  Move 'a' -> 'm'  to variable at DSEG 
; INPUT: None
; OUTPUT: array on Dataseg name : aTom
; Register Usage: bx, al, cl
;=====================================================
proc ex1

	mov bx, offset aTom
    mov al, 'a'
	mov cl, [Len1]
	
@@Next:
	mov [byte ptr bx], al ; Puts letters in aTom according to place
	inc al
	inc bx
	loop @@Next
	
    ret
endp ex1




;=================================================
; Description -  Move 0 -> 9  to variable at DSEG 
; INPUT: None
; OUTPUT: array on Dataseg name : Array2
; Register Usage: bx, al, cl
;=================================================
proc ex2
    
	mov bx, offset Array2
    mov al, '0'
	mov cl, [Len2]
	
@@Next:
	mov [byte ptr bx], al ; Puts digits as characters in Array2 according to place
	inc al
	inc bx
	loop @@Next
	
    ret
endp ex2




;================================================
; Description -  Move numbers 0 -> 9  to variable
; INPUT: None
; OUTPUT: array on Dataseg name : Array3
; Register Usage: bx, al, cl 
;================================================
proc ex3
      
	mov bx, offset Array3
    mov al, 0
	mov cl, [Len3]
	
@@Next:
	mov [byte ptr bx], al ; Puts digits in Array2 according to place
	inc al
	inc bx
	loop @@Next
	
    ret
endp ex3




;================================================
; Description: Move CCh to variable where place
;			   is odd or devides by 7
; INPUT:  None
; OUTPUT:  array on Dataseg name : Array4
; Register Usage: bx, cl, dl
;================================================
proc ex4
      
	mov bx, offset Array4
	mov cl, [Len4]
	mov dl, 7
	  
@@Next:
	mov ax, bx
	div dl
	cmp ah, 0
	jz @@PutCC
	test bx, 1 ; Checking least significant bit
	jne @@PutCC ; jump to @@PutCC if odd number
	jmp @@endLoop
	
@@PutCC:
	mov [byte ptr bx], 0CCh ; Put 0CCh in place bx
		  
@@endLoop:
	inc bx
	Loop @@Next
	  
    ret
endp ex4


;================================================
; Description: Move all values from an
;			   array to another array
; INPUT:  array on Dataseg name : BufferFrom5
; OUTPUT:  array on Dataseg name : BufferTo5
; Register Usage: bx, cl 
;================================================
proc ex5
      
	mov bx, 0
	mov cl, [Len5]
	
@@Next:
	mov dl, [BufferFrom5 + bx]
	mov [BufferTo5 + bx], dl ; Puting in new array values according to place in origin array
	inc bx
	loop @@Next
	  
    ret
endp ex5




;================================================
; Description: Move values greater than 12 
;			   from an array to another array
; INPUT:  array on Dataseg name : BufferFrom6
; OUTPUT:  array on Dataseg name : BufferTo6
; Register Usage: bx, si, cl, dl
;================================================
proc ex6
      
	mov bx, 0
	mov si, 0
	mov cl, [Len6]
	
@@Next:
	mov dl, [BufferFrom6 + bx]
	cmp dl, 12 ; Compering current value in array with 12
	jg @@Put
	jl @@NoPut
	  
@@Put:
	mov [BufferTo6 + si], dl
	inc [BufferTo6Len]
	inc si
	inc bx
	loop @@Next
			
@@NoPut:
	inc bx
	loop @@Next
	
    ret
endp ex6




;===================================================
; Description: Find length of an array end with 13d
; INPUT:  array on Dataseg name : MyLine7
; OUTPUT:  variable on Dataseg name : MyLine7Length
; Register Usage: bx
;===================================================
proc ex7a
	
	xor bx, bx
	
@@Next:
	cmp[byte ptr MyLine7 + bx], 13 ; Compering current value in array with 13
	je @@End
	inc bx
	jmp @@Next
			
@@End:
	mov [MyLine7Length], bl
	
    ret
endp ex7a




;================================================
; Description: Find length of an array end with 0DDDDh
; INPUT:  array on Dataseg name : MyWords7
; OUTPUT:  variable on Dataseg name : MyWords7Length
; Register Usage: bx, cl
;================================================
proc ex7b
      
	xor bx, bx
	
@@Next:
	cmp[word ptr MyWords7 + bx], 0DDDDh ; Compering current value in array with 0DDDDh
	je @@End
	add bx, 2
	jmp @@Next
			
@@End:
	xor ah, ah
	mov al, bl
	mov dl, 2
	div dl
	mov [byte ptr MyWords7Length], al
	  
    ret
endp ex7b




;================================================
; Description: Calculate the sum of nums in an
;			   array that ends with 0 that are
;			   greater than 100 and print it in decimal
; INPUT:  array on Dataseg name : MyQ8
; OUTPUT:  ax
; Register Usage: ax, bx, cl
;================================================
proc ex8
    
	mov ax, 0
	mov cl, 0
	mov bx, -1
	
@@Next:
	inc bx
	cmp[MyQ8 + bx], 0 ; Compering current value in array with 0
	je @@End
	cmp[MyQ8 + bx], 100 ; Compering current value in array with 100
	jg @@Add
	jmp @@Next
		
@@Add:
	add al, [MyQ8 + bx]
	jmp @@Next
		
@@End:	
	call ShowAxDecimal
	  
    ret
endp ex8




;================================================
; Description: Count the positive, negative and 
;			   zero values ​​from the array and put
;			   them into Counter1, Counter2 and
;			   Counter3 respectively
; INPUT:  array on Dataseg name : MySet9
; OUTPUT:  Count1, Count2, Count3
; Register Usage: bx, cl
;================================================
proc ex9
	
	mov cl, 0
	mov bx, -2
	
@@Next:
	add bx, 2
	cmp[MySet9 + bx], 0FFFFh ; Compering current value in array with 0FFFFh
	je @@End
	cmp[MySet9 + bx], 0 ; Compering current value in array with 0
	je @@AddCount3
	jg @@AddCount1
	jng @@AddCount2
		
@@AddCount1:
	inc [Count1] ; Increase counter of positive
	jmp @@Next
	
@@AddCount2:
	inc [Count2] ; Increase counter of negative
	jmp @@Next
	
@@AddCount3:
	inc [Count3] ; Increase counter of zero
	jmp @@Next
		
@@End:
	
    ret
endp ex9




;================================================
; Description: Print AL binary with B at the end
; INPUT:  AL
; OUTPUT:  AL binary and B at the end
; Register Usage: cx, al, bl, cx
;================================================
proc ex10

	mov cx, 8
	mov al, 7
	mov bl, al
	
@@Loop:
	shl bl, 1
	jc @@one
	
@@zero:
	mov dl, '0'
	jmp @@next
	
@@one:
	mov dl, '1'
	
@@next:
	mov ah, 2
	int 21h
	loop @@Loop
	mov ah, 2
	mov dl, 'B'
	int 21h
	
    ret
endp ex10




;================================================
; Description: Check if both 7 and 8 bits in
;			   given variable are off
; INPUT:  EndGates11
; OUTPUT:  BothOff/AtLeastOneOn
; Register Usage: bl, dx, ah
;================================================
proc ex11

	mov bl, [byte ptr EndGates11] 
	and bl, 00000011b
	jne @@AtLeastOne

@@Both:
	mov dx, offset BothOff
	jmp @@End
	
@@AtLeastOne:
	mov dx, offset AtLeastOneOn
	
@@End:
	mov ah, 9
	int 21h
	
    ret
endp ex11




;================================================
; Description: Place in address 0B000h the value
;			   in address 000Ah only if it is
;			   between 10 and 70 inclusive
; INPUT:  000Ah
; OUTPUT:  0B000h
; Register Usage: ax
;================================================
proc ex12
	
	cmp [byte ptr ds:000Ah], 10
	je @@Equel
	jg @@Greater
	jmp @@End
	
@@Greater:
	cmp [byte ptr ds:000Ah], 70
	jle @@Equel
	jg @@End
	
	
@@Equel:
	mov ax, [0A000h]
	mov [0B000h], ax
	
@@End:

    ret
endp ex12




;================================================
; Description: Converting a string ending in !
;			   or 5 characters length to a number
; INPUT:  Word13
; OUTPUT:  WordNum13
; Register Usage: cl, si, di, ax, bx
;================================================
proc ex13
    
	mov cl, 6
	mov si, -1
	mov di, 10
	xor ax, ax
	xor bx, bx
	
@@Next:
	inc si
	cmp [byte ptr Word13 + si], "!" ; Compering current value in array with "!"
	je @@End
	
@@Loop:
	mov bl, [byte ptr Word13 + si]
	mul di
	sub bl, '0'
	add ax, bx
	loop @@Next
	
@@End:
	mov [word ptr WordNum13], ax
	
    ret
endp ex13




;================================================
; Description: Prints one hexadecimal digit according
;			   to the lower four bitsof AL
; INPUT:  al
; OUTPUT:  one hexadecimal digit according
;		   to the lower four bitsof AL
; Register Usage: ax, bl
;================================================
proc ex14a
	
	push ax
	and al, 0fh
	cmp al, 9
	jg @@Dig
	
@@Num:
	mov bl, al
	add bl, '0'
	jmp @@End
	
@@Dig:
	mov bl, al
	sub bl, 10
	add bl, 'A'
	jmp @@End
	
@@End:
	mov dl, bl
	mov ah, 2
	int 21h
	pop ax
	
    ret
endp ex14a




;================================================
; Description: Prints two hexadecimal digit 
;			   according to AL
; INPUT:  al
; OUTPUT:  two hexadecimal digit according to AL
; Register Usage: al
;================================================
proc ex14b

	rol al, 4 ; Swich digits in al
	call ex14a
	rol al, 4 ; Swich digits in al
	call ex14a
	
    ret
endp ex14b




;================================================
; Description: Prints four hexadecimal digit 
;			   according to AX
; INPUT:  ax
; OUTPUT:  four hexadecimal digit according to AX
; Register Usage: ax
;================================================
proc ex14c
    
	rol ax, 8 ; Swich digits in ax
	call ex14b
	rol ax, 8 ; Swich digits in ax
	call ex14b
	
    ret
endp ex14c












;================================================
; Description - Write on screen the value of ax (decimal)
;               the practice :  
;				Divide AX by 10 and put the Mod on stack 
;               Repeat Until AX smaller than 10 then print AX (MSB) 
;           	then pop from the stack all what we kept there and show it. 
; INPUT: AX
; OUTPUT: Screen 
; Register Usage: AX  
;================================================
proc ShowAxDecimal
       push ax
	   push bx
	   push cx
	   push dx
	   
	   ; check if negative
	   test ax,08000h
	   jz PositiveAx
			
	   ;  put '-' on the screen
	   push ax
	   mov dl,'-'
	   mov ah,2
	   int 21h
	   pop ax

	   neg ax ; make it positive
PositiveAx:
       mov cx,0   ; will count how many time we did push 
       mov bx,10  ; the divider
   
put_mode_to_stack:
       xor dx,dx
       div bx
       add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
       push dx    
       inc cx
       cmp ax,9   ; check if it is the last time to div
       jg put_mode_to_stack

	   cmp ax,0
	   jz pop_next  ; jump if ax was totally 0
       add al,30h  
	   mov dl, al    
  	   mov ah, 2h
	   int 21h        ; show first digit MSB
	       
pop_next: 
       pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   mov dl, al
       mov ah, 2h
	   int 21h        ; show all rest digits
       loop pop_next
		
	   mov dl, ','
       mov ah, 2h
	   int 21h
   
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
endp ShowAxDecimal



END start