# scrivere un programma che accetta in ingresso una stringa di massimo 80 caratteri esclusivamente 
# minuscoli terminata da ritorno carrello, stampa i singoli caratteri mentre vengono digitati, poi va a 
# capo e stampa l’intera stringa a video in maiuscolo. 

.include "./files/utility.s"

.data
	string: .fill 80, 1, 0

.text
_main:
	nop
	
	lea string, %ebx
	mov $80, %ecx
	call inline

	mov $0, %ecx
	
loop:
	cmp $80, %ecx
	je end

	movb (%ebx, %ecx, 1), %al
	
	cmp $'a', %al
	jb late_loop

	cmp $'z', %al
	ja late_loop
	
	and $0xDF, %al

	movb %al, (%ebx, %ecx, 1)

late_loop:
	inc %ecx
	jmp loop

end:
	call outline
	ret
