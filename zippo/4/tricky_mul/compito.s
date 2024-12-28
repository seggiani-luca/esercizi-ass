.include "./files/utility.s"

.data

.text
_main:
	nop
	
	xor %edx, %edx

	call indecimal_word
	call newline
	mov %ax, %bx
	
	call indecimal_word
	call newline
	mov %ax, %cx
	
	# bh * ch * 2^16
	xor %eax, %eax

	mov %bh, %al
	mul %ch

	shl $16, %eax

	add %eax, %edx
	
	# bh * cl * 2^8
	xor %eax, %eax

	mov %bh, %al
	mul %cl

	shl $8, %eax

	add %eax, %edx
	
	# bl * ch * 2^8
	xor %eax, %eax

	mov %bl, %al
	mul %ch

	shl $8, %eax

	add %eax, %edx
	
	# bl * cl
	xor %eax, %eax

	mov %bl, %al
	mul %cl

	add %eax, %edx

	mov %edx, %eax
	call outdecimal_long
	call newline

	ret
