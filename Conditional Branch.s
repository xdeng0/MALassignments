# if/else statement implementation in MIPS Assembly language
# This program translates the following C++ code into MIPS assembly language
# int main (){
#		int q = 5;
#		int y = 17;
#		int x = 77;

#		if (q < 10){
#			cout << "inside if";
#		}elseif (x > 0 || y <10){
#			cout << "inside elseif";
#		}else {
#			cout << "inside else";
#		}
# }

.data # label declarations follow this line

# load strings into labels for outputs
InsideIf: .asciiz "inside if"
ElseIf: .asciiz "inside elseif"
Else: .asciiz "inside else"

.text # instructions follow this line

main:
# load values into registers
li $s0, 5 #q
li $s1, 17 #y
li $s2, 77 #x

bge $s0, 10, CheckElseIf # check if q >= 10 (negating condition q < 10), if true, then q is not less than 10, go to CheckElseIf to perform next conditional statement
# if q >= 10 is false, then q is less than 10, perform the following lines to print "inside if" then exit out of the conditional statement
li $v0, 4
la $a0, InsideIf
syscall
j exit

CheckElseIf: bgt $s2, 0, InsideElseIf # check if the 1st OR condition inside elseif (x > 0) is true, if yes, go to InsideElseIf to print corresponding string then exit
# if the conditional statement above is false, then proceed to the following line to check 2nd OR condition in elseif statement (y < 10)
bge $s1, 10, InsideElse # negating y < 10, if statement is true, then y >= 10, go to InsideElse; if false, then y < 10, proceed to the following line to print out corresponding string then exit

InsideElseIf: # print string "inside elseif" then exit out of conditional statement
		li $v0, 4
		la $a0, ElseIf
		syscall
		j exit
InsideElse: # print string "inside else"
		li $v0, 4
		la $a0, Else
		syscall
exit:

# end of program
