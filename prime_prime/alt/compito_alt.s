.include "./files/utility.s"

.data
	flag: .fill 8, 4
	mask: .fill 8, 4

.text
_main:
	nop

	call indecimal_byte
	call newline

	cmp $3, %al
	jb end
	cmp  $50, %al
	ja end

	mov %al, %bl

	mov $1, %al
	xor %cl, %cl

chk_loop:
	inc %al
	
	call get_mask

	call test_flag
	
	cmp $0, %dl
	je found

	jmp chk_loop

found:
	call outdecimal_byte
	inc %cl

	push %ax
	
	mov $' ', %al
	call outchar

	pop %ax

	mov %al, %dl

set_loop:
	cmp $229, %al
	ja set_end

	cmp %dl, %al
	jb set_end
	
	add %dl, %al	
	
	call get_mask
	
	call or_flag

	jmp set_loop

set_end:
	mov %dl, %al
	
	cmp %bl, %cl
	jb chk_loop

	call newline

end:
	ret

# mette una maschera con un solo bit alto ad %al in mask
get_mask:
	push %eax
	push %edi
	push %ecx

	lea mask, %edi
	mov $8, %ecx

	push %ax

	mov $0, %eax

mask_clear_loop:
	stosl
	loop mask_clear_loop

	pop %ax

	lea mask, %edi

mask_dec_loop:
	cmp $31, %al
	ja mask_dec

	jmp post_mask_dec

mask_dec:
	sub $32, %al
	add $4, %edi

	jmp mask_dec_loop

post_mask_dec:
	mov $0x80000000, %ecx

mask_shr_loop:
	cmp $0, %al
	je mask_post_shr

	shr %ecx
	dec %al

	jmp mask_shr_loop
	
mask_post_shr:
	movl %ecx, (%edi)

	pop %ecx
	pop %edi
	pop %eax
	ret

# effettua un test fra flag e mask e imposta dl se risulta positivo
test_flag:
	push %esi
	push %edi
	push %cx
	push %eax

	xor %dl, %dl

	lea flag, %edi 
	lea mask, %esi 
	mov $8, %ecx
	
test_loop:
	movl (%edi), %eax
	andl (%esi), %eax

	cmp $0, %eax
	jne test_set

	dec %cx
	add $4, %edi
	add $4, %esi

	cmp $0, %cx
	ja test_loop

	jmp test_end

test_set:
	mov $1, %dl

test_end:
	pop %eax
	pop %cx
	pop %edi
	pop %esi
	ret

# effettua un or fra flag e mask
or_flag:
	push %esi
	push %edi
	push %cx
	push %eax

	lea flag, %edi 
	lea mask, %esi 
	mov $8, %ecx
	
or_loop:
	movl (%esi), %eax
	orl %eax, (%edi)

	dec %cx
	add $4, %edi
	add $4, %esi

	cmp $0, %cx
	ja or_loop

	jmp or_end

or_end:
	pop %eax
	pop %cx
	pop %edi
	pop %esi
	ret
