# Arboles-tipo-de-datos-
Genera expresiones matemáticas aleatorias representadas como árboles.


# Generación y Evaluación de Expresiones Matemáticas Aleatorias con Árboles en Dart

Este repositorio contiene código en Dart para generar y evaluar expresiones matemáticas aleatorias utilizando estructuras de datos de árbol. Se implementan diferentes tipos de nodos para representar operadores, constantes y variables, lo que permite la creación de fórmulas complejas que pueden ser evaluadas.

## Descripción General

El proyecto se enfoca en la creación de un sistema flexible para la manipulación de expresiones matemáticas. Se utilizan árboles binarios para representar las expresiones, donde los nodos internos contienen operadores (+, -, \*, /, sin, sqrt) y los nodos hoja contienen constantes numéricas o variables (x0, x1, x2, ...).

La generación de los árboles se realiza de forma aleatoria, permitiendo controlar la profundidad máxima del árbol y el número de variables a utilizar. Se ofrecen dos métodos de generación:

*   **Profundidad Completa:** Se crean árboles donde todos los caminos desde la raíz hasta las hojas tienen la misma longitud (la profundidad máxima especificada).
*   **Profundidad Aleatoria:** Se generan árboles donde la profundidad de los caminos puede variar, hasta un máximo especificado.

Una vez creado el árbol, se puede obtener la representación en cadena de la expresión matemática (ej: "(x0 + 5) \* sin(x1)") y se puede evaluar la expresión, proporcionando valores para las variables.

## Estructura del Código

El código se estructura en las siguientes clases principales:

*   **`Nodo` (abstracta):** Define la interfaz común para todos los nodos del árbol.
*   **`Nodo_interno`:** Representa nodos con operadores.
*   **`Nodo_hoja_cst`:** Representa nodos con constantes numéricas.
*   **`Nodo_hoja_var`:** Representa nodos con variables.
*   **`Nodo_creador` (abstracta):** Define la interfaz para los creadores de nodos.
*   **`fullDepthNodeCreator`:** Crea árboles de profundidad completa.
*   **`randomDepthNodeCreator`:** Crea árboles de profundidad aleatoria.
*   **`Arbol`:** Representa el árbol de expresión matemática y contiene los métodos para crearlo, clonarlo y evaluarlo.

## Ejemplos de Uso

### Ejemplo 1: Árbol de Profundidad Completa

**Código Dart:**

```dart
Arbol a1 = Arbol.create(3, 2); // Profundidad 3, 2 variables (x0, x1)
a1.arbol_random(); // Genera el árbol aleatorio

print("Expresión generada:");
print(a1.valor);

List<double> valores = [5.0, 2.0]; // Valores para x0 y x1
double resultado = a1.eval(valores);

print("Resultado de la evaluación:");
print(resultado)
``` 

**Salida (Consola):**
```
Expresión generada: ((x0 * 3.142) + (sqrt(x1) / 0.707)) 
Resultado de la evaluación: 16.425
```


### Ejemplo 2: Árbol de Profundidad Aleatoria

**Código Dart:**

```dart
Arbol a2 = Arbol.create(4, 3); // Profundidad máxima 4, 3 variables (x0, x1, x2)
a2.arbol_randomDepth(); // Genera el árbol aleatorio

print("Expresión generada:");
print(a2.valor);

List<double> valores2 = [1.0, 4.0, 9.0]; // Valores para x0, x1 y x2
double resultado2 = a2.eval(valores2);

print("Resultado de la evaluación:");
print(resultado2);
```

**Salida (Consola):**

```
Expresión generada:
(sin(x0) * (x1 - sqrt(x2)))

Resultado de la evaluación:
-2.836
```
