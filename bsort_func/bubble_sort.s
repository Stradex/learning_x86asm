#PURPOSE:	This program will sort in ASC order the elements at data_items
#		and it will return (as error code) the first element of that sorted array/list
#
# data_items - contains the item data. A 0 is used to terminate the data.

.section .data
data_items:
.long 12,8,4,2,6,10,9,16,3,1,7,9,0

.section .text

.globl _start
_start:
lea data_items, %eax			# Copy the memory address at the start of data_items to %eax
pushl %eax				# push first argument
call bubble_sort			# call the bubble_sort
addl $8, %esp				# move the stack pointer back
movl $0, %edi				# set the index register %edi to zero
movl (%eax,%edi,4), %ebx		# set the %ebx to be the value of the first element at the sorted array
					# that was returned by the bubble_sort function (%eax).
mov $1, %eax				# exit (%ebx is returned)
int $0x80

#PURPOSE:	Function that sorts using a set of data items in ASC order.
#
#PARAMS:
# %ebx - Holds the start memory address for the list of data to sort.
#
#LOCAL PARAMS:
#
# -4(%ebp) - Holds the index of the current data being examined
# -8(%ebp) - Holds the index of the next data being examined
# -12(%ebp) - Current value
# -16(%ebp) - Next value
# -20(%ebp) - boolean to check if list is sorted


.type bubble_sort, @function
bubble_sort:
pushl %ebp				# save old base pointer
movl %esp, %ebp				# make stack pointer the base pointer
subl $20, %esp				# get room for our local storage
movl 8(%ebp), %ebx			# put first argument in %ebx
movl $0, -20(%ebp)			# set list as unordered
jmp sort_loop

sort_loop:
cmpl $1, -20(%ebp)			# check if list is already sorted
je loop_exit
movl $1, -20(%ebp)			# Let's assume list is sorted
movl $0, -4(%ebp)			# move 0 into the current data being examined index
jmp for_loop

switch_items:
movl $0, -20(%ebp)			# If we have to switch elements. Then the list is not ordered
movl -4(%ebp), %esi			# Let's set the %esi register to be the index of the current element
movl -16(%ebp), %ecx			# Let's set %ecx to be the value of the next element
movl %ecx, (%ebx,%esi,4)		# Replace the value of the current element with %ecx
movl -8(%ebp), %esi			# Let's set %esi register to be the index of the next element
movl -12(%ebp), %ecx			# Let's set %ecx register to be the value of the current element
movl %ecx, (%ebx,%esi,4)		# Replace the value of the next element with %ecx
movl -4(%ebp), %esi			# Set %esi to be the index of the current element.			
incl %esi				# Increment the value of %esi (equivalent to %esi++)
movl %esi, -4(%ebp)			# Apply the increment of the index
jmp for_loop

for_loop:
movl -4(%ebp), %esi			# Set %esi to be the index of the current element
movl (%ebx,%esi,4), %ecx		# Set the %ecx register to have the value of the current element 
movl %ecx, -12(%ebp)			# Set the current value local variable to have the value of %ecx
cmpl $0, -12(%ebp)			# Check if we reached the end of the list (if the current value is zero)
je sort_loop				# 	-> if true, then let's go back to sort_loop
movl -4(%ebp), %esi			# Set %esi to be the index of the current element
incl %esi				# increment the index (%esi++)
movl %esi, -8(%ebp)			# Set the local variable -8(%ebp) to be the value of %esi (next index)
movl (%ebx,%esi,4), %ecx		# Set %ecx to be the value of the next element
movl %ecx, -16(%ebp)			# Set -16(%ebp) local variable to be the value of the %ecx
cmpl $0, -16(%ebp)			# check if the next element is the end of the list
je sort_loop				# 	-> if true, then let's go back to sort_loop
cmpl -12(%ebp), %ecx			# compare the value of the current item with the next item in the list.
jl switch_items				# 	-> if the next item is lower than the current item,
					#	   then let's go to switch_items
movl -4(%ebp), %esi			# set %esi to be the index of the current element
incl %esi				# increment %esi (%esi++)
movl %esi, -4(%ebp)			# update the index to be the next one
jmp for_loop

loop_exit:
movl %ebx, %eax				# return value will be memory address location of the ordered sorted list
movl %ebp, %esp				# restore the stack pointer
popl %ebp				# restore the base pointer
ret					# end function
