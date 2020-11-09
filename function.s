# This program implements following C++ code in MIPS assembly language
# void printValue(int num){
#     cout << "Number is: " << num << "\n";
# }

# int loopPrinter(int size){
#    int s0;
#    for( s0 = 0; s0 <= size; s0++){
#        printValue(s0);
#    }
#    return s0+=10;
#  }

# int main(){
#     int s0 = 5;
#     int s1 = loopPrinter(s0);
#     printValue(s0);
#     printValue(s1);
# }

.eqv PRINT_INT 1
.eqv PRINT_STR 4
.eqv SYS_EXIT 10

	.data

str: .asciiz "Number is: "
new_line: .asciiz "\n"

	.text

main:
	li   $s0, 5
	move $a0, $s0		# use $s0 as argument for loop_printer function call
	jal  loop_printer
	move $s1, $v0 		# save return value of loop_printer to $s1
	move $a0, $s0 		# use $s0 as argument for print_value function call
	jal  print_value
	move $a0, $s1 		# use $s1 as argument for print_value function call
	jal  print_value
	j    exit

loop_printer:
	addi $sp, $sp, -12 	# adjust stack for 3 items
	sw   $s1, 8($sp) 	# save $s1 to stack
	sw   $ra, 4($sp) 	# save return address
	sw   $s0, 0($sp) 	# save $s0 to stack
	li   $s0, 0
	move $s1, $a0 		# save a copy of argument into $s1
	bgt  $s0, $s1, return 	# test for s0 <= size (negated)

loop:
	move $a0, $s0 		# use $s0 as argument for print_value function call
	jal  print_value
	addi $s0, $s0, 1 	# s0++
	ble  $s0, $s1, loop 	# test for s0 <= size

return:
	addi $s0, $s0, 10 	# s0+=10
	move $v0, $s0 		# save return value in $v0
	lw   $s1, 8($sp) 	# restore $s1
	lw   $ra, 4($sp) 	# restore return address
	lw   $s0, 0($sp) 	# restore $s0
	addi $sp, $sp, 12 	# adjust stack pointer to pop 3 items
	jr   $ra 		# return to caller

print_value:
	move $t0, $a0 		# save a copy of argument into $t0
	# print "Number is: "
	la   $a0, str
	li   $v0, PRINT_STR
	syscall
	# print value stored in $t0
	move $a0, $t0
	li   $v0, PRINT_INT
	syscall
	# print a new line
	la   $a0, new_line
	li   $v0, PRINT_STR
	syscall
	jr   $ra 		# return to caller

exit:
	li   $v0, SYS_EXIT
	syscall 		# program exits
