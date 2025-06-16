		.data
# Variables de memoria
string:		.space	21
# Tiras para mostrar por pantalla
MSG_STRING:	.asciiz "Introduzca la cadena donde buscar\n"
MSG_CHAR:	.asciiz	"Introduzca el caracter a buscar\n"
MSG_RESULT:	.asciiz "\nNº de apariciones del caracter: "

# Mensajes de error por mala gestion de la pila
ERR_S0:		.asciiz	"\nERROR: El valor de $S0 ha sido modificado"
ERR_S1:		.asciiz	"\nERROR: El valor de $S1 ha sido modificado"	
ERR_S2:		.asciiz	"\nERROR: El valor de $S2 ha sido modificado"	
ERR_S3:		.asciiz	"\nERROR: El valor de $S3 ha sido modificado"	
ERR_S4:		.asciiz	"\nERROR: El valor de $S4 ha sido modificado"	
ERR_S5:		.asciiz	"\nERROR: El valor de $S5 ha sido modificado"
ERR_S6:		.asciiz	"\nERROR: El valor de $S6 ha sido modificado"	
ERR_S7:		.asciiz	"\nERROR: El valor de $S7 ha sido modificado"		
		.text
# Programa principal
	## Cargar valores en $Sx para comprobarlos despues
	li	$s0,0xF0000000
	li	$s1,0xF0000000
	li	$s2,0xF0000000
	li	$s3,0xF0000000
	li	$s4,0xF0000000
	li	$s5,0xF0000000
	li	$s6,0xF0000000
	li	$s7,0xF0000000
	## Fin de carga de valores
	
	
	li	$v0,4
	la	$a0,MSG_STRING
	syscall
	
	li	$v0,8
	la	$a0,string
	li	$a1,21
	syscall
	
	li	$v0,4
	la	$a0,MSG_CHAR
	syscall
	
	li	$v0,12
	syscall
	
	
	move 	$a1,$v0
	la	$a0,string
	addiu	$sp, $sp, -16 #hueco de cortesia para guardar argumentos
	jal 	count #llamamos a subrutina
	addiu	$sp, $sp, 16 #dejamos la pila como estaba
	move	$t0,$v0
	
	li	$v0,4
	la	$a0,MSG_RESULT
	syscall
	li	$v0,1
	move	$a0,$t0
	syscall
	
	## Comprobar registros seguros ##
	beq	$s0, 0xF0000000,s1
	li	$v0,4
	la	$a0,ERR_S0
	syscall
s1:
	beq	$s1, 0xF0000000,s2
	li	$v0,4
	la	$a0,ERR_S1
	syscall
s2:
	beq	$s2, 0xF0000000,s3
	li	$v0,4
	la	$a0,ERR_S2
	syscall
s3:
	beq	$s3, 0xF0000000,s4
	li	$v0,4
	la	$a0,ERR_S3
	syscall
s4:
	beq	$s4, 0xF0000000,s5
	li	$v0,4
	la	$a0,ERR_S4
	syscall
s5:
	beq	$s5, 0xF0000000,s6
	li	$v0,4
	la	$a0,ERR_S5
	syscall
s6:
	beq	$s6, 0xF0000000,s7
	li	$v0,4
	la	$a0,ERR_S6
	syscall
s7:
	beq	$s3, 0xF0000000,main_end
	li	$v0,4
	la	$a0,ERR_S7
	syscall
main_end:

	##  FIN Comprobar registros seguros ##
	
	li $v0,10
	syscall

##################################
# Subrutina cuenta el numero de aparaciones de un caracter
# Paramentros: $a0 cadena, $a1 caracter
# salida numero de apariciones
#################################
count:
	addiu $sp, $sp, -20 #20 bytes para pila, $ra, $fp, y 3 variables locales ($t0, $t1, $t2)
	sw $a1, 24($sp) #guardamos argumentos en hueco de cortesia que nos ha dejado el programa anterior
	sw $a0, 20($sp)
	move $fp, $sp #asigamos el frame pointer aunque en este caso no lo vamos a usar
	sw $ra, 16($sp) #salvaguardamos $ra (para poder volver al programa principal) y $fp
	sw $fp, 12($sp)
	li $t0, 0 #variable local que cuenta numero de apariciones
	move $t1, $a0 #cargamos la cadena en $t1
	lb $t2, 0($t1) #cargamos el caracter actual en $t2
	b cond #bucle for para recorrer la cadena
body:	lb $t2, 0($t1) #cargamos el caracter actual
	sw $t0, 8($sp) #salvaguardamos nuestras variables locales antes de llamar a la subrutina hoja
	sw $t1, 4($sp)
	sw $t2, 0($sp)
	move $a0, $t2 #cargamos el caracter actual como argumento en $a0
	jal compare #saltamos
	lw $t0, 8($sp) #recuperamos el valor de nuestras variables locales
	lw $t1, 4($sp)
	lw $t2, 0($sp)
	lw $a1, 24($sp) #como la subrutina sobreescribe el valor de $a1, lo volvemos a cargar desde la pila
if:	beqz $v0, endif #en $v0 tenemos el boolean que nos dice si es igual o no, si no es igual saltamos al incremento del while
	addi $t0, $t0, 1 #si no es cero, se suma uno a las apariciones del caracter
endif:	addiu $t1, $t1, 1 #se adelanta el puntero en un byte para apuntar al siguiente caracter
cond:	bne $t2, $zero, body #paramos cuando el caracter sea el caracter nulo, el cero
end:	move $v0, $t0 #cargamos en $v0 el valor de retorno de nuestra subrutina, el numero de apariciones
	lw $ra, 16($sp) #restauramos $ra
	addu $sp, $sp, 20 #dejamos el marco de pila como estaba
	jr $ra #volvemos al programa principal
	
#####################################
# Subrituna comparar caracteres
# Paramentros $a0 y $a1
# Salida booleano indicando True si son iguales
#####################################
compare:
	seq	$v0,$a0,$a1
	## Modificar registros no seguros ##
	
	li	$v1,0xF0000000
	li	$a0,0xF0000000
	li	$a1,0xF0000000
	li	$a2,0xF0000000
	li	$a3,0xF0000000
	li	$t0,0xF0000000
	li	$t1,0xF0000000
	li	$t2,0xF0000000
	li	$t3,0xF0000000
	li	$t4,0xF0000000
	li	$t5,0xF0000000
	li	$t6,0xF0000000
	li	$t7,0xF0000000
	li	$t8,0xF0000000
	li	$t9,0xF0000000
	
	jr	$ra
