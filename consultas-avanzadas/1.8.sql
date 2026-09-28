-- 1.8.1 Procedimientos sin sentencias SQL

/*-|1|- 
Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que 
muestre el texto ¡Hola mundo!.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS hello_world $$
CREATE PROCEDURE hello_world()
    BEGIN
        SELECT '¡Hola mundo!';
    END $$
DELIMITER ;
CALL hello_world();

/*-|2|- 
Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje 
indicando si el número es positivo, negativo o cero.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS signo_numero $$
CREATE PROCEDURE signo_numero(IN numero INT)
    CASE
        WHEN numero > 0 THEN SELECT 'El número es positivo';
        WHEN numero < 0 THEN SELECT 'El número es negativo';
        ELSE SELECT 'El número es cero';
    END CASE $$
DELIMITER ;
CALL signo_numero(0);

/*-|3|- 
Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro 
de entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres 
indicando si el número es positivo, negativo o cero.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS signoNumero $$
CREATE PROCEDURE signoNumero(IN numero INT, OUT salida VARCHAR(25))
    CASE
        WHEN numero > 0 THEN SET salida = 'El número es positivo';
        WHEN numero < 0 THEN SET salida = 'El número es negativo';
        ELSE SET salida = 'El número es cero';
    END CASE $$
DELIMITER ;
CALL signoNumero(-1, @resultado);
SELECT @resultado;

/*-|4|- 
Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la 
nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las 
siguientes condiciones: 
- [0,5) = Insuficiente
- [5,6) = Aprobado
- [6, 7) = Bien
- [7, 9) = Notable
- [9, 10] = Sobresaliente
- En cualquier otro caso la nota no será válida.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calificacionAlumno $$
CREATE PROCEDURE calificacionAlumno(IN numero REAL)
    CASE
        WHEN numero >= 0 AND numero < 5 THEN SELECT 'Insuficiente';
        WHEN numero >= 5 AND numero < 6 THEN SELECT 'Aprobado';
        WHEN numero >= 6 AND numero < 7 THEN SELECT 'Bien';
        WHEN numero >= 7 AND numero < 9 THEN SELECT 'Notable';
        WHEN numero >= 9 AND numero <= 10 THEN SELECT 'Sobresaliente';
        ELSE SELECT 'Nota no válida';
    END CASE $$
DELIMITER ;
CALL calificacionAlumno(5);

/*-|5|- 
Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro 
de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una 
cadena de texto indicando la nota correspondiente.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calificacionAlumno $$
CREATE PROCEDURE calificacionAlumno(IN numero REAL, OUT calificacion VARCHAR(20))
    IF numero >= 0 AND numero < 5 THEN SET calificacion = 'Insuficiente';
        ELSE IF numero >= 5 AND numero < 6 THEN SET calificacion = 'Aprobado';
            ELSE IF numero >= 6 AND numero < 7 THEN SET calificacion = 'Bien';
                ELSE IF numero >= 7 AND numero < 9 THEN SET calificacion = 'Notable';
                    ELSE IF numero >= 9 AND numero <= 10 THEN SET calificacion = 'Sobresaliente';
                        ELSE SET calificacion = 'Nota no válida';
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF $$
DELIMITER ;
CALL calificacionAlumno(4, @resultado);
SELECT @resultado;

/*-|6|- 
Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura 
de control CASE.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calificacionAlumno $$
CREATE PROCEDURE calificacionAlumno(IN numero REAL, OUT calificacion VARCHAR(20))
    CASE
        WHEN numero >= 0 AND numero < 5 THEN SET calificacion = 'Insuficiente';
        WHEN numero >= 5 AND numero < 6 THEN SET calificacion = 'Aprobado';
        WHEN numero >= 6 AND numero < 7 THEN SET calificacion = 'Bien';
        WHEN numero >= 7 AND numero < 9 THEN SET calificacion = 'Notable';
        WHEN numero >= 9 AND numero <= 10 THEN SET calificacion = 'Sobresaliente';
        ELSE SET calificacion =  'Nota no válida';
    END CASE $$
DELIMITER ;
CALL calificacionAlumno(4, @resultado);
SELECT @resultado;

/*-|7|- 
Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente 
un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana 
correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS diaSemana $$
CREATE PROCEDURE diaSemana(IN numero INT, OUT dia VARCHAR(20))
    CASE
        WHEN numero = 1 THEN SET dia = 'Lunes';
        WHEN numero = 2 THEN SET dia = 'Martes';
        WHEN numero = 3 THEN SET dia = 'Miércoles';
        WHEN numero = 4 THEN SET dia = 'Jueves';
        WHEN numero = 5 THEN SET dia = 'Viernes';
        WHEN numero = 6 THEN SET dia = 'Sábado';
        WHEN numero = 7 THEN SET dia = 'Domingo';
        ELSE SET dia = 'Día no válido';
    END CASE $$
DELIMITER ;
CALL diaSemana(8, @resultado);
SELECT @resultado;

-- 1.8.2 Procedimientos con sentencias SQL

/*-|1|- 
Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice 
una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de 
ese país.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS clientesPais $$
CREATE PROCEDURE clientesPais(IN pais VARCHAR(50))
    BEGIN
        SELECT *
        FROM cliente c
        WHERE c.pais = pais;
    END $$
DELIMITER ;
CALL clientesPais('USA');


/*-|2|- 
Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una 
cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de 
máximo valor realizado para esa forma de pago.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS pagoMaximo $$
CREATE PROCEDURE pagoMaximo(IN formaPago VARCHAR(20))
    BEGIN
        SELECT MAX(p.total)
        FROM pago p
        WHERE p.forma_pago = formaPago;
    END $$
DELIMITER ;
CALL pagoMaximo('PayPal');

/*-|3|- 
Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una 
cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes 
valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
- el pago de máximo valor,
- el pago de mínimo valor,
- el valor medio de los pagos realizados,
- la suma de todos los pagos,
- el número de pagos realizados para esa forma de pago
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS datosPagos $$
CREATE PROCEDURE datosPagos(IN formaPago VARCHAR(20))
    BEGIN
        SELECT MAX(p.total), MIN(p.total), AVG(p.total), SUM(p.total), COUNT(p.total)
        FROM pago p
        WHERE p.forma_pago = formaPago;
    END $$
DELIMITER ;
CALL datosPagos('PayPal');


/*-|4|- 
Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla 
cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra columna 
llamada cuadrado.
*/

CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;
CREATE TABLE IF NOT EXISTS cuadrados (
    numero INT UNSIGNED,
    cuadrado INT UNSIGNED
);

# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados
# con las siguientes características. El procedimiento recibe un parámetro de entrada llamado tope de
# tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el
# valor introducido como parámetro. El valor del números y de sus cuadrados deberán ser almacenados
# en la tabla cuadrados que hemos creado previamente.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de
# insertar los nuevos valores de los cuadrados que va a calcular.

# Utilice un bucle WHILE para resolver el procedimiento.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE cuadrado INT UNSIGNED;
        DELETE FROM cuadrados;
        WHILE i <= tope DO
            SET cuadrado = i * i;
            INSERT INTO cuadrados VALUES (i, cuadrado);
            SET i = i + 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_cuadrados(10);

SELECT * FROM cuadrados;

/*-|5|- 
Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE cuadrado INT UNSIGNED;
        DELETE FROM cuadrados;
        REPEAT
            SET cuadrado = i * i;
            INSERT INTO cuadrados VALUES (i, cuadrado);
            SET i = i + 1;
        UNTIL i > tope END REPEAT;
    END $$
DELIMITER ;
CALL calcular_cuadrados(10);

SELECT * FROM cuadrados;

/*-|6|- 
Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE cuadrado INT UNSIGNED;
        DELETE FROM cuadrados;
        bucle: LOOP
            SET cuadrado = i * i;
            INSERT INTO cuadrados VALUES (i, cuadrado);
            SET i = i + 1;
            IF i > tope THEN
                LEAVE bucle;
            END IF;
        END LOOP;
    END $$
DELIMITER ;
CALL calcular_cuadrados(10);

SELECT * FROM cuadrados;

/*-|7|- 
Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. 
La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe 
ser INT UNSIGNED.
*/

CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;
CREATE TABLE IF NOT EXISTS ejercicio (
    numero INT UNSIGNED
);

# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números
# con las siguientes características. El procedimiento recibe un parámetro de entrada llamado
# valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda la secuencia
# de números desde el valor inicial pasado como entrada hasta el 1.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de
# insertar los nuevos valores.

# Utilice un bucle WHILE para resolver el procedimiento.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT valor_inicial;
        DELETE FROM ejercicio;
        WHILE i >= 1 DO
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_numeros(10);

SELECT * FROM ejercicio;

/*-|8|- 
Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT valor_inicial;
        DELETE FROM ejercicio;
        REPEAT
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;
        UNTIL i < 1 END REPEAT;
    END $$
DELIMITER ;
CALL calcular_numeros(10);

SELECT * FROM ejercicio;

/*-|9|- 
Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT valor_inicial;
        DELETE FROM ejercicio;
        bucle: LOOP
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;
            IF i < 1 THEN
                LEAVE bucle;
            END IF;
        END LOOP;
    END $$
DELIMITER ;
CALL calcular_numeros(10);

SELECT * FROM ejercicio;

/*-|10|- 
Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla 
llamada impares. Las dos tablas deben tener única columna llamada número y el tipo de dato de esta 
columna debe ser INT UNSIGNED.
*/

CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;

CREATE TABLE IF NOT EXISTS pares (
    numero INT UNSIGNED
);
CREATE TABLE IF NOT EXISTS impares (
    numero INT UNSIGNED
);

# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado
# calcular_pares_impares con las siguientes características. El procedimiento recibe un parámetro
# de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números
# pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la
# misma operación para almacenar los números impares en la tabla impares.

# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de
# insertar los nuevos valores.

# Utilice un bucle WHILE para resolver el procedimiento.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE par INT UNSIGNED;
        DECLARE impar INT UNSIGNED;
        DELETE FROM pares;
        DELETE FROM impares;
        WHILE i <= tope DO
            IF i % 2 = 0 THEN
                SET par = i;
                INSERT INTO pares VALUES (par);
            ELSE
                SET impar = i;
                INSERT INTO impares VALUES (impar);
            END IF;
            SET i = i + 1;
        END WHILE;
    END $$
DELIMITER ;
CALL calcular_pares_impares(10);

SELECT * FROM pares;
SELECT * FROM impares;

/*-|9|- 
Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE par INT UNSIGNED;
        DECLARE impar INT UNSIGNED;
        DELETE FROM pares;
        DELETE FROM impares;
        REPEAT
            IF i % 2 = 0 THEN
                SET par = i;
                INSERT INTO pares VALUES (par);
            ELSE
                SET impar = i;
                INSERT INTO impares VALUES (impar);
            END IF;
            SET i = i + 1;
        UNTIL i > tope END REPEAT;
    END $$
DELIMITER ;
CALL calcular_pares_impares(10);

SELECT * FROM pares;
SELECT * FROM impares;

/*-|10|- 
Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
    BEGIN
        DECLARE i INT UNSIGNED DEFAULT 1;
        DECLARE par INT UNSIGNED;
        DECLARE impar INT UNSIGNED;
        DELETE FROM pares;
        DELETE FROM impares;
        bucle: LOOP
            IF i % 2 = 0 THEN
                SET par = i;
                INSERT INTO pares VALUES (par);
            ELSE
                SET impar = i;
                INSERT INTO impares VALUES (impar);
            END IF;
            SET i = i + 1;
            IF i > tope THEN
                LEAVE bucle;
            END IF;
        END LOOP;
    END $$
DELIMITER ;
CALL calcular_pares_impares(10);

SELECT * FROM pares;
SELECT * FROM impares;

-- 1.8.3 Funciones sin sentencias SQL

/*-|1|- 
Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par 
o FALSE en caso contrario.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS es_par $$
CREATE FUNCTION es_par(numero INT UNSIGNED)
    RETURNS BOOLEAN
    BEGIN
        DECLARE resultado BOOLEAN;
        IF numero % 2 = 0 THEN
            SET resultado = TRUE;
        ELSE
            SET resultado = FALSE;
        END IF;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT es_par(11);

/*-|2|- 
Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores 
de sus lados.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS hipotenusa $$
CREATE FUNCTION hipotenusa(cateto1 DECIMAL(10, 2), cateto2 DECIMAL(10, 2))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        SET resultado = SQRT(POW(cateto1, 2) + POW(cateto2, 2));
        RETURN resultado;
    END $$
DELIMITER ;
SELECT hipotenusa(3.5, 5);

/*-|3|- 
Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día 
de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana 
correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS dia_semana $$
CREATE FUNCTION dia_semana(diaSemana INT UNSIGNED)
    RETURNS VARCHAR(10)
    BEGIN
        CASE
            WHEN diaSemana = 1 THEN RETURN 'Lunes';
            WHEN diaSemana = 2 THEN RETURN 'Martes';
            WHEN diaSemana = 3 THEN RETURN 'Miércoles';
            WHEN diaSemana = 4 THEN RETURN 'Jueves';
            WHEN diaSemana = 5 THEN RETURN 'Viernes';
            WHEN diaSemana = 6 THEN RETURN 'Sábado';
            WHEN diaSemana = 7 THEN RETURN 'Domingo';
            ELSE RETURN 'No existe';
        END CASE;
    END $$
DELIMITER ;
SELECT dia_semana(4);

/*-|4|- 
Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor 
de los tres.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS mayor $$
CREATE FUNCTION mayor(numero1 DECIMAL(10, 2), numero2 DECIMAL(10, 2), numero3 DECIMAL(10, 2))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        IF numero1 > numero2 AND numero1 > numero3 THEN
            SET resultado = numero1;
        ELSEIF numero2 > numero1 AND numero2 > numero3 THEN
            SET resultado = numero2;
        ELSE
            SET resultado = numero3;
        END IF;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT mayor(3.5, -1, 2.5);

/*-|5|- 
Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que 
se recibirá como parámetro de entrada.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS area_circulo $$
CREATE FUNCTION area_circulo(radio DECIMAL(10, 2))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        SET resultado = PI() * POW(radio, 2);
        RETURN resultado;
    END $$
DELIMITER ;
SELECT area_circulo(6.5);

/*-|6|- 
Escribe una función que devuelva como salida el número de años que han transcurrido entre dos 
fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de 
entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.

Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:
- DATEDIFF
- TRUNCATE
*/

