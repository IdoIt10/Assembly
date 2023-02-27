IDEAL

; By I.I

MODEL small

STACK 100h

DATASEG
	string db "abcdef"
	len db $-string
	rev db 6 dup(?)
	
CODESEG
    
start: 
	mov ax, @data
	mov ds,ax
	
	call reverse
	
exit:
	mov ax, 4c00h
	int 21h
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
 
 
proc reverse
	 push cx
	 push si
	 push es
	 push di
	 push ax
	 push bx
	 xor bx, bx
	 xor ch, ch
	 mov cl, [len]
	 push cx
	 
@@Next:
	 cmp [len], 0
	 je @@End
	 
	 xor ah, ah
	 
	 mov cx, 1
	 mov cx, 1
	 mov si, offset string
	 add si, bx
	 push ds
	 pop es
	 mov di, offset rev
	 dec [len]
	 mov al, [len]
	 add di, ax
	 STD
	 rep movsb 
	 add bl, 1
	 jmp @@Next
	 
@@End:
	 pop cx
	 mov [len], cl
	 pop bx
	 pop ax
	 pop di
	 pop es
	 pop si
	 pop cx
	 ret
endp
 
 
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