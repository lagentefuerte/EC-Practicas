	.data
# Almacena como m�ximo 16 caracteres, contenido inicial indefinido
# Cuidado, habr�a que poner un nulo en el primer car�cter
T1:	.space	16
# Almacena como m�ximo 12 caracteres, tira vac�a (comienza por nulo)
T2:	.byte	0
	.space	15
# Dos definiciones equivalentes
#    Poniendo expl�citamente el nulo al final con la directiva .byte
T3:	.ascii	"Hola"
	.byte	0
#    Con .asciiz, que ya genera el nulo final directamente
T4:	.asciiz	"Hola"

# Tira de 12 caracteres con cuatro ocupados m�s el car�cter nulo
T5:	.asciiz	"Hola"	# Contenido �legible� de la tira
	.space	7	# Hueco de relleno al tama�o m�ximo

# Elemento
elem:	.space	1

# Longitud de la tira
	.align	2
lon:	.space	4

	.text
##################################################################################
#                                                                                #
# ACCESO A UN ELEMENTO DE UNA TIRA DE CARACTERES CON �NDICE CONSTANTE CONOCIDO   #
#                                                                                #
##################################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
#   elem := T3[1];
#
##########################################
# elem: mantenemos una copia en el registro $s0, y luego lo copiamos en memoria
##########################################
# Poner un puntero al inicio de la tira
	la	$t0,T3
# Distancia del elemento al inicio del vector: 1
# Se accede al elemento con direccionamiento indirecto al puntero $t0
# con la distancia al comienzo de la tira como desplazamiento
	lbu	$s0,1($t0)
	sb	$s0,elem


##################################################################################
#                                                                                #
# ACCESO A UN ELEMENTO DE UNA TIRA DE CARACTERES CON �NDICE GEN�RICO DESCONOCIDO #
#                                                                                #
##################################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
#    elem := T4[i];
#
##########################################
# elem: mantenemos una copia en el registro $s0, y luego lo copiamos en memoria
# i:	registro $s1
# temporales: $t0 y $t1
##########################################
# Ponemos un valor a i, se puede cambiar
	li	$s1,2
# Poner un puntero al inicio del vector
	la	$t0,T4

# Sumando la distancia al puntero tenemos un puntero al elemento buscado
	addu	$t1,$t0,$s1
	lbu	$s0,0($t1)
	sb	$s0,elem

##################################################################################
#                                                                                #
# C�LCULO DE LA LONGITUD DE UNA TIRA DE CARACTERES                               #
#                                                                                #
##################################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
# VAR T5: ARRAY [0..11] OF CHAR;
#    lon: INTEGER;
# BEGIN
#   lon := 0;
#   WHILE t[lon] <> CHR(0) DO
#      lon := lon+1;
# END.
#
##########################################
# lon: mantenemos una copia en el registro $s0, y luego lo copiamos en memoria
# temporales: $t0, $t1
##########################################
#    lon := 0;
	move	$s0,$zero
#    WHILE t[lon] <> CHR(0) DO

#       Poner puntero al comienzo del vector
	la	$t0,T5 # es incorrecto coger el valor del comienzo del vector en cada iteracion, con tenerla al principio ya se puede usar
#	Cargar primer caracter
	lbu	$t1,0($t0)
	
while:
# 	Saltar a la condicion
 b	cond 
body: 
#      	Cuerpo del bucle
#       lon := lon+1;
	addiu	$s0,$s0,1
# 	se avanza el puntero
	addiu	$t0,$t0,1 
#        Leer elemento i-esimo
	lbu	$t1,0($t0)

cond:
#	Si el final es el caracter nulo, se sale
	bnez	$t1,body #siempre se comprueba que sea el registro 0 (caracter nulo), por lo ques mejor utilizar bnez
	
fin:
	sw	$s0,lon #es menos eficiente pero debemos usar esta instruccion si queremos guardarlo en memoria


# Fin del programa
	li	$v0,10
	syscall
