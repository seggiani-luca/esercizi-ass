# Dato un array A di N numeri naturali su 16 bit, sia M il valor medio (approssimato per difetto) 
# calcolato sugli elementi di A. Riempire l’array B, di identica dimensione, con numeri interi 
#	B_i = A_i - M. Stampare poi a video il valore minimo e massimo dell’array B. Utilizzare esclusivamente 
# istruzioni stringa per accedere ai due array A e B.

.include "./files/utility.s"

.set n, 10

.data
	a: .fill n, 2
	b: .fill n, 2

.text
_main:
	nop

	mov $n, %ecx
	lea a, %edi
	
	cld

read_loop:
	call indecimal_word
	call newline
	stosw
	loop read_loop 

	mov $n, %ecx
	lea a, %esi

	xor %bx, %bx

avg_loop:
	lodsw
	add %ax, %bx
	loop avg_loop

	xor %dx, %dx
	mov %bx, %ax
	
	mov $n, %cx
	divw %cx

	mov %ax, %bx

	mov $n, %ecx

	lea a, %esi
	lea b, %edi

	mov $0x8000, %dx # min
	push %dx
	
	mov $0x7FFF, %dx # max
	push %dx

sub_loop:
	lodsw
	
	sub %bx, %ax

	pop %dx
	cmp %dx, %ax
	jl new_min

sub_post_min:
	push %dx

	add $2, %esp
	pop %dx
	cmp %dx, %ax
	jg new_max

sub_post_max:
	push %dx
	sub $2, %esp

sub_post:
	call outinteger_word

	push %ax
	
	mov $' ', %al
	call outchar
	
	pop %ax
	
	stosw
	loop sub_loop

	call newline

	pop %cx
	pop %dx

	mov %cx, %ax
	call outinteger_word

	mov $' ', %al
	call outchar

	mov %dx, %ax
	call outinteger_word
	
	ret

new_min:
	mov %ax, %dx
	jmp sub_post_min

new_max:
	mov %ax, %dx
	jmp sub_post_max

outinteger_word:
	push %ax

	test $0x8000, %ax
	jz outinteger_pos

	push %ax
	mov $'-', %al
	call outchar
	pop %ax
	
	neg %ax
	
outinteger_pos:
	call outdecimal_word
	
	pop %ax
	ret