DELIMITER $$
DROP FUNCTION IF EXISTS años_transcurridos $$
CREATE FUNCTION años_transcurridos(fecha1 DATE, fecha2 DATE)
    RETURNS INT UNSIGNED
    BEGIN
        DECLARE resultado INT UNSIGNED;
        IF(fecha1 > fecha2) THEN
            SET resultado = TIMESTAMPDIFF(YEAR, fecha2, fecha1);
        ELSE
            SET resultado = TIMESTAMPDIFF(YEAR, fecha1, fecha2);
        END IF;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT años_transcurridos('2031-03-03', '2016-11-07');

/*-|7|- 
Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. 
La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin 
acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función 
debe devolver la cadena Maria.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS sin_acentos $$
CREATE FUNCTION sin_acentos(cadena VARCHAR(100))
    RETURNS VARCHAR(100)
    BEGIN
        SET cadena = REPLACE(cadena, 'á', 'a');
        SET cadena = REPLACE(cadena, 'é', 'e');
        SET cadena = REPLACE(cadena, 'í', 'i');
        SET cadena = REPLACE(cadena, 'ó', 'o');
        SET cadena = REPLACE(cadena, 'ú', 'u');
        SET cadena = REPLACE(cadena, 'Á', 'A');
        SET cadena = REPLACE(cadena, 'É', 'E');
        SET cadena = REPLACE(cadena, 'Í', 'I');
        SET cadena = REPLACE(cadena, 'Ó', 'O');
        SET cadena = REPLACE(cadena, 'Ú', 'U');
        RETURN cadena;
    END $$
DELIMITER ;
SELECT sin_acentos('ÁÉÍÓÚáéíóú');

-- 1.8.4 Funciones con sentencias SQL

/*-|1|- 
Escribe una función para la base de datos tienda que devuelva el número total de productos que 
hay en la tabla productos.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS total_productos $$
CREATE FUNCTION total_productos()
    RETURNS INT UNSIGNED
    BEGIN
        DECLARE resultado INT UNSIGNED;
        SELECT COUNT(*) INTO resultado FROM producto;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT total_productos();

/*-|2|- 
Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los 
productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro 
de entrada será el nombre del fabricante.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS precio_medio $$
CREATE FUNCTION precio_medio(fabricante VARCHAR(50))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        SELECT AVG(p.precio) INTO resultado
        FROM producto p
        INNER JOIN fabricante f ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT precio_medio('Asus');

/*-|3|- 
Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los 
productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro 
de entrada será el nombre del fabricante.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS precio_maximo $$
CREATE FUNCTION precio_maximo(fabricante VARCHAR(50))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        SELECT MAX(p.precio) INTO resultado
        FROM producto p
        INNER JOIN fabricante f ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT precio_maximo('Samsung');

/*-|4|- 
Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los 
productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro 
de entrada será el nombre del fabricante.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS precio_minimo $$
CREATE FUNCTION precio_minimo(fabricante VARCHAR(50))
    RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE resultado DECIMAL(10, 2);
        SELECT MIN(p.precio) INTO resultado
        FROM producto p
        INNER JOIN fabricante f ON p.id_fabricante = f.id
        WHERE f.nombre = fabricante;
        RETURN resultado;
    END $$
DELIMITER ;
SELECT precio_minimo('Hewlett-Packard');

-- 1.8.5 Manejo de errores en MySQL

/*-|1|- 
Crea una base de datos llamada test que contenga una tabla llamada alumno. 
La tabla debe tener cuatro columnas:
- id: entero sin signo (clave primaria).
- nombre: cadena de 50 caracteres.
- apellido1: cadena de 50 caracteres.
- apellido2: cadena de 50 caracteres.
*/

CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS alumno(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno
# con las siguientes características. El procedimiento recibe cuatro parámetros de entrada
# (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. El procedimiento devolverá
# como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido
# realizar con éxito y un valor igual a 1 en caso contrario.

# Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene
# una clave primaria repetida.

DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_alumno $$
CREATE PROCEDURE insertar_alumno(
    IN cod INT UNSIGNED,
    IN nom VARCHAR(50),
    IN ape1 VARCHAR(50),
    IN ape2 VARCHAR(50),
    OUT error INT
)
    BEGIN
        DECLARE EXIT HANDLER FOR 1062 SET error = 1;
        INSERT INTO alumno VALUES(cod, nom, ape1, ape2);
        SET error = 0;
    END $$
DELIMITER ;
CALL insertar_alumno(1, 'Juan', 'García', 'Pérez', @error);
SELECT @error;

SELECT * FROM alumno;

-- 1.8.6 Transacciones con procedimientos almacenados

/*-|1|- 
Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
Tabla cuentas:
- id_cuenta: entero sin signo (clave primaria).
- saldo: real sin signo.
Tabla entradas:
- id_butaca: entero sin signo (clave primaria).
- nif: cadena de 9 caracteres.
*/

CREATE DATABASE IF NOT EXISTS cine;
USE cine;
CREATE TABLE IF NOT EXISTS cuentas(
    id_cuenta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    saldo DECIMAL(10, 2) UNSIGNED
);
CREATE TABLE IF NOT EXISTS entradas(
    id_butaca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9)
);

# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada
# con las siguientes características. El procedimiento recibe 3 parámetros de entrada (nif,
# id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que tendrá un valor igual
# a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.

# El procedimiento de compra realiza los siguientes pasos:
# - Inicia una transacción.
# - Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta
#   adecuado.
# - Inserta una una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar
#   el usuario (nif).
# - Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error
#   entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.

# Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.

# - ERROR 1264 (Out of range value)
# - ERROR 1062 (Duplicate entry for PRIMARY KEY)

DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada $$
CREATE PROCEDURE comprar_entrada(
    IN dni VARCHAR(9),
    IN idCuenta INT UNSIGNED,
    IN idButaca INT UNSIGNED,
    OUT error INT
)
    BEGIN
        DECLARE EXIT HANDLER FOR 1264, 1062 SET error = 1;
        START TRANSACTION;
        UPDATE cuentas SET saldo = saldo - 5 WHERE id_cuenta = idCuenta;
        INSERT INTO entradas VALUES(idButaca, dni);
        COMMIT;
        SET error = 0;
    END $$
DELIMITER ;
CALL comprar_entrada('12345678A', 1, 1, @error);
SELECT @error;


-- 1.8.7 Cursores

