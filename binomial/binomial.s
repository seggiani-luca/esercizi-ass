# si scriva un programma che calcola e mette nella variabile di memoria risultato il coefficiente 
# binomiale $\binom{A}{B}$, calcolato come $\frac{A!}{B!(A-B)!}$. si assuma che A e B siano due 
# numeri naturali minori di 10, con $A \geq B$, contenuti in memoria. si ponga particolare attenzione 
# nel dimensionare correttamente le variabili in memoria (a partire da risultato) moltiplicazioni e le 
# divisioni. si faccia uso di un sottoprogramma per il calcolo del fattoriale di un numero. 

.include "files/utility.s"

.data
	A: .byte 9
	B: .byte 5
	
	numer: .long 0
	denom: .long 0
	
	binom: .word 0

.text
_main:
	nop

	call indecimal_byte
	movb %al, A

	call indecimal_byte
	movb %al, B

	movb A, %bl
	call fatt
	movl %eax, numer # numer = A!

	mov %bl, %bh # bh = A
	movb B, %bl  # bl = B
	call fatt 	 # eax = B!
		
	sub %bl, %bh # bh = A - B

	push %eax
	mov %bh, %bl
	call fatt
	mov %eax, %ebx
	pop %eax

	# eax = B!
	# ebx = (A - B)!		
	
	mul %ebx
	movl %eax, denom

	# numer = A!
	# denom = B! (A - B)!

	mov numer, %eax

	divl denom
	movw %ax, binom

	call outdecimal_word

	ret

# calcola il fattoriale di un numero
# ingresso:
# - bl: un numero
# uscita:
#	- eax: il suo fattoriale
fatt:
	push %dx
	push %cx
	push %bx

	xor %bh, %bh # bx = bl
	xor %dx, %dx # dx_ax = 1

	mov $1, %eax

	mov $2, %cx

fatt_loop:
	cmp %bx, %cx
	ja fatt_end

	mul %cx
	inc %cx

	jmp fatt_loop

fatt_end:
	push %dx
	push %ax
	pop %eax # eax = dx_ax

	pop %bx
	pop %cx
	pop %dx
	ret
