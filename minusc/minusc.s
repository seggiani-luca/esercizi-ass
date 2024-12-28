# leggere messaggio da terminale
# convertire le lettere maiuscole in minuscolo
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

.secondo: # converti stringa
	lea msg_in, %esi
	lea msg_out, %edi
	mov $0, %ecx

loop:
	# offset(%base, %indice, scala(1, 2, 4, ...))
	movb (%esi, %ecx), %al

	cmp $'A', %al
	jb dopo
	cmp $'Z', %al
	ja dopo

	xor $0x20, %al # 0010 0000

dopo:
	movb %al, (%edi, %ecx)
	inc %ecx
	cmp $'\r', %al
	jne loop

.terzo: # stampa stringa
	lea msg_out, %ebx
	call outline

	ret
