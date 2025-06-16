	.data
# Matriz de 8x8 elementos de tama�o palabra
m1:	.space		256			# Reserva

# Matriz de 3x4 elementos de tama�o palabra con valor inicial
m2:	.word		3,-1,0xC4301234,32	# Fila 1
	.word		0,3451,90831,-333	# Fila 2
	.word		-23,99,4,55		# Fila 3

	.text

#    suma := 0;
	move	$s0,$zero
	#i=0
	move	$s3,$zero

	li $s1,4

#     Cargar indice tope en $t1 (3*4*4, 12 elementos * 4 bytes)
	mul	$t1,$s1,3
	mul	$t1,$t1,$s1 

	la	$t0,m2 #puntero al principio de la matriz
	addu 	$t1, $t1, $t0 #el registro $t1 guarda el valor del desplazamiento del ultimo elemento (m2 +48)
	 
while:
	b cond #se salta a la condicion

body:
	lw	$s4,0($t0)
	add	$s0,$s0,$s4 #se suma el valor
	addi	$t0,$t0,4 # se pasa al siguiente elemento el puntero
cond: 
	bne 	$t1,$t0,body #se comprueba si se ha llegado al final
	
	li	$v0,1
	move	$a0,$s0
	syscall
	li	$v0,10
	syscall
