.include "./files/utility.s"

.data
	vec: .fill 80, 1

.text
_main:
	nop
	
	lea vec, %esi
	movb $2, (%esi)
	inc %esi
	movb $3, (%esi)
	inc %esi

	# esi -> fine di vec
	# vec: 2 3

	call indecimal_byte
	call newline

	cmp $3, %al
	jb end
	cmp  $50, %al
	ja end

	xor %edx, %edx
	mov %al, %dl

	# edx -> num. di primi

	lea vec, %ebx
	add %edx, %ebx

	# ebx -> addr. di vec desiderato

	mov $4, %al
	
	# al -> nat. considerato

find_loop:
	inc %al
	lea vec, %edi

	# edi -> inizio di vec

chk_loop:
	mov (%edi), %cl

	# cl -> primo considerato
	
	push %ax

	div %cl
	
	# al -> spazzatura
	# ah -> resto

	mov %ah, %ch
	
	# ch -> resto

	pop %ax

	# al -> nat. considerato
	# ah -> spazzatura

	cmp $0, %ch
	je find_loop

	inc %edi
	
	cmp %esi, %edi
	je found

	jmp chk_loop

found:
	movb %al, (%esi)

	# vec -> vec + %al (nat. considerato)

	inc %esi

	cmp %ebx, %esi
	jbe find_loop

print:
	lea vec, %esi
	
	# esi -> inizio di vec

	mov %edx, %ecx

	# ecx -> num. di primi
	
	cld	

print_loop:
	lodsb
	call outdecimal_byte
	
	mov $' ', %al
	call outchar

	loop print_loop

	call newline

end:
	ret
