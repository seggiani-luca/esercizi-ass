# Implementare un sottoprogramma che copia un buffer di memoria in un altro. Il sottoprogramma 
# prende in ingresso %ESI, %EDI, ed %ECX come parametri, e questi contengono l’indirizzo sorgente, 
# destinatario ed il numero di byte da copiare. Si presti particolare attenzione al caso di buffer par-
# zialmente sovrapposti. 

.include "./files/utility.s"

.data
	from: .byte 0, 1, 2, 3, 4, 5, 6, 7

.text
_main:
	nop

	lea from, %esi 
	mov %esi, %edi
	add $2, %esi
	mov $4, %ecx

	call memcpy

	ret

memcpy:
	push %esi
	push %edi
	push %ecx
	
	cmp %edi, %esi
	jb backward
	
	cld
	
	rep movsb
	jmp end

backward:
	std
	
	add %ecx, %edi
	dec %edi
	
	add %ecx, %esi
	dec %esi

	rep movsb

end:
	pop %ecx
	pop %edi
	pop %esi
	ret
