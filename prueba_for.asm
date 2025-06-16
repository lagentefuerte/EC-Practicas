.data 
v: .word 10,20,30,40,50
salto: .asciiz "\n"
.text 
li $s0, 0 #variable i
la $t0, v #v + t*i
la $s2, v #valor de v, fijo
li $s1, 5 #n
while: beq $s0, $s1, end_while #while (i != n)
li $v0, 1
lw $a0, 0($t0) #se imprime v +t*i
syscall
li $v0, 4
la $a0, salto
syscall #se imprime un salto de linea
addi $s0, $s0, 1 # i++
mul $t1, $s0, 4 # $t1 = t*i
addu $t0, $s2, $t1 # $t0 = v+t*i
b while # se vuelve al while
end_while: li $v0, 17
li $a0, 0
syscall #se termina el programa
