# leggere 2 numeri interi in base 10, calcolarne il prodotto, e stampare il risultato.

# lettura:
# come primo carattere leggere il segno del numero, cioè un '+' o un '-'
# segue il modulo del numero, minore di 256

# stampa:
# stampare prima il segno del numero (+ o -), poi il modulo in cifre decimali


.include "./files/utility.s"

.data

.text
_main:
	nop

primo: # leggi due numeri
	call inint
	call newline

	mov %ax, %bx
	
	call inint
	call newline

	# %bx contiene il primo numero e %ax il secondo
secondo: # moltiplica
	imul %bx
	# %dx_%ax contiene il risultato

	call outint
	call newline
	ret

# inint: prende un intero da tastiera come un segno seguito da una sequenza di cifre 
# ingresso: 
# uscita: %ax, l'intero inserito
inint:
	push %bx
	mov $'0', %ax
	call insign
	# %bx contiene il flag di segno
	# %ax contiene il primo carattere

	call innat
	# %ax contiene il numero
	
	cmp $1, %bx
	jne postint

	neg %ax

postint:
	pop %bx
	ret

# insign: prende caratteri finchè non ottiene un segno o un numero 
# ingresso:
# uscita: %bx, un flag che vale 1 a segno -
# 				%ax, il numero ottenuto, altrimenti quello che era alla chiamata
insign:
	push %cx
	mov %ax, %cx
	mov $0, %bx

signloop:
	call inchar
	
	cmp $'+', %al
	je postsign

	cmp $'-', %al
	je setsign
	
	cmp $'0', %al
	jb signloop
	cmp $'9', %al
	ja signloop

	mov %ax, %cx
	jmp postsign

setsign:
	mov $1, %bx

postsign:
	call outchar
	
	mov %cx, %ax
	pop %cx
	ret

# innat: prende caratteri per comporre un numero naturale, finche non trova un ritorno
# ingresso: %al, il primo carattere da prendere
# uscita: %ax, il naturale ottenuto
innat:
	push %cx
	mov $0, %cx

natloop:
	sub $'0', %al

	push %ax
	mov %cx, %ax

	mov $10, %dl
	mul %dl
	
	mov %ax, %cx
	pop %ax
	
	add %ax, %cx

skipadd:
	call inchar

	cmp $'\r', %al
	je postnat

	cmp $'0', %al
	jb skipadd	
	cmp $'9', %al
	ja skipadd
	
	call outchar
	jmp natloop

postnat:
	mov %cx, %ax
	pop %cx
	ret

# outint: stampa un'intero a schermo, come un segno seguito da una sequenza di cifre
# ingressi: dx_ax, l'intero da stampare
# uscite:
outint:
	push %bx
	mov $10, %bx
	
	push %cx
	mov $0, %cx

	test %dx, %dx
	jns outloop
	
	not %dx
	not %ax

	add $1, %ax
	adc $0, %dx

	push %ax
	mov $'-', %al
	call outchar
	pop %ax

outloop:
	div %bx
	push %dx
	inc %cx

	xor %dx, %dx
	test %ax, %ax
	jnz outloop

printloop:
	pop %dx
	mov %dx, %ax
	add $'0', %al
	call outchar

	dec %cx
	test %cx, %cx
	jnz printloop

	pop %cx
	pop %bx
	ret
