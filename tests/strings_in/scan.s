.include "./files/utility.s"

.data
	string1: .fill 80, 1
	
	mess1: .ascii "Carattere trovato a: \r"
	mess2: .ascii "Carattere non trovato\r"
.text
_main:
	nop

	mov $80, %ecx
	lea string1, %ebx
	call inline

	call inchar

	mov $80, %ecx
	lea string1, %edi
	
	repne scasb
	je found

	jmp notfound

found:
	lea mess1, %ebx
	call outline

	mov $80, %eax
	sub %ecx, %eax

	call outdecimal_long

	ret

notfound:
	lea mess2, %ebx
	call outline
	
	ret
