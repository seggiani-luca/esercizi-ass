# leggere messaggio da terminale
# convertire le lettere maiuscole in minuscolo, usando istruzioni stringa
# stampare messaggio modificato

.include "./files/utility.s"

.data
msg_in: .fill 80, 1, 0
msg_out: .fill 80, 1, 0

.text
_main:
	nop

.primo: # leggi stringa
	mov $80, %cx
	lea msg_in, %ebx
	call inline

.secondo: # converti string
	lea msg_in, %esi
	lea msg_out, %edi
	
	cld

loop:
	lodsb

	cmp $'A', %al
	jb dopo
	cmp $'Z', %al
	ja dopo

	xor $0x20, %al # 0010 0000

dopo:
	stosb

	cmp $'\r', %al
	jne loop
	
.terzo: # stampa stringa
	lea msg_out, %ebx
	call outline

	ret
