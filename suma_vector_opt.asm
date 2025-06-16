	.data
# Vector de 16 elementos de tamaño palabra sin valor inicial determinado
v1:	.space	64		# Reserva
# Vector de 16 datos de 32 bits en complemento a 2 con valor inicial
v2:	.word	10,3300,-2342,90,0,3333333,-27688,0xB2001234,4,-21,-5,22,665,772,-45,3333

	.text
##############################################################################
#                                                                            #
# ACCESO A UN ELEMENTO DE UN VECTOR CON ÍNDICE CONSTANTE CONOCIDO            #
#                                                                            #
##############################################################################
#
# CÓDIGO EN PASCAL
#
##########################################
#
# VAR v2: ARRAY [0..15] OF INTEGER;
#    elem: INTEGER;
# BEGIN
#    elem := v2[5];
# END.
#
##########################################
# Tamaño de un entero: 4
# elem: mantenemos una copia en el registro $s0, no lo vamos a almacenar en memoria
# temporales: $t0
##########################################
# Poner un puntero al inicio del vector
	la	$t0,v2
# Distancia del elemento al inicio del vector:
#    5*tamaño de un entero = 20
# Se accede al elemento con direccionamiento indirecto al puntero $t0
# con la distancia al comienzo del vector como desplazamiento
	lw	$s0,20($t0)


##############################################################################
#                                                                            #
# ACCESO A UN ELEMENTO DE UN VECTOR CON ÍNDICE GENÉRICO DESCONOCIDO          #
#                                                                            #
##############################################################################
#
# CÓDIGO EN PASCAL
#
##########################################
#
# VAR v2: ARRAY [0..15] OF INTEGER;
#     elem: INTEGER;
#     i: INTEGER;
# BEGIN
#    elem := v2[i];
# END.
#
##########################################
# Tamaño de un entero: 4
# elem: mantenemos una copia en el registro $s0, no lo vamos a almacenar en memoria
# i:	registro $s1
# temporales: $t0 y $t1
##########################################
# Ponemos un valor a i, se puede cambiar
	li	$s1,7
# Poner un puntero al inicio del vector
	la	$t0,v2
# Distancia del elemento al inicio del vector: i * 4: hay que calcularla
	mul	$t1,$s1,4
# Sumando la distancia al puntero tenemos un puntero al elemento buscado
	addu	$t1,$t0,$t1
	lw	$s0,0($t1)


##############################################################################
#                                                                            #
# SUMA DE LOS ELEMENTOS DE UN VECTOR                                         #
#                                                                            #
##############################################################################
#
# CÓDIGO EN PASCAL
#
##########################################
#
# VAR v: ARRAY [0..15] OF INTEGER;
#     suma: INTEGER;
#     i: INTEGER;
# BEGIN
#    suma := 0;
#    FOR i:= 0 TO 9 DO
#       suma := suma+v[i];
# END.
#
##########################################
# Tamaño de un entero: 4
# suma: registro $s0
# i:    registro $t0
# temporales: $t0 ... $t5
##########################################
#    suma := 0;
	move	$s0,$zero
#    FOR i:= 0 TO 9 DO
for:
#     Cargar direccion de v2 en $t0
	la $t0, v2
#     Cargar final del vector (tope) en $t1 (vector + 16*4)
	li $t1, 16
	sll $t1, $t1, 2
	add $t1,$t1, $t0
#     Ir a la condicion del bucle
	b	cond
#     Cuerpo del bucle
body:
#       suma := suma+*(v+i);
#       Leer elemento i-ésimo
	lw	$t5,0($t0)
#       Acumular suma sobre $s0
	addu	$s0,$s0,$t5
#	Realizar incremento del puntero
inc:	addiu	$t0,$t0,4
#       Si el índice iguala el valor tope, salir
cond:	bne	$t0,$t1,body
end:


# Fin del programa
	li	$v0,10
	syscall
