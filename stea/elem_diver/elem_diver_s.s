# dati due array di 10 word in memoria, stampare il numero di elementi diversi che occupano la 
# stessa posizione.

.include "./files/utility.s"

.data
	arr1: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
	arr2: .word 0, 1, 8, 3, 4, 9, 6, 7, 3, 9 # 3 diversi

.text
_main:
	nop
	
	lea arr1, %esi
	lea arr2, %edi
	mov $10, %ecx
	
	xor %al, %al

loop:
	repe cmpsw
	setne %bl
	add %bl, %al
	cmp $0, %ecx
	jne loop

	call outdecimal_byte
	call newline

	ret
