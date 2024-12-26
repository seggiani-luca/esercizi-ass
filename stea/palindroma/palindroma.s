# scrivere un programma che si comporta come segue: 
# 	1. prende in ingresso un numero a 16 bit, contenuto in memoria nella variabile "numero".
# 	2. controlla se "numero" è o meno una stringa di 16 bit palindroma (cioé se la sequenza di 16 bit 
# 		 letta da sx a dx è uguale alla sequenza letta da dx a sx). 
# 	3. se X è (non è) palindromo, il programma inserisce 1 (0) nella variabile a 8 bit "palindromo", che 
# 		 si trova in memoria 

.include "./files/utility.s"

.data
	numero: .word 0xd5ab
	mess1: .ascii "palindroma\r"
	mess2: .ascii "non palindroma\r"

.text
_main:
	nop

	mov numero, %ax											  # prepara i registri ax e bx con due copie della stringa in "numero"
	mov %ax, %bx

	xor %edi, %edi												# azzera edi e esi da usare come indici
	xor %esi, %esi

loop:	
	mov %ax, %cx													# copia ax e bx rispettivamente in cx e dx
	mov %bx, %dx

	and $0x8000, %cx											# maschera cx e dx: di cx ci interessa il MSB, di dx il LSB
	and $0x0001, %dx

	or %cx, %dx														# metti in dx l'or di cx e dx: se ax e bx erano palindrome nell'MSB e
																				# l'LSB, dx dovrà contenere 0x8001 o 0x0000 (due 1 o due 0)
	
	cmp $0x8001, %dx											# confronta dx con 0x8001 (ciò che vogliamo), se uguali incrementa edi
	je sum

	cmp $0x0000, %dx											# confronta dx con 0x0000 (di nuovo ciò che vogliamo), se uguali idem
	je sum	

	jmp end

post:																		# fai lo shift a sinistra di ax e lo shift a destra di bx
	shl %ax
	shr %bx
	
	inc %esi															# incrementa esi e chiudi il loop se hai fatto 16 iterazioni
	cmp $16, %esi
	jne loop

	jmp end

sum:
	inc %edi
	jmp post

end:
	cmp $16, %edi													# se edi ha raggiunto 16, la stringa è palindroma, stampa
	je end1

	jmp end2															# altrimenti non lo è, stampa

end1:
	lea mess1, %ebx
	call outline
	ret

end2:
	lea mess2, %ebx
	call outline
	ret
