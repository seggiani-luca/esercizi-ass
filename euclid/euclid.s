# scrivere un programma assembler che si comporta come segue: 
# 1. legge da tastiera due numeri naturali A e B in base 10, sotto l'ipotesi che siano rappresentabili su 
# 	 16 bit. 
# 2. Se almeno uno dei due e' nullo, termina. altrimenti,  
# 3. Esegue l'algoritmo di Euclide per il calcolo del loro MCD, stampando tutti 
# 	 i risultati intermedi. 
# 4. ritorna al punto 1. 

.include "./files/utility.s"

.data

.text
_main:
	nop

	call indecimal_word
	mov %ax, %bx

	call newline

	call indecimal_word
	mov %ax, %cx

	call newline

	mov $0, %di

loop:	
	mov %di, %ax
	call outdecimal_long

	mov $' ', %al
	call outchar

	mov %bx, %ax
	call outdecimal_long

	mov $' ', %al
	call outchar
	
	mov %cx, %ax
	call outdecimal_long

	call newline

	xor %dx, %dx
	mov %bx, %ax
	div %cx
	
	cmp $0, %dx
	je end
	
	mov %cx, %bx
	mov %dx, %cx

	inc %di

	jmp loop

end:
	mov %cx, %ax
	call outdecimal_word
	ret
