.data

krabby: .word 1 2 3 4 5 6 7 8 9 10

carray: .word 0:10

marray: .word 0:10

# beginningtest: .asciiz "start loop\n"
# printtest: .asciiz "printing 1\n"
# printtest2: .asciiz "printing 2\n"
# printloop: .asciiz "printed\n"

encrypted: .asciiz "Encrypted: "
decrypted: .asciiz "Decrypted: "
comma: .asciiz ", "
newline: .asciiz "\n"

.text
main:
	la $a0,krabby
	li $a1,10

	la $a2,carray
	la $a3,marray
	
	#fill in your loop here
	#feel free to use 2 loops if you need to
    move $s0 $a0
    move $s1 $a1
    move $s2 $a2
    move $s3 $a3
    li $s4 0

    j loop_main
    
loop_main:
    beq $s4 $s1 main_2

################
    # li $v0 4
    # la $a0 beginningtest
    # syscall
################

    #apply secret formula
    li $a0 3
    li $a1 11
    li $t0 4
    mult $s4 $t0
    mflo $s5
    move $t0 $s5
    addu $t0 $t0 $s0
    lw $a2 0($t0)
    jal secret_formula_apply

    #load into c_arr
    move $t0 $s5
    addu $t0 $t0 $s2
    sw $v0 0($t0)

################
    # move $a0 $s5
    # li $v0 1
    # syscall
################

    #remove secret formula
    li $a0 3
    li $a1 11
    move $t0 $s5
    addu $t0 $t0 $s2
    lw $a2 0($t0)
    jal secret_formula_remove

    #load into m_arr from c_arr
    move $t0 $s5
    addu $t0 $t0 $s3
    sw $v0 0($t0)

    addiu $s4 $s4 1
    j loop_main


main_2:
    li $t0 1
    li $t1 10
    li $t2 4

    li $v0 4
    la $a0 encrypted
    syscall
    move $t3 $s2
    lw $a0 0($t3)
    li $v0 1
    syscall
    jal print_c_arr

    li $v0 4
    la $a0 decrypted
    syscall
    li $t0 0
    move $t3 $s3
    lw $a0 0($t3)
    li $v0 1
    syscall
    jal print_m_arr

    j exit


print_c_arr:
    beq $t0 $t1 c_arr_exit

    li $v0 4
    la $a0 comma
    syscall

    mult $t0 $t2
    mflo $t3
    addu $t3 $t3 $s2
    lw $a0 0($t3)
    li $v0 1
    syscall
    
    # li $v0 4
    # la $a0 printloop
    # syscall

    addiu $t0 $t0 1
    j print_c_arr

c_arr_exit:

    li $v0 4
    la $a0 newline
    syscall

    jr $ra


print_m_arr:
    beq $t0 $t1 m_arr_exit

    li $v0 4
    la $a0 comma
    syscall

    mult $t0 $t2
    mflo $t3
    addu $t3 $t3 $s3
    lw $a0 0($t3)
    li $v0 1
    syscall

    # li $v0 4
    # la $a0 printloop
    # syscall

    addiu $t0 $t0 1
    j print_m_arr

m_arr_exit:
    jr $ra


# $a0 = x, $a1 = y, $a2 = m
secret_formula_apply:
    move $s6 $ra
    #fill stuff here thanks
    li $t0 7
    mult $a0 $a1



    mflo $t1
    move $t3 $a2 #t3 = result of each iteration of pow(m,e)
    li $t4 1 #t4 = iteration counter

    jal loop_apply
    move $t3 $v0
    div $t3 $t1
    mfhi $v0

    move $ra $s6
    jr $ra



secret_formula_remove:
    move $s6 $ra
    #fill more stuff here thanks
    li $t0 3
    mult $a0 $a1
    mflo $t1
    move $t3 $a2 #t3 = result of each iteration of pow(m,e)
    li $t4 1 #t4 = iteration counter
   
    jal loop_apply
    move $t3 $v0
    div $t3 $t1  
    mfhi $v0

    move $ra $s6
    jr $ra


loop_apply:
    beq $t4 $t0 loop_apply_2
    mult $t3 $a2
    mflo $t3
    addiu $t4 $t4 1
    j loop_apply

loop_apply_2:
    # li $v0 1
    # move $a0 $t3
    # syscall
    
    move $v0 $t3
    
    jr $ra




exit:
	li $v0, 10
	syscall