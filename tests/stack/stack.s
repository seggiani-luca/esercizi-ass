.include "./files/utility.s"

.data

.text
_main:
	nop

	mov $0xabcd, %ax

	sub $2, %esp
	movw %ax, (%esp)

	mov $0xffff, %ax

	movw (%esp), %ax
	add $2, %esp

	ret
