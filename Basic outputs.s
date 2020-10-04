# This program calculates and prints the number of seconds in an hour, a day, and a week
# Output format:
# Hour: 3600
# Day: 86400
# Week: 604800

.data

#variable declaration
Hour: .asciiz "Hour: "
Day: .asciiz "Day: "
Week: .asciiz "Week: "
newLine: .asciiz "\n" # new line character

.text
main:

# prints "Hour: "
li $v0, 4
la $a0, Hour
syscall

li $t0, 60 # number of seconds in minute
mul $t1, $t0, $t0 # the number of seconds in an hour = 60 * 60, stores the value in $t1

# prints the number of seconds in an hour
li $v0, 1
move $a0, $t1
syscall

# prints a new line
la $a0, newLine
li $v0, 4
syscall

# prints "Day: "
la $a0, Day
li $v0, 4
syscall

mul $t2, $t1, 24 # the number of seconds in a day = number of seconds in an hour * 24

# prints the number of seconds in a day
li $v0, 1
move $a0, $t2
syscall

# prints a new line
la $a0, newLine
li $v0, 4
syscall

# prints "Week: "
la $a0, Week
li $v0, 4
syscall

mul $t3, $t2, 7 # the number of seconds in a week = number of seconds in a day * 7

# prints the number of seconds in a week
move $a0, $t3
li $v0, 1
syscall

# End of program
