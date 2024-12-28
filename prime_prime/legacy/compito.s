.include "./files/utility.s"

.data
	primes: .fill 50, 1
	len: .byte 2

.text
_main:
	nop

	mov $1, %ecx
	movb $2, (primes)
	movb $3, primes(, %ecx,)

	call indecimal_byte
	call newline

	cmp $3, %al
	jb end
	cmp $50, %al
	ja end

	mov %ax, %di
	sub $2, %di
	
	mov $2, %al
	call outdecimal_byte
	mov $' ', %al
	call outchar

	mov $3, %al
	call outdecimal_byte
	mov $' ', %al
	call outchar

	mov $5, %ch

find_loop:
	mov $0, %cl

chk_loop:
	xor %ax, %ax
	mov %ch, %al
	
	push %ecx
	movzbl %cl, %ecx 
	mov primes(, %ecx), %dh
	pop %ecx

	div %dh

	cmp $0, %ah
	je new_find

	inc %cl
	cmpb (len), %cl
	je found

	jmp chk_loop

new_find:
	inc %ch
	jmp find_loop

found:
	mov (len), %cl
	
	mov %ch, %al

	push %ecx
	movzbl %cl, %ecx 
	mov %al, primes(, %ecx)
	pop %ecx
	
	inc %cl
	mov %cl, len

	call outdecimal_byte

	mov $' ', %al
	call outchar

	dec %di
	cmp $0, %di
	jne find_loop

end:
	call newline
	ret
