# si implementi un programma Assembler che si comporta come segue: 
# 1) legge con eco da tastiera due numeri naturali A e B di in base 10 (assumendo che siano rappre-
# 	 sentabili su 16 bit) e un numero naturale N in base dieci (assumendo che sia rappresentabile su 8 
# 	 bit) 
# 2) se A>=B (maggiore o uguale), ovvero N=0 termina, altrimenti:  
# 3) stampa a video, su una nuova riga la sequenza di N numeri:  
#    B + (B-A), B + 2*(B-A), ... , B + N*(B-A) 
# 	 eventualmente terminando la sequenza in anticipo qualora il successivo numero da stampare non 
# 	 appartenga all'intervallo di rappresentabilità per numeri naturali su 16 bit. 
# 4) ritorna al punto 1). 

.include "./files/utility.s"

.data

.text
_main:
	nop
	
	call indecimal_word
	mov %ax, %dx

	call indecimal_word
	mov %ax, %bx

	call indecimal_byte
	mov %al, %cl

	# dx = A, bx = B, cl = N

	cmp %bx, %dx
	jae end

	cmp $0, %cl
	je end

	mov %bx, %ax
	sub %dx, %ax
	
	push %ax
	add %bx, %ax
	pop %bx

	# ax = B + (B - A), dx = A, bx = B - A

loop:
	push %ax

	mov $' ', %al
	call outchar
	
	pop %ax
	
	call outdecimal_word
	
	add %bx, %ax
	dec %cl

	jc end

	cmp $0, %cl
	ja loop

end:
	ret
