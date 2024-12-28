# 1. Leggere messaggio da terminale.
# 2. Convertire le lettere minuscole in maiuscolo.
# 3. Stampare messaggio modificato.
# stavolta con le istruzioni di stringa

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

	cmp $'a', %al
	jb dopo
	cmp $'z', %al
	ja dopo

	and $0xdf, %al # 1101 1111

dopo:
	stosb

	cmp $'\r', %al
	jne loop
	
.terzo: # stampa stringa
	lea msg_out, %ebx
	call outline

	ret
