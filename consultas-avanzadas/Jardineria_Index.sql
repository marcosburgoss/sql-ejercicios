/*-|1|-
Consulte cuáles son los índices que hay en la tabla producto utilizando las instrucciones SQL que nos
permiten obtener esta información de la tabla.
*/
SHOW INDEX FROM producto;

/*-|2|-
Haga uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas y diga cuál
de las dos consultas realizará menos comparaciones para encontrar el producto que estamos buscando.
¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?.
*/
EXPLAIN SELECT *
FROM producto
WHERE codigo_producto = 'OR-114';
-- 1 comparación

EXPLAIN SELECT *
FROM producto
WHERE nombre = 'Evonimus Pulchellus';
-- 207 comparaciones

-- La primera consulta realiza menos comparaciones porque el índice de la tabla producto está creado sobre la columna,
-- en cambio, la segunda consulta no tiene índice y por tanto realiza más comparaciones.

/*-|3|-
Suponga que estamos trabajando con la base de datos jardineria y queremos saber optimizar las siguientes consultas.
¿Cuál de las dos sería más eficiente?. Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se
están realizando las consultas.
*/
EXPLAIN SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago) = 2008;

EXPLAIN SELECT AVG(total)
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';

-- Ambas columnas son de igual de eficientes, ya que no hay un índice que nos permita optimizar la consulta.
-- Si hubiera un índice sobre la columna fecha_pago, la segunda consulta sería más eficiente porque no tendría que
-- comparar todos los valores de la columna, sino que solo tendría que comparar los valores que estén entre las fechas
-- indicadas. En cambio, la primera consulta tendría que comparar todos los valores de la columna.

/*-|4|-
Optimiza la siguiente consulta creando índices cuando sea necesario. Se recomienda hacer uso de EXPLAIN para
obtener información sobre cómo se están realizando las consultas.
*/
SHOW INDEX FROM pedido;
SHOW INDEX FROM cliente;

CREATE INDEX nombre_cliente ON cliente(nombre_cliente);

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';

/*-|5|-
¿Por qué no es posible optimizar el tiempo de ejecución de las siguientes consultas, incluso haciendo
uso de índices?
*/
EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A%';

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A';

-- En ambos casos no se puede optimizar el tiempo de ejecución porque no se puede crear un índice sobre una columna
-- que contenga valores que no empiecen por la letra A. Por tanto, no se puede utilizar el índice para optimizar
-- la consulta.

/*-|6|-
Crea un índice de tipo FULLTEXT sobre las columnas nombre y descripcion de la tabla producto.
*/
CREATE FULLTEXT INDEX nombre_descripcion ON producto(nombre, descripcion);

/*-|7|-
Una vez creado el índice del ejercicio anterior realiza las siguientes consultas haciendo uso de la
función MATCH, para buscar todos los productos que:
(Realice una consulta para cada uno de los modos de búsqueda full-text que existen en MySQL (IN NATURAL
LANGUAGE MODE, IN BOOLEAN MODE y WITH QUERY EXPANSION) y compare los resultados que ha obtenido en cada caso)
*/
-- Contienen la palabra planta en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta' WITH QUERY EXPANSION);

-- Contienen la palabra planta seguida de cualquier carácter o conjunto de caracteres, en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' WITH QUERY EXPANSION);

-- Empiezan con la palabra planta en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' IN NATURAL LANGUAGE MODE)
	AND nombre LIKE 'planta%' OR descripcion LIKE 'planta%';

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' IN BOOLEAN MODE)
	AND nombre LIKE 'planta%' OR descripcion LIKE 'planta%';

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('planta*' WITH QUERY EXPANSION)
	AND nombre LIKE 'planta%' OR descripcion LIKE 'planta%';

-- Contienen la palabra tronco o la palabra árbol en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco árbol' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco árbol' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco árbol' WITH QUERY EXPANSION);

-- Contienen la palabra tronco y la palabra árbol en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('+tronco +árbol' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('+tronco +árbol' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('+tronco +árbol' WITH QUERY EXPANSION);

-- Contienen la palabra tronco pero no contienen la palabra árbol en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco -árbol' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco -árbol' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('tronco -árbol' WITH QUERY EXPANSION);

-- Contiene la frase proviene de las costas en el nombre o en la descripción.
SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('"proviene de las costas"' IN NATURAL LANGUAGE MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('"proviene de las costas"' IN BOOLEAN MODE);

SELECT *
FROM producto
WHERE MATCH(nombre, descripcion) AGAINST('"proviene de las costas"' WITH QUERY EXPANSION);

/*-|8|-
Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto y nombre_contacto de la tabla cliente.
*/
CREATE INDEX apellido_nombre ON cliente(apellido_contacto, nombre_contacto);

SHOW INDEX FROM cliente;

/*-|9|-
Una vez creado el índice del ejercicio anterior realice las siguientes consultas haciendo uso de EXPLAIN:
*/
-- Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
EXPLAIN SELECT *
FROM cliente
WHERE apellido_contacto = 'Villar' AND nombre_contacto = 'Javier';
-- Se ha examinado una sola fila.

-- Busca el ciente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta
-- encontrar el resultado?
EXPLAIN SELECT *
FROM cliente
WHERE apellido_contacto = 'Villar';
-- Se ha examinado una sola fila.

-- Busca el ciente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta
-- encontrar el resultado? ¿Qué ha ocurrido en este caso?
EXPLAIN SELECT *
FROM cliente
WHERE nombre_contacto = 'Javier';
-- Se han examinado todas las filas de la tabla (36).

/*-|10|-
Calcula cuál podría ser un buen valor para crear un índice sobre un prefijo de la columna nombre_cliente de
la tabla cliente. Tenga en cuenta que un buen valor será aquel que nos permita utilizar el menor número de
caracteres para diferenciar todos los valores que existen en la columna sobre la que estamos creando el índice.
*/
-- En primer lugar calculamos cuántos valores distintos existen en la columna nombre_cliente. Necesitarás utilizar
-- la función COUNT y DISTINCT.
SELECT COUNT(DISTINCT nombre_cliente)
FROM cliente;
-- Hay 35 valores distintos.

-- Haciendo uso de la función LEFT ve calculando el número de caracteres que necesitas utilizar como prefijo para
-- diferenciar todos los valores de la columna. Necesitarás la función COUNT, DISTINCT y LEFT.
SELECT COUNT(DISTINCT LEFT(nombre_cliente, 11))
FROM cliente;
-- 11 caracteres son suficientes para diferenciar todos los valores de la columna.

-- Una vez que hayas encontrado el valor adecuado para el prefijo, crea el índice sobre la columna nombre_cliente
-- de la tabla cliente.
CREATE INDEX index_nombre_cliente ON cliente(nombre_cliente(11));

-- Ejecuta algunas consultas de prueba sobre el índice que acabas de crear.
EXPLAIN SELECT *
FROM cliente
WHERE nombre_cliente LIKE 'C%';








