#Scrivere un programma che si comporta come segue: 
# 
#1. legge da tastiera, EFFETTUANDO GLI OPPORTUNI CONTROLLI, la codifica ASCII di  
#   una cifra in base dodici (0123456789AB), sia N il numero naturale  
#   corrispondente; 
#2. se N è uguale a zero, termina; altrimenti 
#3. legge da tastiera la codifica ASCII di una lettera vocale minuscola; 
#4. disegna un rettangolo pieno di larghezza 2*N caratteri ed altezza N  
#   caratteri, utilizzando la vocale letta in precedenza, quindi torna al  
#   punto 1. 
# 
#Esempio: 
#A 
#e 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 
#eeeeeeeeeeeeeeeeeeee 

 
.include "./files/utility.s"

.data

.text
_main:
	nop

	xor %bx, %bx
	xor %cx, %cx

	call in_digit
	# al contiene un numero in base 12	

	cmp $0, %al
	je end

	mov %al, %cl
	mov $2, %bl
	mul %bl

	mov %al, %bl
	
	call in_vowel
	# al: vocale, bl: larghezza, cl: altezza

	xor %di, %di

loop1:
	xor %si, %si

loop2:
	call outchar

	inc %si

	cmp %bx, %si
	jne loop2
	
	inc %di

	call newline

	cmp %cx, %di
	jne loop1

end:
	ret

in_digit:
	call inchar

	cmp $'0', %al
	jb in_letter
	cmp $'9', %al
	ja in_letter

	sub $'0', %al
	ret

in_letter:
	cmp $'a', %al
	jb in_digit
	cmp $'b', %al
	ja in_digit

	sub $'a', %al
	add $10, %al
	ret

in_vowel:
	call inchar
	
	cmp $'a', %al
	ret
	cmp $'e', %al
	ret
	cmp $'i', %al
	ret
	cmp $'o', %al
	ret
	cmp $'u', %al
	ret

	jmp in_vowel
