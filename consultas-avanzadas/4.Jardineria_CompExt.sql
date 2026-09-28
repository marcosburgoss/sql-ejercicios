/*-|1|-
Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
*/

select c.nombre_cliente
from cliente c
left join pago p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

/*-|2|-
Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
*/

select c.nombre_cliente
from cliente c
left join pedido p on c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

/*-|3|-
Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado
ningún pedido.
*/

select distinct c.nombre_cliente
from cliente c
left join pago pa on c.codigo_cliente = pa.codigo_cliente
left join pedido pe on c.codigo_cliente = pe.codigo_cliente
where pa.codigo_cliente is null
    or pe.codigo_cliente is null;

/*-|4|-
Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
*/

select e.nombre, e.apellido1, e.apellido2
from empleado e
left join oficina o on e.codigo_oficina = o.codigo_oficina
where o.codigo_oficina is null;

/*-|5|-
Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
*/

select e.nombre, e.apellido1, e.apellido2
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.codigo_empleado_rep_ventas is null;

/*-|6|-
Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos
de la oficina donde trabajan.
*/

select e.nombre, e.apellido1, e.apellido2, o.*
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
left join oficina o on e.codigo_oficina = o.codigo_oficina
where c.codigo_empleado_rep_ventas is null;

/*-|7|-
Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un
cliente asociado.
*/

select e.nombre, e.apellido1, e.apellido2
from empleado e
left join oficina o on e.codigo_oficina = o.codigo_oficina
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
where o.codigo_oficina is null
    or c.codigo_empleado_rep_ventas is null;

/*-|8|-
Devuelve un listado de los productos que nunca han aparecido en un pedido.
*/

select p.codigo_producto, p.nombre
from producto p
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
where dp.codigo_producto is null;

/*-|9|-
Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar
el nombre, la descripción y la imagen del producto.
*/

select p.nombre, p.descripcion, g.imagen
from producto p
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
left join gama_producto g on p.gama = g.gama
where dp.codigo_producto is null;

/*-|10|-
Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de
ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
*/

select distinct o.codigo_oficina, o.ciudad, o.pais
from oficina o
left join empleado e on o.codigo_oficina = e.codigo_oficina
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
left join pedido pe on c.codigo_cliente = pe.codigo_cliente
left join detalle_pedido dp on pe.codigo_pedido = dp.codigo_pedido
left join producto pr on dp.codigo_producto = pr.codigo_producto
where pr.gama = 'Frutales'
    and e.codigo_empleado is null;

/*-|11|-
Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
*/

select distinct c.nombre_cliente
from cliente c
left join pedido pe on c.codigo_cliente = pe.codigo_cliente
left join pago pa on c.codigo_cliente = pa.codigo_cliente
where pa.codigo_cliente is null;

/*-|12|-
Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su
jefe asociado.
*/

select e.nombre, e.apellido1, e2.nombre as jefe
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
left join empleado e2 on e.codigo_jefe = e2.codigo_empleado
where c.codigo_empleado_rep_ventas is null;




