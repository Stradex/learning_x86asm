#PURPOSE:	This program finds the maximum number of a set of data items.
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used to terminate the data.

.section .data

data_items:		#These are the data items.
.long 67,34,7,45,75,54,1,44,33,22,11,66,0

.section .text

.globl _start
_start:
lea data_items, %eax			# Copy the memory address at the start of data_items to %eax
pushl %eax				# push first argument
call max				# Call max function
addl $4, %esp				# Move the stack pointer back 
movl %eax, %ebx				# Move function result to exit error code (%ebx)
movl $1, %eax				# Set the system call %eax to 1, meaning exit program.
int $0x80


#PURPOSE:	This function finds the maximum number of a set of data items.
#
#INPUT:
#		8(%ebp) - Memory address location for the start of a long number list.
#LOCAL VARIABLES:
#
#		-4(%ebp) - Index of the current value
#		-8(%ebp) - Current max value
#
#RETURN:
#		Highest value in that list of numbers.
#
#DOC:		The list of numbers ends when the number zero is reached.
.type max, @function
max:
	pushl %ebp			#save old base pointer
	movl %esp, %ebp			#make stack pointer the base pointer
	subl $8, %esp			#Make space for our local storage
	movl 8(%ebp), %ebx		#Store the memory address of my number list in %ebx register
	movl $0, -4(%ebp)		#Set zero as the current index
	movl -4(%ebp), %edi		#Set the current index in the %edi index register
	movl (%ebx, %edi, 4), %ecx 	#Save the first value in %ecx
	movl %ecx, -8(%ebp)		#Move the value from %ecx into the current max value local variable.
max_loop:
	cmpl $0, %ecx
	je max_end			#if current value is zero, jump to exit.
	movl -4(%ebp), %edi		#Move to next index...
	incl %edi			#increment the index by one
	movl %edi, -4(%ebp)		#update index
	movl (%ebx, %edi, 4), %ecx	#Copy current value into %ecx
	movl -8(%ebp), %edx		#Copy current maximum value into %edx
	cmpl %edx, %ecx			#compare current value with maximum value stored.
	jle max_loop
	movl %ecx, -8(%ebp)
	jmp max_loop
max_end:
	movl -8(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
