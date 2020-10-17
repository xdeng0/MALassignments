# This program translates following if statement in C++ to MIPS assembly language
# int x = 15;
# int y = 12;
# int z = 5;

# if (x > 0 && y > 10 && z < 0) {
# 	x = x + 1;
# }

# cout << x;

# if (y > 10  || x < 20 || z == 5) {
# 	y = y + 1;
# }

# cout << y;

.eqv PRINT_INT 1
.eqv PRINT_STRING 4
.eqv SYS_EXIT 10

	.data

new_line: .asciiz "\n"

	.text

main:

	li 	$s1, 15 		# x = 15
	li 	$s2, 12 		# y = 12
	li 	$s3, 5  		# z = 5

	ble 	$s1, 0, print_x 	# if !(x > 0)
	ble 	$s2, 10, print_x	# if !(y > 10)
	bge 	$s3, 0, print_x		# if !(z < 0)
	addi	$s1, $s1, 1		# x = x + 1

print_x:
	move	$a0, $s1		# print the value of x
	li 	$v0, PRINT_INT
	syscall

	li 	$v0, PRINT_STRING 	# print a new line
	la 	$a0, new_line
	syscall

	bgt 	$s2, 10, increment	# if (y > 10), if false, evaluate next OR condition
	blt 	$s1, 20, increment	# if (x < 20)
	bne 	$s3, 5, print_y		# if !(z == 5)

increment:
	addi 	$s2, $s2, 1		# y = y + 1

print_y:
	move 	$a0, $s2		# print the value of y
	li 	$v0, PRINT_INT
	syscall

	li 	$v0, SYS_EXIT
	syscall              		# program exits
