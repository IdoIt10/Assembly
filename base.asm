IDEAL

; programer name :   base.asm by yossi

MODEL small

STACK 100h

DATASEG
    
	var1 db 6
	var2 dw 6
	var3  db -6
	name1 db "Yossix 6"
	var5  db '6'
	var6  db 54
 	var7  db 'Six'
	var8 db 36h
	var9 dw 13878
	var10 db 0FAh
	var11 db 45,54
	

CODESEG

    
start: 
	mov ax, @data
	mov ds,ax
	 
	mov ax,[var2]
	
	call ShowAxDecimal
	 
	 
	 
		
exit:
	mov ax, 4c00h
	int 21h
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
 
 
 
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


