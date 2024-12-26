.include "./files/utility.s"

.data
dat: .long 0x12345678 

.text
_main:
	nop
	
	mov dat, %eax
	
	ror $16, %eax

	ret
