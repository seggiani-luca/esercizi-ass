.include "./files/utility.s"

.data

.text
_main:
	nop
	
	call indecimal_byte
	mov %eax, %ebx
	call indecimal_byte

	cmp %ebx, %eax

	ret
