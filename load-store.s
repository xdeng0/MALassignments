# This program writes the following C++ code in MIPS assembly language
# int i;
# int size = 10;
# int even_sum = 0;
# int pos_sum = 0;
# int neg_sum = 0;
# int arr[10] = {12, -1, 8, 0, 6, 85, -74, 23, 99, -30};

# for(i = size-1; i >= 0; i--){

#       if(arr[i] % 2 == 0){
#               even_sum += arr[i];
#       }

#       if (arr[i] > 0){
#               pos_sum += arr[i];
#       }

#       if (arr[i] < 0){
#               neg_sum += arr[i];
#       }

# }

# cout << even_sum << "\n";
# cout << pos_sum << "\n";
# cout << neg_sum << "\n";

.eqv PRINT_INT 1
.eqv PRINT_STR 4
.eqv SYS_EXIT 10

        .data

arr: .word 12, -1, 8, 0, 6, 85, -74, 23, 99, -30
newLine: .asciiz "\n"

        .text

main:

        li      $s0, 0                       # even_sum
        li      $s1, 0                       # pos_sum
        li      $s2, 0                       # neg_sum
        li      $s3, 10                      # size
        sub     $t0, $s3, 1                  # i = size - 1
        la      $t1, arr                     # load address of arr

loop:
        lw      $t2, ($t1)                   # load current element of array
        andi    $t3, $t2, 1                  # get least significant bit of current array element
        bnez    $t3, check_sign              # check if least significant bit is 0 (negated)
        add     $s0, $s0, $t2                # add current element to even_sum

check_sign:
        beqz    $t2, iterate                 # if current element == 0, go to iterate
        blt     $t2, 0, add_neg              # check if current element is positive or negative
        add     $s1, $s1, $t2                # add current element to pos_sum
        j       iterate

add_neg:
        add     $s2, $s2, $t2                # add current element to neg_sum

iterate:
        sub     $t0, $t0, 1                  # i--
        addi    $t1, $t1, 4                  # move array pointer to the address of next element
        bge     $t0, 0, loop                 # if still inside array, go back to loop

print_result:
        li      $v0, PRINT_INT               # print even_sum
        move    $a0, $s0
        syscall

        li      $v0, PRINT_STR               # print a new line
        la      $a0, newLine
        syscall

        li      $v0, PRINT_INT               # print pos_sum
        move    $a0, $s1
        syscall

        li      $v0, PRINT_STR               # print a new line
        la      $a0, newLine
        syscall

        li      $v0, PRINT_INT               # print neg_sum
        move    $a0, $s2
        syscall

        li      $v0, PRINT_STR               # print a new line
        la      $a0, newLine
        syscall

        li      $v0, SYS_EXIT
        syscall                              # program exits
