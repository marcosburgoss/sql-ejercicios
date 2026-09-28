/*-|1|-
Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
*/

-- SQL 1 (sin join)
select c.nombre_cliente, e.nombre as nombre_representante, e.apellido1 as apellido_representante
from cliente c, empleado e
where c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- SQL 2 (con join)
select c.nombre_cliente, e.nombre as nombre_representante, e.apellido1 as apellido_representante
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*-|2|-
Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
*/

-- SQL 1 (sin join)
select distinct c.nombre_cliente, e.nombre as nombre_representante
from cliente c, empleado e, pago p
where c.codigo_empleado_rep_ventas = e.codigo_empleado
  and c.codigo_cliente = p.codigo_cliente;

-- SQL 2 (con join)
select distinct c.nombre_cliente, e.nombre as nombre_representante
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p on c.codigo_cliente = p.codigo_cliente;

-- SQL 3 (con natural join)
select distinct c.nombre_cliente, e.nombre as nombre_representante
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
natural join pago p;

/*-|3|-
Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
*/

-- SQL 1 (sin join)
select c.nombre_cliente, e.nombre as nombre_representante
from cliente c, empleado e
where c.codigo_empleado_rep_ventas = e.codigo_empleado
  and c.codigo_cliente not in (
    select p.codigo_cliente
    from pago p
    );

-- SQL 2 (con join)
select c.nombre_cliente, e.nombre as nombre_representante
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

-- SQL 3 (con natural join)
select c.nombre_cliente, e.nombre as nombre_representante
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
natural left join pago p
where p.codigo_cliente is null;

/*-|4|-
Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de
la oficina a la que pertenece el representante.
*/

-- SQL 1 (sin join)
select distinct c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c, empleado e, oficina o, pago p
where c.codigo_empleado_rep_ventas = e.codigo_empleado
  and e.codigo_oficina = o.codigo_oficina
  and c.codigo_cliente = p.codigo_cliente;

-- SQL 2 (con join)
select distinct c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
inner join pago p on c.codigo_cliente = p.codigo_cliente;

-- SQL 3 (con natural join)
select distinct c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
natural join pago p;

/*-|5|-
Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la
ciudad de la oficina a la que pertenece el representante.
*/

-- SQL 1 (sin join)
select c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c, empleado e, oficina o
where c.codigo_empleado_rep_ventas = e.codigo_empleado
  and e.codigo_oficina = o.codigo_oficina
  and c.codigo_cliente not in (
    select p.codigo_cliente
    from pago p
    );

-- SQL 2 (con join)
select c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

-- SQL 3 (con natural join)
select c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
natural left join pago p
where p.codigo_cliente is null;

/*-|6|-
Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
*/

-- SQL 1 (sin join)
select distinct o.linea_direccion1, o.linea_direccion2, o.codigo_postal, o.ciudad, o.pais
from oficina o, empleado e, cliente c
where e.codigo_oficina = o.codigo_oficina
  and e.codigo_empleado = c.codigo_empleado_rep_ventas
  and c.ciudad = 'Fuenlabrada';

-- SQL 2 (con join)
select distinct o.linea_direccion1, o.linea_direccion2, o.codigo_postal, o.ciudad, o.pais
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
where c.ciudad = 'Fuenlabrada';

/*-|7|-
Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina
a la que pertenece el representante.
*/

-- SQL 1 (sin join)
select c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c, empleado e, oficina o
where c.codigo_empleado_rep_ventas = e.codigo_empleado
  and e.codigo_oficina = o.codigo_oficina;

-- SQL 2 (con join)
select c.nombre_cliente, e.nombre as nombre_representante, o.ciudad as ciudad_oficina
from cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina;

/*-|8|-
Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
*/

-- SQL 1 (sin join)
select e.nombre as nombre_empleado, e2.nombre as nombre_jefe
from empleado e, empleado e2
where e.codigo_jefe = e2.codigo_empleado;

-- SQL 2 (con join)
select e.nombre as nombre_empleado, e2.nombre as nombre_jefe
from empleado e
inner join empleado e2 on e.codigo_jefe = e2.codigo_empleado;

/*-|9|-
Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de su jefe.
*/

-- SQL 1 (sin join)
select e.nombre as nombre_empleado, e2.nombre as nombre_jefe, e3.nombre as nombre_jefe_jefe
from empleado e, empleado e2, empleado e3
where e.codigo_jefe = e2.codigo_empleado
  and e2.codigo_jefe = e3.codigo_empleado;

-- SQL 2 (con join)
select e.nombre as nombre_empleado, e2.nombre as nombre_jefe, e3.nombre as nombre_jefe_jefe
from empleado e
inner join empleado e2 on e.codigo_jefe = e2.codigo_empleado
inner join empleado e3 on e2.codigo_jefe = e3.codigo_empleado;

/*-|10|-
Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
*/

-- SQL 1 (sin join)
select distinct c.nombre_cliente
from cliente c, pedido p
where c.codigo_cliente = p.codigo_cliente
  and p.fecha_entrega > p.fecha_esperada;

-- SQL 2 (con join)
select distinct c.nombre_cliente
from cliente c
inner join pedido p on c.codigo_cliente = p.codigo_cliente
where p.fecha_entrega > p.fecha_esperada;

/*-|11|-
Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
*/

-- SQL 1 (sin join)
select distinct c.nombre_cliente, pr.gama
from cliente c, pedido pe, detalle_pedido dp, producto pr
where c.codigo_cliente = pe.codigo_cliente
  and pe.codigo_pedido = dp.codigo_pedido
  and dp.codigo_producto = pr.codigo_producto;

-- SQL 2 (con join)
select distinct c.nombre_cliente, pr.gama
from cliente c
inner join pedido pe on c.codigo_cliente = pe.codigo_cliente
inner join detalle_pedido dp on pe.codigo_pedido = dp.codigo_pedido
inner join producto pr on dp.codigo_producto = pr.codigo_producto;

-- SQL 3 (con natural join)
select distinct c.nombre_cliente, pr.gama
from cliente c
inner join pedido pe on c.codigo_cliente = pe.codigo_cliente
inner join detalle_pedido dp on pe.codigo_pedido = dp.codigo_pedido
natural join producto pr;