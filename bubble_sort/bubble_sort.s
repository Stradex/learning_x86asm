#PURPOSE:	This program finds the maximum number of a set of data items.
#
#VARIABLES:	The registers have the following uses:
#
# %edi - Holds the index of the current data being examined
# %esi - Holds the index of the next data being examined
# %ah - Current value
# %al - Next value
# %cl - boolean to check if list is sorted.
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used to terminate the data.

.section .data
data_items:
.byte 12,8,4,2,6,10,0

.section .text

.globl _start
_start:
mov $0, %cl				# Set list ordered to zero
jmp sort_loop

switch_items:
mov $0, %cl				# If we have to switch elements. Then the list is not ordered
mov %al, data_items(,%esi,1)
mov %ah, data_items(,%edi,1)
incl %edi				# increment index (i)
jmp for_loop

for_loop:
mov data_items(,%edi,1), %al		# load current value (%al = data_items[i])
cmp $0, %al				# check if end of list (0)
je sort_loop
movl %edi, %esi
incl %esi				# increment index (i+1)
mov data_items(,%esi,1), %ah		# load next value (%ah = data_items[i+1])
cmp $0, %ah				# check if end of list (0)
je sort_loop
cmp %al, %ah
jg switch_items
incl %edi
jmp for_loop

sort_loop:
cmp $1, %cl				# check if list is already sorted
je loop_exit
mov $1, %cl				# Let's assume list is sorted
mov $0, %edi				# move 0 into the index register
jmp for_loop

loop_exit:
# %ebx is the status code for the exit system call
# and it already has the maximum number
movl $0, %edi
movzx data_items(,%edi,1), %ebx
mov $1, %eax
int $0x80
