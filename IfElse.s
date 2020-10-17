# This program translates the following C++ code into MIPS Assembly language
# int main () {
# 	int q = 5;
#	int y = 17;
#	int x = 77;

#	if (q < 10) {
#		cout << "inside if";
#	} elseif (x > 0 || y < 10) {
#		cout << "inside elseif";
#	} else {
#		cout << "inside else";
#	}
# }

.eqv PRINT_STR 4
.eqv SYS_EXIT 10

	.data

in_if: .asciiz "inside if"
in_elseif: .asciiz "inside elseif"
in_else: .asciiz "inside else"

	.text

main:

	li 	$s0, 15 				# int q = 5;
	li 	$s1, 17 				# int y = 17
	li 	$s2, -7 				# int x = 77;

	bge	$s0, 10, else_if 		  	# branch if !(q < 10)
	li 	$v0, PRINT_STR 		  		# print "inside if"
	la 	$a0, in_if
	syscall
	j 	exit 				  	# condition was met, no need to check other conditions

else_if:
	bgt 	$s2, 0, print_elseif 			# elseif (x > 0), if false, check next elseif condition
	bge 	$s1, 10, print_else 			# !(y < 10), if true, print "inside else"

print_elseif:
	li 	$v0, PRINT_STR 				# print "inside elseif"
	la 	$a0, in_elseif
	syscall
	j 	exit 					# condition was met, exit out of conditional branch

print_else:
	li 	$v0, PRINT_STR 				# print "inside else"
	la 	$a0, in_else
	syscall

exit:
	li 	$v0, SYS_EXIT				# program exits
	syscall
