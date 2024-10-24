# leggere un messaggio da terminale
# convertire le lettere maiuscole in minuscole
# stampare il messaggio modificato

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

	cmp $'a', %al
	jb dopo
	cmp $'z', %al
	ja dopo

	and $0xdf, %al # 1101 1111

dopo:
	movb %al, (%edi, %ecx)
	inc %ecx
	cmp $'\r', %al
	jne loop

.terzo: # stampa stringa
	lea msg_out, %ebx
	call outline

	ret
