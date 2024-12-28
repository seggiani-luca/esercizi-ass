# scrivere un programma che si comporta come segue: 
# 1. prende in ingresso un numero a 16 bit, contenuto in memoria nella variabile numero. 
# 2. controlla se numero è o meno un numero primo. se lo è, mette in primo il numero 1. 
# 	 altrimenti mette in primo il numero 0.

.include "./files/utility.s"

.data
	numer: .word 18
	primo: .byte 1
	mess1: .ascii "primo\r"
	mess2: .ascii "non primo\r"

.text
_main:
	nop
	
	call indecimal_word
	xor %ebx, %ebx
	mov %ax, %bx

	cmp $1, %bx
	jbe end2

	mov $2, %cx

loop:	
	mov %cx, %ax
	mul %ax
	push %dx
	push %ax
	pop %eax

	cmp %ebx, %eax
	ja end1

	mov %bx, %ax
	div %cx
	cmp $0, %dx
	je end2

	inc %cx
	jmp loop

end1:
	lea mess1, %ebx
	call outline
	ret

end2:
	lea mess2, %ebx
	call outline
	
	movb $0, primo
	ret
