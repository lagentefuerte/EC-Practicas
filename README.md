# 🧠 Computer Architecture – MIPS Assembly Practice

This repository contains a collection of exercises written in MIPS assembly language, developed as part of the **Computer Architecture** course. Although the original problem statements are not available, the code covers both fundamental and advanced operations using MIPS assembly, including control structures, arithmetic, vector/matrix operations, and an example of a **buffer overflow** vulnerability.



## 🔍 Description of Main Files

| File                       | Description |
|---------------------------|-------------|
| `boolean.asm`             | Implements basic boolean operations. |
| `contador.asm`            | Performs a counting loop (increment/decrement). |
| `Desbordamiento.asm`      | Demonstrates a **buffer overflow** vulnerability. |
| `division.asm`            | Integer division, possibly with exception handling. |
| `interpolacion_lineal.asm`| Performs linear interpolation from two points. |
| `mipsBucle.asm`           | Simple loop implementation. |
| `prueba_for.asm`          | Simulates the logic of a `for` loop. |
| `str_len_opt.asm`         | Optimized string length algorithm. |
| `suma.asm`                | Basic addition of two integers. |
| `suma_matriz_opt.asm`     | Optimized matrix summation. |
| `suma_tabla_opt.asm`      | Summation of structured table data. |
| `suma_vector_opt.asm`     | Efficient summation of a vector. |
| `vector_int_minmax.asm`   | Finds minimum and maximum values in a vector. |

## 🧪 Buffer Overflow – Visual Analysis

The `Desbordamiento/` folder includes two images that help visualize how the stack behaves during a buffer overflow:

- `pila_ataque.png`: shows the stack after malicious data injection.
- `pila_partida.png`: illustrates how return addresses or critical data are overwritten.

These images relate to the code in `Desbordamiento.asm`.

## ⚙️ Requirements

- **MARS** or **QtSPIM** simulator to run the MIPS programs.
- Optional: Linux environment with SPIM/MIPS support for native (educational) compilation.

## 🧠 Notes

This code was developed individually as part of the learning process. It may serve as a reference or starting point for other students working on MIPS architecture or similar assembly languages.



