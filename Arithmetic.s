# This program takes user inputs of their weight and height and calculates and outputs their BMI
# BMI = Weight (lbs) / Height^2 (inches) * 703

.data

Weight: .asciiz "Please enter your weight (lbs): "
Feet: .asciiz "Please enter your height\nft:"
Inch: .asciiz "inch: "
BMI: .asciiz "Your BMI is: "

.text

main:

# prompts user to enter weight
li $v0, 4
la $a0, Weight
syscall

# reads input
li $v0, 5
syscall
move $s0, $v0 #stores weight in $s0

# prompts user to enter feet
li $v0, 4
la $a0, Feet
syscall

li $v0, 5
syscall
move $s1, $v0 #stores feet in $s1

# prompts user to enter inch
li $v0, 4
la $a0, Inch
syscall

li $v0, 5
syscall
move $s2, $v0 # stores inch in $s2

mul $t0, $s1, 12 # convert feet to inch
add $t1, $t0, $s2 # calculate the total number of inches
mul $t2, $t1, $t1 # calculate height^2 (inches)

mul $t3, $s0, 703 # weight * 703
div $t4, $t3, $t2 # weight * 703 / height^2, stores BMI in $t4

li $v0, 4
la $a0, BMI
syscall

# prints BMI
li $v0,1
move $a0, $t4
syscall

# end of program
