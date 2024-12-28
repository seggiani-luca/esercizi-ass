.include "./files/utility.s"

.data
	mess1: .ascii "colpito!\r"
	mess2: .ascii "mancato!\r"
	mess3: .ascii "vittoria!\r"

.text
_main:
	nop

	# legge stato iniziale
	call inword
	mov %ax, %dx # edx contiene il tabellone
	
	call newline

game_loop:	
	# leggi posizione
	xor %ax, %ax

in_letter:
	call inchar

	cmp $'a', %al
	jb in_letter 
	
	cmp $'d', %al
	ja in_letter

	call outchar

	sub $'a', %al
	mov %al, %cl

in_digit:
	call inchar

	cmp $'0', %al
	jb in_digit 
	
	cmp $'9', %al
	ja in_digit

	call outchar
	call newline

	sub $'0', %al

	cmp $3, %al
	je three
	cmp $4, %al
	je four

	jmp mask_loop

three:
	mov $0x04, %al
	jmp mask_loop

four:
	mov $0x08, %al

mask_loop:
	cmp $0, %cl
	je post_mask

	shl $4, %ax
	dec %cl

	jmp mask_loop

post_mask:
	mov %dx, %bx
	and %ax, %bx

	cmp $0, %bx
	je not_hit

hit:
	lea mess1, %ebx
	call outline
	jmp post_turn

not_hit:
	lea mess2, %ebx
	call outline

post_turn:
	xor %ax, %dx

	cmp $0, %dx
	jne game_loop

	lea mess3, %ebx
	call outline

	ret
