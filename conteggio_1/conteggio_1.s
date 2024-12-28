# scrivere un programma che: 
# 	- definisce un vettore numeri di enne numeri naturali a 16 bit in memoria (enne sia una costan-
# 		te simbolica) 
# 	- definisce un sottoprogramma per contare il numero di bit a 1 di un numero a 16 bit. Tale sotto-
# 		programma ha come parametro di ingresso il numero da analizzare (in AX), e restituisce il nu-
# 		mero di bit a 1 in CL. 
# 	- utilizzando il sottoprogramma appena descritto, calcola il numero totale di bit a 1 nel vettore ed 
# 		inserisce il risultato in una variabile conteggio di tipo word. 

.include "./files/utility.s"

# simboli
	.set enne, 10

.data
	vett: .word 0, 9, 1, 0, 1, 0, 0, 0, 0, 1
	cont: .word 0 

.text
_main:
	nop
	
	xor %edi, %edi # indice su vett
	xor %dx, %dx # numero di bit a 1

	xor %cx, %cx

loop:
	mov vett(, %edi, 2), %ax
	call sub_cont

	add %cx, %dx

	inc %edi
	cmp $enne, %edi
	jne loop

	mov %dx, cont 
	ret

# conta il numero di bit a 1 di un numero a 16 bit
# ingresso:
#	- %ax: il numero da analizzare
# uscita:
# - %cl: il numero di bit a 1
sub_cont:
	push %ax
	xor %cl, %cl

sub_cont_loop:
	shl %ax
	adc $0, %cl
	cmp $0, %ax
	je sub_cont_end

	jmp sub_cont_loop

sub_cont_end:
	pop %ax
	ret
