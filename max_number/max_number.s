#PURPOSE:	This program finds the maximum number of a set of data items.
#
#VARIABLES:	The registers have the following uses:
#
# %edi - Holds the index of the data being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used to terminate the data.

.section .data

data_items:		#These are the data items.
.long 3,67,34,222,45,75,54,1,44,33,22,11,66,224

.section .text

.globl _start
_start:
movl $0, %edi				# move 0 into the index register
movl data_items(,%edi,4), %eax		# load the first byte of data as current data item.
movl %eax, %ebx				# since this is the first item, %eax is the biggest.
jmp min_loop

min_loop:
cmpl $255, %eax				# check to see if we've hit the end
je loop_exit
incl %edi				# load next value (increment %edi by 1)
movl data_items(,%edi,4), %eax
cmpl $255, %eax				# check to see if we've hit the end
je loop_exit
cmpl %ebx, %eax				# compare values
jge min_loop				# jump to loop if the new one isn't bigger
movl %eax, %ebx				# move the value as the largest
jmp min_loop

max_loop:
cmpl $255, %eax				# check to see if we've hit the end
je loop_exit
incl %edi				# load next value (increment %edi by 1)
movl data_items(,%edi,4), %eax
cmpl %ebx, %eax				# compare values
jle max_loop				# jump to loop if the new one isn't bigger
movl %eax, %ebx				# move the value as the largest
jmp max_loop

loop_exit:
# %ebx is the status code for the exit system call
# and it already has the maximum number
movl $1, %eax
int $0x80
