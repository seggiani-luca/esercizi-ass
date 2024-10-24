
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
	call insign
	# %bx contiene il flag di segno
	# %ax contiene il primo carattere

	call indecimal_word

	cmp $1, %bx
	jne postint

	neg %ax

postint:
	pop %bx
	ret

# insign: prende caratteri finchè non ottiene un segno o un numero 
# ingresso:
# uscita: %bx, un flag che vale 1 a segno -
insign:
	push %ax
	mov $0, %bx

signloop:
	call inchar
	
	cmp $'-', %al
	je setsign

	jmp postsign

setsign:
	mov $1, %bx

postsign:
	call outchar
	
	pop %ax
	ret

# outint: stampa un'intero a schermo, come un segno seguito da una sequenza di cifre
# ingressi: dx_ax, l'intero da stampare
# uscite:
outint:
	test %dx, %dx
	jns print
	
	not %dx
	not %ax

	add $1, %ax
	adc $0, %dx

	push %ax
	mov $'-', %al
	call outchar
	pop %ax

print:
	# fai la cosa pigra
	call outdecimal_word
	ret
