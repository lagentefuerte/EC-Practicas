# 🧠 Estructura de Computadores – Prácticas en Ensamblador (MIPS)

Este repositorio contiene una colección de ejercicios desarrollados en lenguaje ensamblador MIPS como parte de la asignatura **Estructura de Computadores**. Aunque no se conservan los enunciados originales, el código cubre operaciones fundamentales y avanzadas del uso de ensamblador en MIPS, incluyendo estructuras de control, aritmética, trabajo con vectores/matrices, y un ejemplo de vulnerabilidad tipo **buffer overflow**.

## 🔍 Descripción de Archivos Principales

| Archivo                    | Descripción |
|---------------------------|-------------|
| `boolean.asm`             | Implementa operaciones booleanas simples. |
| `contador.asm`            | Realiza un conteo ascendente o descendente. |
| `Desbordamiento.asm`      | Simula una vulnerabilidad de **desbordamiento de búfer** (buffer overflow). |
| `division.asm`            | Realiza divisiones enteras, posiblemente con manejo de excepciones. |
| `interpolacion_lineal.asm`| Cálculo de interpolación lineal a partir de dos puntos. |
| `mipsBucle.asm`           | Implementación de bucles simples. |
| `prueba_for.asm`          | Simulación del comportamiento de un bucle `for`. |
| `str_len_opt.asm`         | Optimización del cálculo de longitud de cadena. |
| `suma.asm`                | Suma de dos números simples. |
| `suma_matriz_opt.asm`     | Suma optimizada en matrices. |
| `suma_tabla_opt.asm`      | Suma de datos organizados en tablas. |
| `suma_vector_opt.asm`     | Cálculo eficiente de la suma de vectores. |
| `vector_int_minmax.asm`   | Búsqueda de valor mínimo y máximo en un vector. |

## 🧪 Buffer Overflow – Análisis Visual

En la carpeta `Desbordamiento/` se incluyen dos imágenes que ayudan a visualizar el funcionamiento del ataque de desbordamiento de pila:

- `pila_ataque.png`: muestra el estado de la pila tras la inyección de datos maliciosos.
- `pila_partida.png`: muestra cómo se sobrescriben direcciones de retorno o datos críticos.

Estas imágenes están asociadas al código en `Desbordamiento.asm`.

## ⚙️ Requisitos

- Simulador **MARS** o **QtSPIM** para ejecutar los programas MIPS.
- Recomendado: Linux con soporte para SPIM/MIPS si deseas compilar en entorno real (educativo).

## 🧠 Notas

Este código ha sido desarrollado de forma individual como parte del proceso de aprendizaje, y puede servir como referencia o punto de partida para otros estudiantes que estén trabajando con arquitectura MIPS o similares.

