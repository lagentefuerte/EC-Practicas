.data
	.eqv N 16
vector: .word 1, -3, 55, 8905, -111, 90,543,-4321,0,43,99,-34,-55,4321,45,-4532543
maximo: .space 4
minimo: .space 4
salto: .asciiz "\n"

.text 
	lw $t0, vector #se carga v[0]
	sw $t0, maximo #maximo = v[0]
	sw $t0, minimo #minimo = v[0]
	la $t0, vector #ahora se carga la direccion de v
	li $s0, 1 #variable i
	
for: 	bge $s0, N, end_for #se salta si i >= N
	mul $t1, $s0, 4 #$t1 = i*4
	addu $t1, $t1, $t0 #$t1 = v + i*4
	lw $t2, 0($t1) #aux = vector[i]
	lw $t3, minimo #se cargan minimo y maximo en registros para poder operar
	lw $t4, maximo 
	blt $t2, $t3, if # if vector[i] < minimo
	bgt $t2, $t4, else_if # else if vector[i] > maximo
	b end #si no se cumple ninguna condicion, salta al final
	
if: 	sw $t2, minimo #minimo = vector[i]
	b end #se salta al final 
	
else_if: sw $t2, maximo #maximo = vector[i]

end: 	addiu $s0, $s0, 1 #i++
	b for #salto al principio del bucle
	
end_for: li $v0, 1
	lw $a0, minimo
	syscall #se imprime el minimo
	
	li $v0, 4
	la $a0, salto
	syscall #se imprime un salto de linea

	li $v0, 1
	lw $a0, maximo
	syscall #se imprime el maximo
	
	li $v0, 17
	li $a0, 0
	syscall