# Scrivere un programma che legge una stringa di memoria lunga un numero arbitrario di caratteri 
# (ma terminata da \0), inserita in un buffer di memoria di indirizzo noto, e conta le volte che appare 
# il carattere specificato dentro un’altra locazione di memoria. Il risultato viene messo in una terza 
# locazione di memoria. 

.include "./files/utility.s"

.data
	string: .fill 80, 1 
	char: .byte 't'

.text
_main:
	nop
	
	mov $80, %ecx
	lea string, %ebx
	call inline

	call inchar

	xor %edi, %edi

	xor %ecx, %ecx

loop:
	movb string(%edi), %ah
	inc %edi
	
	cmpb $0x00, %ah
	je break

	cmpb %ah, %al
	je found
	
	jmp loop
	
found:
	inc %ecx
	jmp loop

break:
	mov %ecx, %eax
	call outdecimal_long
	
	ret
