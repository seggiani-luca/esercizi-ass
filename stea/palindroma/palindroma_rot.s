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

	mov numero, %ax
	mov $16, %cl

loop:
	rcl %ax
	rcr %bx
	
	dec %cl
	cmp $0, %cl
	jne loop


	mov numero, %ax
	cmp %ax, %bx
	je end1
	jmp end2

end1:
	lea mess1, %ebx
	call outline
	ret

end2:
	lea mess2, %ebx
	call outline
	ret
