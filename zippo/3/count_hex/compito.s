.include "./files/utility.s"

.data
	string: .fill 80, 1
	count: .fill 16, 1

.text
_main:
	nop

	xor %eax, %eax

start:	

	mov $80, %ecx
	lea string, %ebx
	call inline

	mov $80, %ecx
	mov %ebx, %esi

get_digit:
	lodsb

	cmp $'\r', %al
	je print

	or $0x20, %al

	cmp $'0', %al
	jb get_letter
	cmp $'9', %al
	ja get_letter

	sub $'0, %al

	jmp post_get

get_letter:
	cmp $'a', %al
	jb get_digit
	cmp $'f', %al
	ja get_digit

	sub $'a', %al
	add $10, %al

post_get:
	incb count(, %eax)

	loop get_digit

	ret

print:
	xor %ecx, %ecx
	lea count, %ebx

	xor %dl, %dl

print_loop:
	cmpb $0, (%ebx, %ecx)
	je post_print

	mov $1, %dl

	push %ax
	mov %cl, %al
	call outtiny
	pop %ax

	mov $' ', %al
	call outchar

	mov (%ebx, %ecx), %al
	call outdecimal_byte

	call newline

	movb $0, (%ebx, %ecx)

post_print:
	inc %ecx

	cmp $16, %ecx
	jne print_loop

	call newline
	
	cmp $0, %dl
	je end

	jmp start

end:
	ret

# stampa la codifica esadecimale del tiny in %al
outtiny:
	push %ax

tiny_digit:
	cmp $0, %al
	jb tiny_letter 
	cmp $9, %al
	ja tiny_letter 

	add $'0', %al

	jmp post_tiny

tiny_letter:
	cmp $10, %al
	jb no_tiny
	cmp $15, %al
	ja no_tiny

	add $'a', %al
	sub $10, %al

post_tiny:
	call outchar

no_tiny:
	pop %ax
	ret
