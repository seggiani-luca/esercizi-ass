# Si implementino come sottoprogrammi Assembler le seguenti funzioni della libreria stdio.h del C++: 
# - strlen: calcola la lunghezza di una stringa (escluso il carattere di terminazione). L’indirizzo di 
# 	partenza della stringa è dato in %EBX, la lunghezza deve essere restituita in %AX. 
# - strcpy: copia una stringa in un’altra. L’indirizzo di partenza della stringa sorgente è dato in 
# 	%EBX, l’indirizzo di partenza della stringa di destinazione è dato in %EBP. 
# - strcmp: confronta due stringhe secondo l’ordinamento della tabella ASCII. L’indirizzo di 
# 	partenza delle due stringhe è in %EBX ed %EBP rispettivamente. Restituisce in %AL 0 se le strin-
# 	ghe sono uguali, 1 se la prima è successiva alla seconda, -1 altrimenti. 
# - strchr: trova la prima occorrenza di un carattere in una stringa. Ritorna (in %EAX) l’indirizzo 
# 	della prima occorrenza del carattere. L’indirizzo di partenza della stringa si trova in %EBX. Se il 
# 	carattere non viene trovato, %EAX deve valere 0. 
# - strrchr: trova l’ultima occorrenza di un carattere in una stringa. Ritorna (in %EAX) l’indirizzo 
# 	dell’ultima occorrenza del carattere. L’indirizzo di partenza della stringa si trova in %EBX. Se il 
# 	carattere non viene trovato, %EAX deve valere 0. 
# Si faccia l’ipotesi che ciascuna stringa in memoria sia terminata dal carattere nullo \0.  
# Si scriva del codice che accetta in ingresso delle stringhe da tastiera, terminate con il carattere di 
# ritorno carrello, e testa i sottoprogrammi sopra scritti.

.include "./files/utility.s"

.data
	string1: .fill 80, 1
	string2: .fill 80, 1

	mess1: .asciz "=> prova strlen"
	mess2: .asciz "=> prova strcpy 1"
	mess3: .asciz "=> prova strcpy 2"
	mess4: .asciz "=> prova strcmp"
	mess5: .asciz "=> prova strchr"
	mess6: .asciz "=> prova strrchr"

.text
_main:
	nop
	push %ebp

	# - strlen
	lea mess1, %ebx
	call new_outline

	mov $80, %ecx
	lea string1, %ebx
	call new_inline

	call strlen
	call outdecimal_word

	call newline

	# - strcpy 1
	lea mess2, %ebx
	call new_outline
	
	mov $80, %ecx
	lea string1, %ebx
	call new_inline
	push %ebx

	mov $80, %ecx
	lea string2, %ebx
	call new_inline

	mov %ebx, %ebp
	add $8, %ebp
	pop %ebx

	call strcpy

	lea string1, %ebx
	call new_outline

	lea string2, %ebx
	call new_outline

	# - strcpy 2
	lea mess3, %ebx
	call new_outline
	
	mov $80, %ecx
	lea string1, %ebx
	call new_inline
	push %ebx

	mov $80, %ecx
	lea string2, %ebx
	call new_inline

	mov %ebx, %ebp
	pop %ebx
	add $8, %ebx

	call strcpy

	lea string1, %ebx
	call new_outline

	lea string2, %ebx
	call new_outline

	# - strcmp
	lea mess4, %ebx
	call new_outline
	
	mov $80, %ecx
	lea string1, %ebx
	call new_inline
	push %ebx

	mov $80, %ecx
	lea string2, %ebx
	call new_inline

	mov %ebx, %ebp
	pop %ebx

	call strcmp

	call outinteger_byte

	call newline

	# - strchr
	lea mess5, %ebx
	call new_outline

	mov $80, %ecx
	lea string1, %ebx
	call new_inline

	call inchar
	# call outchar
	call wait_eof
	mov %al, %dl

	# call newline

	call strchr
	call outdecimal_long

	call newline

	# - strrchr
	lea mess6, %ebx
	call new_outline

	mov $80, %ecx
	lea string1, %ebx
	call new_inline

	call inchar
	# call outchar
	call wait_eof
	mov %al, %dl

	# call newline

	call strrchr
	call outdecimal_long

	call newline

	pop %ebp
	ret

# - strlen: calcola la lunghezza di una stringa (escluso il carattere di terminazione). L’indirizzo di 
# 	partenza della stringa è dato in %EBX, la lunghezza deve essere restituita in %AX. 
strlen:
	push %ecx
	push %edi
	
	mov %ebx, %edi
	mov $0xffffffff, %ecx

	cld

strlen_loop:
	mov $0, %al
	repne scasb
	
	sub %ebx, %edi
	dec %edi

	mov %di, %ax
	
	pop %edi
	pop %ecx
	ret

# - strcpy: copia una stringa in un’altra. L’indirizzo di partenza della stringa sorgente è dato in 
# 	%EBX, l’indirizzo di partenza della stringa di destinazione è dato in %EBP. 
strcpy:
	push %ecx
	push %ax
	push %edi
	push %esi

	mov $0xffffffff, %ecx

	mov %ebx, %esi
	mov %ebp, %edi

	cmp %edi, %esi
	jl strcpy_rev

	cld

