/*-|1|- 
Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que 
han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar 
los elementos repetidos.
*/

-- SQL 1 (sin join)
select distinct c.id, c.nombre, c.apellido1, c.apellido2
from cliente c, pedido p
where c.id = p.id_cliente
order by c.apellido1, c.apellido2;

-- SQL 2 (con join)
select distinct c.id, c.nombre, c.apellido1, c.apellido2  
from cliente c
inner join pedido p on c.id = p.id_cliente 
order by c.apellido1, c.apellido2;

/*-|2|- 
Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado 
debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos 
de los clientes ordenados alfabéticamente.
*/

-- SQL 1 (sin join)
select c.*, p.*
from cliente c, pedido p
where c.id = p.id_cliente
order by c.apellido1, c.apellido2;

-- SQL 2 (con join)
select c.*, p.*
from cliente c
inner join pedido p on c.id = p.id_cliente 
order by c.apellido1, c.apellido2;

/*-|3|- 
Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado 
debe mostrar los datos de los comerciales ordenados alfabéticamente.
*/

-- SQL 1 (sin join)
select c.*, p.*
from comercial c, pedido p
where c.id = p.id_comercial
order by c.apellido1, c.apellido2;

-- SQL 2 (con join)
select c.*, p.*
from comercial c
inner join pedido p on c.id = p.id_comercial 
order by c.apellido1, c.apellido2;

/*-|4|- 
Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado 
y con los datos de los comerciales asociados a cada pedido.
*/

-- SQL 1 (sin join)
select cl.*, p.*, co.*
from cliente cl, pedido p, comercial co
where cl.id = p.id_cliente
    and co.id = p.id_comercial;

-- SQL 2 (con join)
select cl.*, p.*, co.*
from cliente cl
inner join pedido p on cl.id = p.id_cliente 
inner join comercial co on co.id = p.id_comercial;

/*-|5|- 
Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, 
cuya cantidad esté entre 300 € y 1000 €.
*/

-- SQL 1 (sin join)
select c.id, c.nombre, c.apellido1, p.fecha as fecha_pedido, p.total
from cliente c, pedido p
where c.id = p.id_cliente
    and year(p.fecha) = 2017
    and p.total between 300 and 1000;

-- SQL 2 (con join)
select c.id, c.nombre, c.apellido1, p.fecha as fecha_pedido, p.total 
from cliente c
inner join pedido p on c.id = p.id_cliente 
where year(p.fecha) = 2017
	and p.total between 300 and 1000;

/*-|6|- 
Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún 
pedido realizado por María Santana Moreno.
*/

-- SQL 1 (sin join)
select distinct co.nombre, co.apellido1, co.apellido2
from comercial co, pedido p, cliente cl
where co.id = p.id_comercial
    and cl.id = p.id_cliente
    and cl.nombre = 'María'
    and cl.apellido1 = 'Santana'
    and cl.apellido2 = 'Moreno';

-- SQL 2 (con join)
select distinct co.nombre, co.apellido1, co.apellido2  
from cliente cl
inner join pedido p on cl.id = p.id_cliente 
inner join comercial co on co.id = p.id_comercial
where cl.nombre = 'María'
	and cl.apellido1 = 'Santana'
	and cl.apellido2 = 'Moreno';

/*-|7|- 
Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial 
Daniel Sáez Vega.
*/

-- SQL 1 (sin join)
select distinct cl.nombre
from cliente cl, pedido p, comercial co
where cl.id = p.id_cliente
    and co.id = p.id_comercial
    and co.nombre = 'Daniel'
    and co.apellido1 = 'Sáez'
    and co.apellido2 = 'Vega';

-- SQL 2 (con join)
select distinct cl.nombre 
from cliente cl
inner join pedido p on cl.id = p.id_cliente 
inner join comercial co on co.id = p.id_comercial
where co.nombre = 'Daniel'
	and co.apellido1 = 'Sáez'
	and co.apellido2 = 'Vega';

