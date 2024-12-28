.include "./files/utility.s"

.data

.text
_main:
	nop

	xor %bx, %bx
	xor %cx, %cx

start:
	call in_digit
	call newline
	
	cmp $0, %al
	je end

	mov %al, %cl
	
	call in_digit
	call newline

	mov %al, %bl
	
	mov $1, %ax
	mov $1, %si
	mov $1, %di

loop:
	call outdecimal_long

	push %ax
	mov $' ', %al
	call outchar
	pop %ax

	add %bx, %ax
	inc %si

	cmp %di, %si
	jbe loop

step:
	mov $1, %si
	inc %di

	call newline

	cmp %cx, %di
	jbe loop

	call newline

	jmp start

end:
	ret

in_digit:
	call inchar

	cmp $'0', %al
	jb in_digit
	
	cmp $'9', %al
	ja in_digit

	call outchar

	sub $'0', %al

	ret
