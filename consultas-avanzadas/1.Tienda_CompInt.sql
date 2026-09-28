/*-|1|- 
Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
los productos de la base de datos.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id;

-- SQL 2 (con join)
select p.nombre as producto, p.precio, f.nombre as fabricante  
from producto p
inner join fabricante f on p.id_fabricante = f.id;

/*-|2|- 
Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, 
por orden alfabético.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
order by f.nombre;

-- SQL 2 (con join)
select p.nombre as producto, p.precio, f.nombre as fabricante  
from producto p
inner join fabricante f on p.id_fabricante = f.id 
order by f.nombre;

/*-|3|- 
Devuelve una lista con el identificador del producto, nombre del producto, identificador 
del fabricante y nombre del fabricante, de todos los productos de la base de datos.
*/

-- SQL 1 (sin join)
select p.id as id_producto, p.nombre as producto, f.id as id_fabricante, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id;

-- SQL 2 (con join)
select p.id as id_producto, p.nombre as producto, f.id as id_fabricante, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id;


/*-|4|- 
Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
order by p.precio asc
limit 1;

-- SQL 2 (con join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
order by p.precio asc
limit 1;

/*-|5|- 
Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
order by p.precio desc
limit 1;

-- SQL 2 (con join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
order by p.precio desc
limit 1;

/*-|6|- 
Devuelve una lista de todos los productos del fabricante Lenovo.
*/

-- SQL 1 (sin join)
select p.*, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
    and f.nombre = 'Lenovo';

-- SQL 2 (con join)
select p.*, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
where f.nombre = 'Lenovo';

/*-|7|- 
Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio 
mayor que 200€.
*/

-- SQL 1 (sin join)
select p.*, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
    and f.nombre = 'Crucial'
    and p.precio > 200;

-- SQL 2 (con join)
select p.*, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
where f.nombre = 'Crucial'
	and p.precio > 200;

/*-|8|- 
Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. 
Sin utilizar el operador IN.
*/

-- SQL 1 (sin join)
select p.*, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
    and (f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate');

-- SQL 2 (con join)
select p.*, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
where f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate';

/*-|9|- 
Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. 
Utilizando el operador IN.
*/

-- SQL 1 (sin join)
select p.*, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
    and f.nombre in ('Asus','Hewlett-Packard','Seagate');

-- SQL 2 (con join)
select p.*, f.nombre as fabricante
from producto p
inner join fabricante f on p.id_fabricante = f.id
where f.nombre in ('Asus','Hewlett-Packard','Seagate');

/*-|10|- 
Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo 
nombre termine por la vocal e.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio
from producto p, fabricante f
where p.id_fabricante = f.id
    and f.nombre like '%e';

-- SQL 2 (con join)
select p.nombre as producto, p.precio
from producto p 
inner join fabricante f on p.id_fabricante = f.id
where f.nombre like '%e';

/*-|11|- 
Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante 
contenga el carácter w en su nombre.
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio
from producto p, fabricante f
where p.id_fabricante = f.id
    and f.nombre like '%w%';

-- SQL 2 (con join)
select p.nombre as producto, p.precio
from producto p 
inner join fabricante f on p.id_fabricante = f.id
where f.nombre like '%w%';

/*-|12|- 
Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los 
productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por 
el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
*/

-- SQL 1 (sin join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id
    and p.precio >= 180
order by p.precio desc, p.nombre asc;

-- SQL 2 (con join)
select p.nombre as producto, p.precio, f.nombre as fabricante
from producto p 
inner join fabricante f on p.id_fabricante = f.id
where p.precio >= 180
order by p.precio desc, p.nombre asc;

/*-|13|- 
Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos 
fabricantes que tienen productos asociados en la base de datos.
*/

-- SQL 1 (sin join)
select distinct f.id as id_fabricante, f.nombre as fabricante
from producto p, fabricante f
where p.id_fabricante = f.id;

-- SQL 2 (con join)
select distinct f.id as id_fabricante, f.nombre as fabricante
from producto p 
inner join fabricante f on p.id_fabricante = f.id;
