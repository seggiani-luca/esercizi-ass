# Scrivere un programma che si comporta come segue: 
# 1. emette ? e legge con eco da tastiera, facendo gli opportuni controlli,  
#    le codifiche ASCII di due cifre di un numero naturale in base dieci; 
# 2. se il numero è compreso fra 0 e 19: 
#     a. stampa su una nuova riga il nome del numero; 
#     b. torna al punto 1; 
# 3. altrimenti, se il numero è maggiore di 19, termina. 
# 
# Esempio: 
#13 
#tredici 
#0 
#zero 
#214

.include "./files/utility.s"

.data
	str0:  .ascii "zero\r"
	str1:  .ascii "uno\r"
	str2:  .ascii "due\r"
	str3:  .ascii "tre\r"
	str4:  .ascii "quattro\r"
	str5:  .ascii "cinque\r"
	str6:  .ascii "sei\r"
	str7:  .ascii "sette\r"
	str8:  .ascii "otto\r"
	str9:  .ascii "nove\r"
	str10: .ascii "dieci\r"
	str11: .ascii "undici\r"
	str12: .ascii "dodici\r"
	str13: .ascii "tredici\r"
	str14: .ascii "quattordici\r"
	str15: .ascii "quindici\r"
	str16: .ascii "sedici\r"
	str17: .ascii "diciassette\r"
	str18: .ascii "diciotto\r"
	str19: .ascii "diciannove\r"
	
	ptrs: .fill 20, 4
	
.text
_main:
	nop

	lea ptrs, %edi

	lea str0,  %eax
	stosl
	lea str1,  %eax
	stosl
	lea str2,  %eax
	stosl
	lea str3,  %eax
	stosl
	lea str4,  %eax
	stosl
	lea str5,  %eax
	stosl
	lea str6,  %eax
	stosl
	lea str7,  %eax
	stosl
	lea str8,  %eax
	stosl
	lea str9,  %eax
	stosl
	lea str10, %eax
	stosl
	lea str11, %eax
	stosl
	lea str12, %eax
	stosl
	lea str13, %eax
	stosl
	lea str14, %eax
	stosl
	lea str15, %eax
	stosl
	lea str16, %eax
	stosl
	lea str17, %eax
	stosl
	lea str18, %eax
	stosl
	lea str19, %eax
	stosl

feed:
	mov $'?', %al
	call outchar
	mov $' ', %al
	call outchar

	xor %eax, %eax
	call in_num
	call newline

	cmp $19, %al
	ja end

	mov ptrs(, %eax, 4), %ebx
	call outline

	jmp feed

end:
	ret

in_num:
	push %bx
	push %ax

	call in_digit
	
	mov $10, %bl
	mulb %bl

	mov %al, %bl
	
	call in_digit
	add %al, %bl

	pop %ax
	
	mov %bl, %al

	pop %bx
	ret

in_digit:
digit_loop:
	call inchar
	
	cmp $'0', %al
	jb digit_loop
	cmp $'9', %al
	ja digit_loop

	call outchar

	sub $'0', %al
	ret
