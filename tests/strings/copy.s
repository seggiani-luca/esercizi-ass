.include "./files/utility.s"

.data
	string: .ASCII "Ciao mondo!\r"
	dest: .fill 12, 1

.text
_main:
	nop

	lea string, %esi
	lea dest, %edi
	mov $12, %ecx

loop:
	movb (%esi), %al
	movb %al, (%edi)

	inc %esi
	inc %edi
	dec %ecx

	cmp $0x00, %ecx
	jne loop

	lea dest, %ebx
	call outline

	ret
