/*-|1|- 
Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado 
debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los 
clientes.
*/

select c.id, c.nombre, c.apellido1, c.apellido2, p.*
from cliente c
left join pedido p on c.id = p.id_cliente 
order by c.apellido1, c.apellido2, c.nombre;

/*-|2|- 
Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han 
realizado. Este listado también debe incluir los comerciales que no han realizado ningún 
pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo 
apellido y nombre de los comerciales.
*/

select c.id, c.nombre, c.apellido1, c.apellido2, p.*
from comercial c
left join pedido p on c.id = p.id_comercial  
order by c.apellido1, c.apellido2, c.nombre;  

/*-|3|- 
Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
*/

select c.id, c.nombre, c.apellido1, c.apellido2
from cliente c
left join pedido p on c.id = p.id_cliente 
where p.id_cliente is null;  

/*-|4|- 
Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
*/

select c.id, c.nombre, c.apellido1, c.apellido2
from comercial c
left join pedido p on c.id = p.id_comercial  
where p.id_comercial is null;

/*-|5|- 
Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales 
que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos 
y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.
*/

select cl.id, cl.nombre, cl.apellido1, cl.apellido2, 'Cliente' as tipo
from cliente cl
left join pedido p1 on cl.id = p1.id_cliente
where p1.id_cliente is null
union
select co.id, co.nombre, co.apellido1, co.apellido2, 'Comercial' as tipo
from comercial co
left join pedido p2 on co.id = p2.id_comercial  
where p2.id_comercial is null	
order by apellido1, apellido2, nombre;

/*
select n, ap1, ap2, tipo
from (
select cl.id, cl.nombre as n, cl.apellido1 as ap1, cl.apellido2 as ap2, 'Cliente' as tipo
from cliente cl
left join pedido p1 on cl.id = p1.id_cliente
where p1.id_cliente is null
union
select co.id, co.nombre as n, co.apellido1 as ap1, co.apellido2 as ap2, 'Comercial' as tipo
from comercial co
left join pedido p2 on co.id = p2.id_comercial  
where p2.id_comercial is null) res
order by ap1, ap2, n;
*/


/*-|6|- 
¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? 
Justifique su respuesta.
*/
-- No, al tener los nombres de las columnas 'id' iguales, no funcionaría ya que lo que hace el natural join es
-- que las columnas con el mismo nombre de las tablas asociadas aparecen solo una sola vez.





