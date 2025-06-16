.data 
cociente: .space 4
resto: .space 4
salto: .asciiz "\n"

.text 
li $v0, 5
syscall 

move $s0, $v0
li $v0, 5
syscall

move $s1, $v0
div $s0, $s1
mfhi $s2
mflo $s3
sw $s2, resto
sw $s3, cociente

li $v0, 1
lw $a0, cociente
syscall

li $v0, 4
la $a0, salto
syscall

li $v0, 1
lw $a0, resto
syscall

li $v0, 17
li $a0, 0
syscall