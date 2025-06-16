.data 
resultado: .space 4
.text 
li $v0, 5
syscall 
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
add $s2, $s0, $s1
sw $s2, resultado
li $v0, 1
lw $a0, resultado
syscall
li $v0, 17
li $a0, 0
syscall