/*-|1|- 
Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla 
llamada alumnos y 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está 
formada por las siguientes columnas:
- id (entero sin signo y clave primaria)
- nombre (cadena de caracteres)
- apellido1 (cadena de caracteres)
- apellido2 (cadena de caracteres
- fecha_nacimiento (fecha)
*/

CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS alumnos(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fecha_nacimiento DATE
);
INSERT INTO alumnos VALUES(1, 'Juan', 'Fernández', 'Gómez', '2005-01-26');
INSERT INTO alumnos VALUES(2, 'María', 'Hernández', 'Jiménez', '2004-03-21');
INSERT INTO alumnos VALUES(3, 'Pedro', 'García', 'Márquez', '2006-05-17');
INSERT INTO alumnos VALUES(4, 'Ana', 'López', 'Pérez', '2004-11-01');

# Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un
# valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para
# modificar la tabla y añadir la nueva columna.

ALTER TABLE alumnos ADD COLUMN edad INT;

# Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que
# han pasado desde la fecha actual hasta la fecha pasada como parámetro:
# - Función: calcular_edad
# - Entrada: Fecha
# - Salida: Número de años (entero)

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_edad $$
CREATE FUNCTION calcular_edad(fecha DATE)
    RETURNS INT
    BEGIN
        DECLARE edad INT;
        SET edad = TIMESTAMPDIFF(YEAR, fecha, NOW());
        RETURN edad;
    END $$
DELIMITER ;
SELECT calcular_edad('2005-01-26');

# Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya existen
# en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que
# calcule la edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función
# calcular_edad que hemos creado en el paso anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actualizar_columna_edad()
    BEGIN
        DECLARE fin INT DEFAULT 0;
        DECLARE cod INT UNSIGNED;
        DECLARE fecha DATE;
        DECLARE cur CURSOR FOR SELECT id, fecha_nacimiento FROM alumnos;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
        OPEN cur;
        WHILE fin = 0 DO
            FETCH cur INTO cod, fecha;
            UPDATE alumnos SET edad = calcular_edad(fecha) WHERE id = cod;
        END WHILE;
        CLOSE cur;
    END $$
DELIMITER ;
CALL actualizar_columna_edad();

SELECT * FROM alumnos;

/*-|2|- 
Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez que 
hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma 
automática.
*/

ALTER TABLE alumnos ADD COLUMN email VARCHAR(100);

# Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre,
# apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
# - Procedimiento: crear_email
# - Entrada:
# 	· nombre (cadena de caracteres)
# 	· apellido1 (cadena de caracteres)
#	· apellido2 (cadena de caracteres)
#	· dominio (cadena de caracteres)
# - Salida:
# 	· email (cadena de caracteres)
	
# devuelva una dirección de correo electrónico con el siguiente formato:
# - El primer carácter del parámetro nombre.
# - Los tres primeros caracteres del parámetro apellido1.
# - Los tres primeros caracteres del parámetro apellido2.
# - El carácter @.
# - El dominio pasado como parámetro.

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email(
    IN nombre VARCHAR(50),
    IN apellido1 VARCHAR(50),
    IN apellido2 VARCHAR(50),
    IN dominio VARCHAR(50),
    OUT email VARCHAR(100)
)
    BEGIN
        SET email = CONCAT(LOWER(LEFT(nombre, 1)),LOWER(LEFT(apellido1, 3)), LOWER(LEFT(apellido2, 3)),'@',dominio);
    END $$
DELIMITER ;
CALL crear_email('Marcos', 'Burgos', 'Lopez', 'zaragoza.salesianos.edu', @email);
SELECT @email;

# Ahora escriba un procedimiento que permita crear un email para todos los alumnmos que ya existen
# en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_email que
# actualice la columna email de la tabla alumnos. Este procedimiento hará uso del procedimiento
# crear_email que hemos creado en el paso anterior.

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_columna_email $$
CREATE PROCEDURE actualizar_columna_email()
    BEGIN
        DECLARE fin INT DEFAULT 0;
        DECLARE cod INT UNSIGNED;
        DECLARE nom VARCHAR(50);
        DECLARE ape1 VARCHAR(50);
        DECLARE ape2 VARCHAR(50);
        DECLARE dominio VARCHAR(50) DEFAULT 'zaragoza.salesianos.edu';
        DECLARE cur CURSOR FOR SELECT id, nombre, apellido1, apellido2 FROM alumnos;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
        OPEN cur;
        WHILE fin = 0 DO
            FETCH cur INTO cod, nom, ape1, ape2;
            CALL crear_email(nom, ape1, ape2, dominio, @email);
            UPDATE alumnos SET email = @email WHERE id = cod;
        END WHILE;
        CLOSE cur;
    END $$
