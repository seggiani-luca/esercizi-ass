.include "./files/utility.s"

.data
	string1: .ASCIZ "La curiosita' uccise il gatto"
	
	mess1: .ASCII "Carattere trovato a: \r"
	mess2: .ASCII "Carattere non trovato\r"
.text
_main:
	nop

	mov $29, %ecx
	mov $''', %al
	lea string1, %edi
	
	repne scasb
	je found

	jmp notfound

found:
	lea mess1, %ebx
	call outline

	mov $29, %eax
	sub %ecx, %eax

	call outdecimal_long

	ret

notfound:
	lea mess2, %ebx
	call outline
	
	ret
