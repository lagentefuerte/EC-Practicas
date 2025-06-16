.data 
c: .space 1

.text 
li $v0, 5
syscall 

move $s0, $v0
li $v0, 5
syscall

move $s1, $v0
slti $t0, $s0, 15
sge $t1, $s0, 5
and $t0, $t0, $t1
sgt $t1, $s1, $s0
sge $t2, $s0, 10
and $t1, $t1, $t2
or $s0, $t0, $t1
sw $s0, c

li $v0, 1
lw $a0, c
syscall

li $v0, 17
li $a0, 0
syscall