	.data
array:	.word 1,2,3,4,5,6,7,8,9,10,11,0x004000b8 #$ra se guarda en 44($sp), el resto de valores son basura, 44($sp) es el ultimo hueco, por lo que el ultimo valor del array es donde queremos saltar
string1:.asciiz "Enhorabuena has realizado con exito un ataque de tipo stack overflow"
string2:.asciiz "El resultado de sumar el vector es: "
string3:.asciiz "\nEl valor de $s0 es: "
	.text
	
	la	$a0,array
	li	$a1,12 #necesitamos recorrer la pila 12 veces (reservamos 48/4 = 12 espacios para variables), y $ra se guarda en el ultimo hueco
	jal 	subrut
	
	li	$v0,4
	la	$a0,string3
	syscall
	
	li	$v0,1
	move	$a0,$s0
	syscall
	
	move 	$s1,$v0
	
	li	$v0,4
	la	$a0,string2
	syscall
	
	li	$v0,1
	move	$a0,$s1
	syscall
	
	li	$v0,10
	syscall
	
##################################
# Subrutina suma los elementos de un vector
# Paramentros: $a0 vector, $a1 numero de elementos (maximo 10)
# salida suma de los elementos del vector.
#################################
subrut:
	addi 	$sp,$sp,-48
	sw	$s0,40($sp)
	sw	$ra,44($sp) #aqui se guarda $ra, la direccion que queremos sobreescribir

	move	$t0,$sp
	li	$t1,0
copy:	beq	$t1,$a1,fin_copy
	lw	$t2,0($a0)
	sw	$t2,0($t0) #en la ultima iteracion del bucle se sobreescribe $ra por array[11], direccion a la que queremos saltar
	addi	$a0,$a0,4
	addi	$t0,$t0,4
	addi	$t1,$t1,1
	j	copy
fin_copy:

	move	$t0,$sp
	li 	$t1,0
	li	$s0,0
sum:
	beq	$t1,$a1,fin_sum
	lw	$t2,0($t0)
	add	$s0,$s0,$t2
	addi	$t1,$t1,1
	addi	$t0,$t0,4
	j	sum
fin_sum:
	
	move	$v0,$s0
	lw	$s0,40($sp)
	lw	$ra,44($sp)
	jr	$ra #se salta al valor sobreescrito de $ra
# Fin subrut
	
overflow:
	li $v0,4
	la $a0,string1
	syscall	