DELIMITER ;
CALL actualizar_columna_email();

SELECT * FROM alumnos;

/*-|3|- 
Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la 
tabla alumnos separados por un punto y coma. 
Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iescelia.org.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos $$
CREATE PROCEDURE crear_lista_emails_alumnos()
    BEGIN
        DECLARE fin INT DEFAULT 0;
        DECLARE correo VARCHAR(100);
        DECLARE lista VARCHAR(1000) DEFAULT '';
        DECLARE cur CURSOR FOR SELECT email FROM alumnos;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
        OPEN cur;
        WHILE fin = 0 DO
            FETCH cur INTO correo;
            SET lista = CONCAT(lista, correo, ';');
        END WHILE;
        CLOSE cur;
        SELECT lista;
    END $$
DELIMITER ;
CALL crear_lista_emails_alumnos();

-- 1.8.8 Triggers

/*-|1|- 
Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes 
columnas.
Tabla alumnos:
- id (entero sin signo)
- nombre (cadena de caracteres)
- apellido1 (cadena de caracteres)
- apellido2 (cadena de caracteres)
- nota (número real)
*/

CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS alumnos2 (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    nota FLOAT(2, 1) NOT NULL
);

# Una vez creada la tabla escriba dos triggers con las siguientes características:
# - Trigger 1: trigger_check_nota_before_insert
#	· Se ejecuta sobre la tabla alumnos.
#	· Se ejecuta antes de una operación de inserción.
#	· Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
#	· Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert $$
CREATE TRIGGER trigger_check_nota_before_insert BEFORE INSERT ON alumnos2
    FOR EACH ROW
    BEGIN
        IF NEW.nota < 0 THEN
            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN
            SET NEW.nota = 10;
        END IF;
    END $$
DELIMITER ;

# - Trigger2 : trigger_check_nota_before_update
#	· Se ejecuta sobre la tabla alumnos.
#	· Se ejecuta antes de una operación de actualización.
#	· Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
#	· Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update $$
CREATE TRIGGER trigger_check_nota_before_update BEFORE UPDATE ON alumnos2
    FOR EACH ROW
    BEGIN
        IF NEW.nota < 0 THEN
            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN
            SET NEW.nota = 10;
        END IF;
    END $$
DELIMITER ;

# Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la
# tabla alumnos y verifica que los triggers se están ejecutando correctamente.

INSERT INTO alumnos2 (nombre, apellido1, apellido2, nota) VALUES ('Marcos', 'Burgos', 'López', 11);
INSERT INTO alumnos2 (nombre, apellido1, apellido2, nota) VALUES ('José', 'García', 'Hernández', -1);
INSERT INTO alumnos2 (nombre, apellido1, apellido2, nota) VALUES ('María', 'Sánchez', 'Gil', 5);
INSERT INTO alumnos2 (nombre, apellido1, apellido2, nota) VALUES ('Lucía', 'García', 'Hernández', 10);

SELECT * FROM alumnos2;

UPDATE alumnos2 SET nota = 11 WHERE id = 1;
UPDATE alumnos2 SET nota = -1 WHERE id = 2;
UPDATE alumnos2 SET nota = 5 WHERE id = 3;
UPDATE alumnos2 SET nota = 10 WHERE id = 4;

SELECT * FROM alumnos2;

/*-|2|- 
Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes 
columnas:
Tabla alumnos:
- id (entero sin signo)
- nombre (cadena de caracteres)
- apellido1 (cadena de caracteres)
- apellido2 (cadena de caracteres)
- email (cadena de caracteres)
*/

