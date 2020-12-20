# Final Project - CSC 256 Machine Structures
# Description: https://github.com/sohe1l/mips-assembly/tree/master/assignment/2020-fall/stack
# starter code: https://github.com/sohe1l/mips-assembly/blob/master/assignment/2020-fall/stack/stack.asm

.eqv PRINT_INT 1
.eqv PRINT_STRING 4
.eqv PRINT_CHAR 11
.eqv INPUT_INT 5
.eqv SYS_EXIT 10

	.data

# the array that would hold stack elements
arr: .word 0:100

jumpTable: .word exit, push, pop, max, rotate # jump table that holds operations

endl:		.asciiz  "\n"
space:		.asciiz  " "
label_arr:	.asciiz  "Current elemnets: "
label_inst:	.asciiz  "Enter 1 to push, 2 to pop, 3 to find max, 4 to rotate, 0 to exit\n"
label_invalid:	.asciiz  "Invalid option \n"
label_empty:	.asciiz  "Array is empty \n"
label_max:	.asciiz  "Max is: "

	.text
main:
	la   $s0, arr			# $s0: array pointer
	la   $s1, arr			# $s1: array base address
	la   $s2, jumpTable		# $s2: jumpTable base address

loop:
	li   $v0, PRINT_STRING 		# display options
	la   $a0, label_inst
	syscall

	li   $v0, INPUT_INT 		# take user input
	syscall

	bltz $v0, print_invalid 	# check if user input is in valid range (0-4)
	slti $t0, $v0, 5
	beqz $t0, print_invalid

	sll  $t1, $v0, 2		# calculate offset
	add  $t0, $s2, $t1		# $t0 = jump table base address + offset
	lw   $t2, ($t0)			# load target operation address
	jr   $t2

print_invalid:
	la   $a0, label_invalid 	# print "Invalid option"
	li   $v0, PRINT_STRING
	syscall
	j    loop

exit:
	li   $v0, SYS_EXIT		# program exits
	syscall

print_arr:
	la   $a0, label_arr		# print out "Current elements: "
	li   $v0, PRINT_STRING
	syscall
	move $t0, $s1			# load array base address

print_loop:
	lw   $a0, ($t0)			# print current element
	li   $v0, PRINT_INT
	syscall

	la   $a0, space			# print a space
	li   $v0, PRINT_STRING
	syscall

	addi $t0, $t0, 4 		# move pointer to next address
	blt  $t0, $s0, print_loop	# check if end of array is reached

	la   $a0, endl 			# print a new line
	li   $v0, PRINT_STRING
	syscall
	j    loop

push:
	li   $v0, INPUT_INT 		# take user input
	syscall

	sw   $v0, ($s0) 		# store user input to current array address
	addi $s0, $s0, 4 		# move pointer to next address
	j    print_arr

pop:
	beq  $s0, $s1, print_empty 	# check if array is empty
	addi $s0, $s0, -4 		# update array pointer
	beq  $s0, $s1, print_empty 	# check if array is empty after pop
	j    print_arr

max:
	beq  $s0, $s1, print_empty 	# check if array is empty
	move $t0, $s1 			# $t0: temporary array pointer
	lw   $t1, ($t0) 		# $t1: current max

max_loop:
	addi $t0, $t0, 4 		# move to next array address
	beq  $t0, $s0, print_max 	# check if end of array is reached
	lw   $t2, ($t0) 		# $t2: current array element
	bge  $t1, $t2, max_loop 	# check if max is greater than current element
	move $t1, $t2 			# update max
	j    max_loop

print_max:
	li   $v0, PRINT_STRING 		# print "Max is: "
	la   $a0, label_max
	syscall

	li   $v0, PRINT_INT 		# print max value in array
	move $a0, $t1
	syscall

	la   $a0, endl 			# print a new line
	li   $v0, PRINT_STRING
	syscall

	j    print_arr

print_empty:
	li   $v0, PRINT_STRING 		# print "Array is empty \n"
	la   $a0, label_empty
	syscall
	j    loop

rotate:
	beq  $s0, $s1, print_empty 	# check if array is empty
	addi $t0, $s0, -4 		# $t0: address of last element
	beq  $t0, $s1, print_arr 	# print array if there's only 1 element in array
	lw   $t1, ($t0) 		# save a copy of last element in $t1 before rotate

rotate_loop:
	lw   $t2, -4($t0) 		# shift each element to the right by 1
	sw   $t2, ($t0)
	addi $t0, $t0, -4

	bgt  $t0, $s1, rotate_loop 	# check if beginning of array is reached
	sw   $t1, ($s1) 		# store last element before rotate at the first slot
	j    print_arr
