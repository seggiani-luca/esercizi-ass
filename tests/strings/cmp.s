.include "./files/utility.s"

.data
	string1: .ASCIZ "Questa e' una stringa"
	string2: .ASCIZ "Questa e' una stringa"

	mess1: .ASCII "Le due stringhe sono identiche\r"
mess2: .ASCII "Le due stringhe differiscono al carattere: \r"

.text
_main:
	nop

	mov $22, %ecx
	lea string1, %esi
	lea string2, %edi
	
	rep cmpsb
	jne noteq

	jmp eq

noteq:
	lea mess2, %ebx
	call outline

	mov $22, %eax
	sub %ecx, %eax

	call outdecimal_long

	ret

eq:
	lea mess1, %ebx
	call outline
	
	ret
