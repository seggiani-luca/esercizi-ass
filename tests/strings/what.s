.include "./files/utility.s"

.DATA
	array1: .WORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 
	array2: .WORD 1, 2, 3, 4, 7, 6, 7, 8, 9, 10  
	 
.TEXT
_main:
	CLD 
	 
	LEA array1, %ESI 	 
	LEA array2, %EDI 
	 
	MOV $10, %ECX 
	REPE CMPSW
	
	RET
