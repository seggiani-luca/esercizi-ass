.include "./files/utility.s"

.data
	string1: .fill 80, 1
	string2: .fill 80, 1

	mess1: .ascii "Le due stringhe sono identiche\r"
	mess2: .ascii "Le due stringhe differiscono al carattere: \r"

.text
_main:
	nop

	mov $80, %ecx
	lea string1, %ebx
	call inline

	mov $80, %ecx
	lea string2, %ebx
	call inline

	mov $80, %ecx

	lea string1, %esi
	lea string2, %edi
	
	rep cmpsb
	jne noteq

	jmp eq

noteq:
	lea mess2, %ebx
	call outline

	mov $80, %eax
	sub %ecx, %eax

	call outdecimal_long

	ret

eq:
	lea mess1, %ebx
	call outline
	
	ret
