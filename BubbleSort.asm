IDEAL

; By I.I

MODEL small

STACK 100h

DATASEG
	
	Array db 2, 5, 1, 3, 5
	len dw $ - Array

CODESEG
    
start: 
	mov ax, @data
	mov ds,ax
	
	call BubbleSort
	call PrintArray
	
exit:
	mov ax, 4c00h
	int 21h
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
 
 ;Temp equ [word ptr bp + 4]
 ;Tlength equ [word ptr bp + 14]
 
 proc BubbleSort
		push [len]
		dec [len]
		mov dx, [len]
		
@@OuterLoop:
        mov cx, dx
        lea si, nums

    @@InnerLoop:
            mov al, [si]
            cmp al, [si+1]
            jl common
            xchg al, [si+1]
            mov [si], al

            common:
                INC si
                loop @@InnerLoop
				
        dec dx
        jnz @@OuterLoop:

		pop [len]
		ret
  endp BubbleSort
	
 
 proc PrintArray
		push bp
		mov bp, sp
		
		mov cx, [word ptr bp + 6]
		mov bx, bp
		add bx, 4
@@Next:
		mov ax, [bx]
		inc bx
		call ShowAxDecimal
		loop @@Next
	
		pop bp
		ret 4
 endp PrintArray
 
 
;============================================================================
; Description - Write on screen the value of ax (decimal)
;               the practice :  
;				Divide AX by 10 and put the Mod on stack 
;               Repeat Until AX smaller than 10 then print AX (MSB) 
;           	then pop from the stack all what we kept there and show it. 
; INPUT: AX
; OUTPUT: Screen 
; Register Usage: AX  
;============================================================================
proc ShowAxDecimal
       push ax
	   push bx
	   push cx
	   push dx
	   jmp PositiveAx
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