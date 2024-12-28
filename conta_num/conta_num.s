# contare il numero di occorrenze del numero nell'array, e stamparlo

.include "./files/utility.s"

.data
array:      .word 1, 256, 256, 512, 42, 2048, 1024, 1, 0
array_len:  .long 9
numero:     .word 1

.text
_main:
	nop

.primo: # inizializza i registri
	mov $0, %esi
	mov numero, %bx
	mov $0, %cl

loop: # cicla sull'array
	cmp %esi, array_len
	je dopo
	
	cmpw %bx, array(,%esi,2)
	jne step

	inc %cl

step: # prossimo passo iterativo
	inc %esi
	jmp loop

dopo: # esegui dopo il loop, stampa
	mov %cl, %al
	call outdecimal_byte
	call newline

	ret
