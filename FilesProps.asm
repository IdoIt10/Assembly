IDEAL

; By I.I

MODEL small

STACK 100h

DATASEG
	filename DB "Score.txt", 0
	score DW 60000
	file_handle dw ?

CODESEG
    
start: 
	mov ax, @data
	mov ds,ax
	
	call create_file
	call write_file
	call close_file
	
exit:
	mov ax, 4c00h
	int 21h
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
 
 
PROC create_file
    ; create or truncate the file
    MOV AH, 3Ch
    MOV CX, 0 ; create or truncate mode
    MOV DX, OFFSET filename
    INT 21h
	mov [file_handle], ax
    RET
ENDP create_file

PROC write_file
    ; write to the file
    MOV AH, 40h
    MOV BX, [file_handle] ; file handle
    MOV DX, OFFSET score
    MOV CX, 2 ; number of bytes to write
    INT 21h
	RET
ENDP write_file

PROC close_file
    ; close the file
    MOV AH, 3Eh
    MOV BX, [file_handle] ; file handle
    INT 21h
	RET
ENDP close_file
 
 
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