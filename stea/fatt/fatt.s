# Si scriva un programma che calcola il fattoriale di un numero naturale (da 0 a 9) contenuto nella 
# variabile dato, di tipo byte. Il risultato deve essere inserito in una variabile risultato, di dimen-
# sione opportuna. Si controlli che dato non ecceda 9. Prestare attenzione al dimensionamento della 
# moltiplicazione. 

.include "./files/utility.s"

.data
	err_mess: .ascii "\nfuori scala\r"

.text
_main:
	nop
	
	call inbyte
	
	cmp $9, %al
	ja err_end
	
	xor %ah, %ah
	mov %ax, %bx

	mov $1, %cx
	mov $1, %ax

loop:
	inc %cx
	cmp %bx, %cx
	ja end

	mul %cx

	jmp loop

end:
	push %dx
	push %ax

	mov $'\r', %al
	call outchar

	pop %eax

	call outdecimal_long

	ret

err_end:
	mov $'\r', %al
	call outchar
	
	lea err_mess, %ebx
	call outline

	ret
