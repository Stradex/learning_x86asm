#PURPOSE:	Calculate the square of 3 plus square of 2.

.section .data
# No global data
.section .text
# No text

.globl _start
.globl square
_start:
	pushl $3		#Pass 3 as the first argument of the square function
	call square		#Call the square function
	addl $4, %esp		#Move the stack pointer back (4*number of long arguments)
	pushl %eax		#Save first answer
	pushl $2		#Pass 2 as the first argument of the square function
	call square		#Call the square function
	addl $4, %esp		#Move the stack pointer back (4*number of long arguments)
	popl %ebx		#Restore first answer
	addl %eax, %ebx
	movl $1, %eax		#Se the kernel system call code to 1, it means exit program
	int  $0x80

#PURPOSE:	Calculate the square of a number
#
#INPUT:		First argument: Number to be squared.
#
#OUTPUT:	Square of the number. 
.type square, @function
square:
	pushl %ebp		#Save old base pointer
	movl %esp, %ebp		#Make stack pointer the base pointer
	movl 8(%ebp), %eax	#Put first argument in %ebx
	imull 8(%ebp), %eax

square_end:
	movl %ebp, %esp		#restore the stack pointer
	popl %ebp		#restore the base pointer
	ret
