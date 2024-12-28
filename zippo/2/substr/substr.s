# Leggere una riga dal terminale, che DEVE contenere almeno 2 caratteri '_'
# Identificare e stampa la sottostringa delimitata dai primi due caratteri '_'

.include "./files/utility.s"

.data
	string: .fill 80, 1

.text
_main:
	nop

	mov $80, %ecx
	lea string, %ebx
	call inline

	mov $80, %ecx
	mov %ebx, %edi

	mov $'_', %al
	
	cld
	
	repne scasb
	mov %edi, %ebx

	cmp $0, %ecx
	je end

	repne scasb
	
	cmp $0, %ecx # e' sicuro, gli ultimi due caratteri sono \r\n
	je end

	dec %edi
	movb $'\r', (%edi)
	
	call outline

end:
	ret
