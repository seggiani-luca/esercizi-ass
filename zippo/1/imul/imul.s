# leggere 2 numeri interi in base 10, calcolarne il prodotto, e stampare il risultato.

# lettura:
# come primo carattere leggere il segno del numero, cioè un '+' o un '-'
# segue il modulo del numero, minore di 256

# stampa:
# stampare prima il segno del numero (+ o -), poi il modulo in cifre decimali

.include "./files/utility.s"

.data

.text
_main:
	nop

	call in_int
	call newline

	cwde

	mov %eax, %ebx

	call in_int
	call newline

	cwde

	imul %ebx

	call out_int
	call newline

	ret

# legge un intero e lo mette in %ax
in_int:
	push %bx
	push %cx
	push %di
	push %dx

	xor %ax, %ax
	xor %cx, %cx

	mov $10, %di

in_sign_loop:
	call inchar

	cmp $'+', %al
	je in_psign

	cmp $'-', %al
	je in_nsign

	cmp $'0', %al
	jb in_sign_loop

	cmp $'9', %al
	ja in_sign_loop
	
	call outchar
	
	sub $48, %al
	
	jmp in_digit_loop 

in_nsign:
	mov $1, %bx
in_psign:
	call outchar
	xor %ax, %ax

in_digit_loop:
	push %ax
	call inchar

	mov %ax, %cx
	pop %ax

	cmp $'\r', %cl
	je in_post

	cmp $'0', %cl
	jb in_digit_loop

	cmp $'9', %cl
	ja in_digit_loop

	push %ax
	mov %cx, %ax
	call outchar
	pop %ax

	sub $48, %cx
	mul %di
	add %cx, %ax

	jmp in_digit_loop

in_post:
	cmp $1, %bx
	jne in_ppost

in_npost:
	neg %ax

in_ppost:
	pop %dx
	pop %di
	pop %cx
	pop %bx
	ret

# legge un intero da %ax
out_int:
	push %eax
	push %edi
	push %edx
	push %cx
	
	xor %cx, %cx
	xor %edx, %edx
	
	mov $10, %edi

	test $0x80000000, %eax
	jz out_digit_loop

	push %ax
	mov $'-', %al
	call outchar
	pop %ax
	
	neg %eax
	
out_digit_loop:
	div %edi
	
	add $48, %dx
	push %dx
	inc %cx

	xor %edx, %edx

	cmp $0, %eax
	jne out_digit_loop

out_unroll_loop:
	pop %dx
	mov %dx, %ax
	call outchar

	dec %cx
	cmp $0, %cx
	jne out_unroll_loop

	pop %cx
	pop %edx
	pop %edi
	pop %eax
	ret
