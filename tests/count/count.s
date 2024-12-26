# scrivere un programma per contare il numero di 1 trovati in un array

.include "./files/utility.s"

.data
	buf: .byte 0xFF, 0x00, 0x01, 0x30

.text
_main:
	nop

init:
	movl $0x00000000, %edx
	movw $0x0000, %ax
	
	lea buf, %ebx 

byte_loop:
	cmpl $0x00000004, %edx
	je break

	movb (%ebx, %edx), %ch
	movb $8, %cl

	inc %edx

loop:
	cmpb $0x00, %cl
	je byte_loop

	shr %ch
	adcw $0x00, %ax

	dec %cl
	jmp loop

break:
	call outdecimal_word

	ret
