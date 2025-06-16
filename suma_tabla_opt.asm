	.data
# Definici�n del tipo estructurado en PASCAL
#   TYPE TipoEmpleado = RECORD
#			   Nombre: ARRAY [0..31] OF CHAR;	/* 32 octetos */
#			   DNI: INTEGER;			/* 4 octetos */
#			   Letra: CHAR;				/* 1 octeto */
#			   Departamento: CHAR;			/* 1 octeto */
# {Hay que dejar un hueco de 2 octetos para alinear el siguiente campo }
#			   Sueldo: INTEGER;			/* 4 octetos */
#		        END;					/* TOTAL: 44 octetos */
# VAR tabla: ARRAY [0..99] OF TipoEmpleado;

# Definici�n en ensamblador
# Definici�n de la tabla: reserva del espacio necesario
tabla1:		.space	4400 

# Definici�n de una tabla rellena
# Alineamos cada elemento a posici�n m�ltiplo de 4,
# ya que hay campos con restricci�n de alineamiento
tabla2:
# tabla2[0]
		.align	2
		.asciiz	"Pepito P�rez"	# Nombre
		.space	19		  # Hueco para rellenar el nombre hasta 32 bytes
		.word	12345678	# DNI
		.byte	'Z'		# Letra del DNI
		.byte	'1'		# C�digo del departamento
		.align	2		  # Alineamiento a posici�n m�ltiplo de 4
		.word	1200		# Sueldo mensual
# tabla2[1]
		.asciiz	"Antonia Mu�oz"	# Nombre
		.space	18		  # Hueco para rellenar el nombre hasta 32 bytes
		.word	11111111	# DNI
		.byte	'H'		# Letra del DNI
		.byte	'2'		# C�digo del departamento
		.align	2		  # Alineamiento a posici�n m�ltiplo de 4
		.word	1500		# Sueldo mensual
# tabla2[2]
		.asciiz	"Juan Vald�s"	# Nombre
		.space	20		  # Hueco para rellenar el nombre hasta 32 bytes
		.word	22222222	# DNI
		.byte	'J'		# Letra del DNI
		.byte	'1'		# C�digo del departamento
		.align	2		  # Alineamiento a posici�n m�ltiplo de 4
		.word	1300		# Sueldo mensual
# tabla2[3]
		.asciiz	"Tom�s Mart�n"	# Nombre
		.space	19		  # Hueco para rellenar el nombre hasta 32 bytes
		.word	33333333	# DNI
		.byte	'P'		# Letra del DNI
		.byte	'2'		# C�digo del departamento
		.align	2		  # Alineamiento a posici�n m�ltiplo de 4
		.word	1000		# Sueldo mensual
# tabla2[4]
		.asciiz	"Mar�a S�nchez"	# Nombre
		.space	18		  # Hueco para rellenar el nombre hasta 32 bytes
		.word	44444444	# DNI
		.byte	'A'		# Letra del DNI
		.byte	'1'		# C�digo del departamento
		.align	2		  # Alineamiento a posici�n m�ltiplo de 4
		.word	1700		# Sueldo mensual
# Tira de caracteres auxiliar
eoln:		.byte	'\n'

		.text
##############################################################################
#                                                                            #
# ACCESO A UN ELEMENTO DE UNA TABLA CON �NDICE CONSTANTE CONOCIDO            #
#                                                                            #
##############################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
# VAR tabla2: ARRAY [0..4] OF TipoEmpleado;
#    s: INTEGER;
# BEGIN
#    s := tabla2[3].sueldo;
# END.
#
##########################################
# s: mantenemos una copia en el registro $s0, no lo vamos a almacenar en memoria
# temporales: $t0
##########################################
# Poner un puntero al inicio de la tabla
	la	$t0,tabla2
# Distancia del elemento al inicio de la tabla:
#     �ndice (3) * tama�o de un empleado (44) + desplazamiento del sueldo (40) = 172
# Se accede al elemento con direccionamiento indirecto al puntero $t0
# con la distancia al comienzo de la tabla como desplazamiento
	lw	$s0,172($t0)

##############################################################################
#                                                                            #
# ACCESO A UN ELEMENTO DE UNA TABLA CON �NDICE GEN�RICO DESCONOCIDO          #
#                                                                            #
##############################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
# VAR tabla2: ARRAY [0..4] OF TipoEmpleado;
#    s, i: INTEGER;
# BEGIN
#    s := tabla2[i].sueldo;
# END.
#
##########################################
# elem: mantenemos una copia en el registro $s0, no lo vamos a almacenar en memoria
# i:	registro $s1
# temporales: $t0 y $t1
##########################################
# Ponemos un valor a i, se puede cambiar
	li	$s1,4
# Poner un puntero al inicio de la tabla
	la	$t0,tabla2
# Distancia del elemento al inicio de la tabla: hay que calcularla
#     �ndice (i) * tama�o de un empleado (44) + desplazamiento del sueldo (40) = 172
# Se accede al elemento con direccionamiento indirecto al puntero $t0
# con la distancia al comienzo de la tabla como desplazamiento
# Desplazamiento: i * tama�o del empleado
	mul	$t1,$s1,44
# Direcci�n base del elemento: $t0+$t1
	addu	$t1,$t0,$t1
# Acceso al campo sueldo
	lw	$s0,40($t1)

##############################################################################
#                                                                            #
# SUMA DE UNO DE LOS CAMPOS DE LA TABLA                                      #
#                                                                            #
##############################################################################
#
# C�DIGO EN PASCAL
#
##########################################
#
# VAR tabla2: ARRAY [0..4] OF TipoEmpleado;
#    s, i: INTEGER;
# BEGIN
#    suma := 0;
#    FOR i:= 0 TO 4 DO
#       suma := suma + tabla2[i].sueldo;
# END.
#
##########################################
# suma: registro $s0
# i:    registro $t0
# temporales: $t0 ... $t5
##########################################
#    suma := 0;
	move	$s0,$zero
#    FOR i:= 0 TO 4 DO
for:
#     Cargar �ndice inicial en $t0
	la	$t0, tabla2
#     Cargar �ndice tope en $t1 (tabla2 + 5*44)
	li	$t1,44
	mul 	$t1, $t1, 5
	add 	$t1, $t1, $t0
#     Ir a la condicion
	b	cond
#     Cuerpo del bucle
body:
#       suma := suma + tabla2[i].sueldo;
#       Leer sueldo del elemento i-�simo
	lw	$t5,40($t0)
#       Acumular suma sobre $s0
	addu	$s0,$s0,$t5
#	Realizar incremento del puntero
inc:	addiu	$t0,$t0,44
#       Si el �ndice iguala el valor tope, salir
cond:	bne	$t0,$t1,body
end:

# Fin del programa
	li	$v0,10
	syscall
