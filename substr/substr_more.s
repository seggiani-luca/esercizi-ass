# Leggere una riga dal terminale
# Identificare e stampa la sottostringa delimitata dai primi due caratteri '_'
# Se un solo carattere '_' e' presente, assumere che la sottostringa cominci 
# ad inizio stringa e finisca prima del carattere '_'
# Se nessun carattere '_' e' presente, stampare l'intera stringa

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

	cmp $0, %ecx
	je end1
	
	mov %edi, %ebx
	
	repne scasb
	
	cmp $0, %ecx # e' sicuro, gli ultimi due caratteri sono \r\n
	je end2

	dec %edi
	movb $'\r', (%edi)
	
	call outline
	ret

end1:
	call outline
	ret

end2:
	dec %ebx
	movb $'\r', (%ebx)
	lea string, %ebx
	call outline
	ret

