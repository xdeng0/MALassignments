# This program takes user inputs of their weight and height and calculates their BMI
# BMI = Weight (lbs) / Height^2 (inches) * 703

.eqv print_int 1
.eqv input_int 5
.eqv print_str 4
.eqv sys_exit 10

        .data

weight: .asciiz "Please enter your weight (lbs): "
feet: .asciiz "Please enter your height\nft:"
inch: .asciiz "inch: "
BMI: .asciiz "Your BMI is: "

        .text

main:

        li   $v0, print_str     # prompt user to enter weight
        la   $a0, weight
        syscall

        li   $v0, input_int     # read input
        syscall
        move $s0, $v0           # load weight into $s0

        li   $v0, print_str     # prompt user to enter feet
        la   $a0, feet
        syscall

        li   $v0, input_int     # read input
        syscall
        move $s1, $v0           # load feet into $s1

        li   $v0, print_str     # prompts user to enter inch
        la   $a0, inch
        syscall

        li   $v0, input_int     # read input
        syscall
        move $s2, $v0           # load inch into $s2

        mul  $t0, $s1, 12       # convert feet to inch
        add  $t1, $t0, $s2      # calculate the total number of inches
        mul  $t2, $t1, $t1      # calculate height^2 (inches)

        mul  $t3, $s0, 703      # calculate weight * 703
        div  $t4, $t3, $t2      # weight * 703 / height^2, load value in $t4

        li   $v0, print_str     # print BMI
        la   $a0, BMI
        syscall

        li   $v0, print_int
        move $a0, $t4
        syscall

        li   $v0, sys_exit      # program exits
        syscall
