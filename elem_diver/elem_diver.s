# dati due array di 10 word in memoria, stampare il numero di elementi diversi che occupano la 
# stessa posizione.

.include "./files/utility.s"

.data
	arr1: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
	arr2: .word 0, 1, 8, 3, 4, 9, 6, 7, 3, 9 # 3 diversi

.text
_main:
	nop
	
	xor %ecx, %ecx
	xor %al, %al

loop:
	mov arr1(, %ecx, 2), %bx
	mov arr2(, %ecx, 2), %dx

	cmp %bx, %dx
	je post

	inc %al

post:
	inc %ecx
	
	cmp $10, %ecx
	jb loop

	call outdecimal_byte
	call newline

	xor %eax, %eax
	ret