strcpy_loop:
	lodsb
		cmp $0, %al
		je strcpy_end
	stosb
	loop strcpy_loop

strcpy_rev:
	call strlen
	xor %ecx, %ecx
	mov %ax, %cx

	add %ecx, %esi
	add %ecx, %edi

	std

strcpy_loop_rev:	
	repe movsb

strcpy_end:
	movsb

	pop %esi
	pop %edi
	pop %ax
	pop %ecx
	ret

# - strcmp: confronta due stringhe secondo l’ordinamento della tabella ASCII. L’indirizzo di 
# 	partenza delle due stringhe è in %EBX ed %EBP rispettivamente. Restituisce in %AL 0 se le strin-
# 	ghe sono uguali, 1 se la prima è successiva alla seconda, -1 altrimenti. 
strcmp:
	push %ecx
	push %dx
	push %ax
	push %esi
	push %edi

	mov %ebx, %esi
	mov %ebp, %edi

	xor %dl, %dl
	mov $0xfffffff, %ecx

	cld

strcmp_loop:
	repe cmpsb
	ja strcmp_up
	jb strcmp_down
	je strcmp_end

strcmp_up:
	mov $1, %dl
	jmp strcmp_end

strcmp_down:
	mov $255, %dl

strcmp_end:
	pop %ax
	
	mov %dl, %al

	pop %edi
	pop %esi
	pop %dx
	pop %ecx
	ret

# - strchr: trova la prima occorrenza di un carattere in una stringa. Ritorna (in %EAX) l’indirizzo 
# 	della prima occorrenza del carattere. L’indirizzo di partenza della stringa si trova in %EBX. Se il 
# 	carattere non viene trovato, %EAX deve valere 0. visto che lo stea non specifica quale carattere,
#		si decide di prenderlo da %dl
strchr:
	push %dx
	push %ecx
	push %edi

	mov %ebx, %edi

	xor %eax, %eax
	call strlen
	mov %eax, %ecx

	mov %dl, %al

	cld

strchr_loop:
	repne scasb
	jne strchr_nofound	

	sub %ebx, %edi
	dec %edi
	mov %edi, %eax
	jmp strchr_end

strchr_nofound:
	xor %eax, %eax

strchr_end:
	pop %edi
	pop %ecx
	pop %dx
	ret

# - strrchr: trova l’ultima occorrenza di un carattere in una stringa. Ritorna (in %EAX) l’indirizzo 
# 	dell’ultima occorrenza del carattere. L’indirizzo di partenza della stringa si trova in %EBX. Se il 
# 	carattere non viene trovato, %EAX deve valere 0. come prima, stea permettendo il carattere sta in %dl
strrchr:
	push %dx
	push %ecx
	push %edi

	mov %ebx, %edi

	xor %eax, %eax
	call strlen
	mov %eax, %ecx

	mov %dl, %al
	
	add %ecx, %edi

	std

strrchr_loop:
	repne scasb
	sub %ebx, %edi
	
	cmp $0, %edi
	je strrchr_chk

	inc %edi

strrchr_chk:
	mov %edi, %eax

strrchr_end:
	pop %edi
	pop %ecx
	pop %dx
	ret

# versione rivista della inline per stringhe terminate da '\0'
new_inline:
	push %ax
	push %ecx

	xor %ecx, %ecx

in_loop:
	call inchar

	cmp $80, %ecx
	je in_end

	cmp $0x0d, %al
	je in_end

	cmp $0x08, %al
	je in_bs

	# call outchar

	movb %al, (%ebx,  %ecx)
	inc %ecx

	jmp in_loop

in_bs:
	cmp $0, %ecx
	je in_loop

	mov $0x08, %al
	# call outchar
	
	mov $' ', %al
	# call outchar

	mov $0x08, %al
	# call outchar

	dec %ecx
	jmp in_loop

in_end:
	mov $0x00, %al
	movb %al, (%ebx, %ecx)

	# call newline

	pop %ecx
	pop %ax
	ret

# versione rivista della outline per stringhe terminate da '\0'
new_outline:
	push %ax
	push %ecx

	xor %ecx, %ecx

out_loop:
	movb (%ebx, %ecx), %al
	
	cmpb $0, %al
	je out_end

	call outchar

	inc %ecx	
	jmp out_loop

out_end:
	call newline

	pop %ecx
	pop %ax
	ret

# versione rivista della outdecimal_byte per interi
outinteger_byte:
	push %ax

	test $0x80, %al
	jz outinteger_pos

	push %ax
	mov $'-', %al
	call outchar
	pop %ax
	
	neg %al
	
outinteger_pos:
	call outdecimal_byte
	
	pop %ax
	ret

# umpf
wait_eof:
	push %ax
eof_loop:
	call inchar
	
	cmp $0x0d, %al
	je eof_end

	jmp eof_loop

eof_end:
	pop %ax
	ret