CREATE DATABASE IF NOT EXISTS test;
USE test;
CREATE TABLE IF NOT EXISTS alumnos3 (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

# Escriba un procedimiento llamado crear_email que dados los parámetros de entrada:
# nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
# - Procedimiento: crear_email
# - Entrada:
#	· nombre (cadena de caracteres)
#	· apellido1 (cadena de caracteres)
#	· apellido2 (cadena de caracteres)
#	· dominio (cadena de caracteres)
# - Salida:
#	· email (cadena de caracteres)

# devuelva una dirección de correo electrónico con el siguiente formato:
# - El primer carácter del parámetro nombre.
# - Los tres primeros caracteres del parámetro apellido1.
# - Los tres primeros caracteres del parámetro apellido2.
# - El carácter @.
# - El dominio pasado como parámetro.

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email (
    IN nombre VARCHAR(50),
    IN apellido1 VARCHAR(50),
    IN apellido2 VARCHAR(50),
    IN dominio VARCHAR(100),
    OUT email VARCHAR(100)
)
    BEGIN
        SET email = CONCAT(LOWER(LEFT(nombre, 1)),LOWER(LEFT(apellido1, 3)),LOWER(LEFT(apellido2, 3)),'@',dominio);
    END $$
DELIMITER ;

# Una vez creada la tabla escriba un trigger con las siguientes características:
# - Trigger: trigger_crear_email_before_insert
#	· Se ejecuta sobre la tabla alumnos.
#	· Se ejecuta antes de una operación de inserción.
#	· Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
#	· Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_crear_email_before_insert $$
CREATE TRIGGER trigger_crear_email_before_insert BEFORE INSERT ON alumnos3
    FOR EACH ROW
    BEGIN
        IF NEW.email IS NULL THEN
            CALL crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2,  'zaragoza.salesianos.edu', @email);
            SET NEW.email = @email;
        END IF;
    END $$
DELIMITER ;

SELECT * FROM alumnos3;

INSERT INTO alumnos3 (nombre, apellido1, apellido2, email) VALUES ('Marcos', 'Burgos', 'López', NULL);

/*-|3|- 
Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:
Trigger: trigger_guardar_email_after_update:
- Se ejecuta sobre la tabla alumnos.
- Se ejecuta después de una operación de actualización.
- Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro 
  en una tabla llamada log_cambios_email.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_email_after_update $$
CREATE TRIGGER trigger_guardar_email_after_update AFTER UPDATE ON alumnos
    FOR EACH ROW
    BEGIN
        IF OLD.email <> NEW.email THEN
            INSERT INTO log_cambios_email (id_alumno, fecha_hora, old_email, new_email)
            VALUES (OLD.id, NOW(), OLD.email, NEW.email);
        END IF;
    END $$
DELIMITER ;

# La tabla log_cambios_email contiene los siguientes campos:
# - id: clave primaria (entero autonumérico)
# - id_alumno: id del alumno (entero)
# - fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# - old_email: valor anterior del email (cadena de caracteres)
# - new_email: nuevo valor con el que se ha actualizado

CREATE TABLE IF NOT EXISTS log_cambios_email (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT UNSIGNED NOT NULL,
    fecha_hora DATETIME NOT NULL,
    old_email VARCHAR(100) NOT NULL,
    new_email VARCHAR(100) NOT NULL
);

SELECT * FROM log_cambios_email;

/*-|4|- 
Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:
- Trigger: trigger_guardar_alumnos_eliminados:
- Se ejecuta sobre la tabla alumnos.
- Se ejecuta después de una operación de borrado.
- Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_guardar_alumnos_eliminados $$
CREATE TRIGGER trigger_guardar_alumnos_eliminados AFTER DELETE ON alumnos
    FOR EACH ROW
    BEGIN
        INSERT INTO log_alumnos_eliminados (id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
        VALUES (OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
    END $$
DELIMITER ;

# La tabla log_alumnos_eliminados contiene los siguientes campos:
# - id: clave primaria (entero autonumérico)
# - id_alumno: id del alumno (entero)
# - fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# - nombre: nombre del alumno eliminado (cadena de caracteres)
# - apellido1: primer apellido del alumno eliminado (cadena de caracteres)
# - apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
# - email: email del alumno eliminado (cadena de caracteres)

CREATE TABLE IF NOT EXISTS log_alumnos_eliminados (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT UNSIGNED NOT NULL,
    fecha_hora DATETIME NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

SELECT * FROM log_alumnos_eliminados;



