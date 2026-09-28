/*-|1|- 
Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
*/

-- SQL 1 (sin join)
select e.nombre, e.apellido1, d.*
from empleado e, departamento d
where e.id_departamento = d.id;

-- SQL 2 (con join)
select e.nombre, e.apellido1, d.*  
from departamento d 
inner join empleado e on d.id = e.id_departamento;

/*-|2|- 
Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. 
Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en 
segundo lugar por los apellidos y el nombre de los empleados.
*/

-- SQL 1 (sin join)
select e.nombre, e.apellido1, d.*
from empleado e, departamento d
where e.id_departamento = d.id
order by d.nombre, e.apellido1, e.apellido2, e.nombre;

-- SQL 2 (con join)
select e.nombre, e.apellido1, d.*  
from departamento d 
inner join empleado e on d.id = e.id_departamento
order by d.nombre, e.apellido1, e.apellido2, e.nombre;

/*-|3|- 
Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos 
departamentos que tienen empleados.
*/

-- SQL 1 (sin join)
select distinct d.id, d.nombre
from empleado e, departamento d
where e.id_departamento = d.id;

-- SQL 2 (con join)
select distinct d.id, d.nombre  
from departamento d 
inner join empleado e on d.id = e.id_departamento;

/*-|4|- 
Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto 
actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del 
presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna 
presupuesto) el valor de los gastos que ha generado (columna gastos).
*/

-- SQL 1 (sin join)
select distinct d.id, d.nombre, (d.presupuesto-d.gastos) as presupuesto_actual
from empleado e, departamento d
where e.id_departamento = d.id;

-- SQL 2 (con join)
select distinct d.id, d.nombre, (d.presupuesto-d.gastos) as presupuesto_actual 
from departamento d 
inner join empleado e on d.id = e.id_departamento;

/*-|5|- 
Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
*/

-- SQL 1 (sin join)
select d.nombre as departamento
from empleado e, departamento d
where e.id_departamento = d.id and e.nif = '38382980M';

-- SQL 2 (con join)
select d.nombre as departamento
from departamento d 
inner join empleado e on d.id = e.id_departamento
where e.nif = '38382980M';

/*-|6|- 
Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.	
*/

-- SQL 1 (sin join)
select d.nombre as departamento
from empleado e, departamento d
where e.id_departamento = d.id
  and e.nombre = 'Pepe'
  and e.apellido1 = 'Ruiz'
  and e.apellido2 = 'Santana';

-- SQL 2 (con join)
select d.nombre as departamento
from departamento d 
inner join empleado e on d.id = e.id_departamento
where e.nombre = 'Pepe'
  and e.apellido1 = 'Ruiz'
  and e.apellido2 = 'Santana';

/*-|7|- 
Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. 
Ordena el resultado alfabéticamente.
*/

-- SQL 1 (sin join)
select e.*
from empleado e, departamento d
where e.id_departamento = d.id
  and d.nombre = 'I+D'
order by e.apellido1, e.apellido2;

-- SQL 2 (con join)
select e.*
from departamento d 
inner join empleado e on d.id = e.id_departamento
where d.nombre = 'I+D'
order by e.apellido1, e.apellido2;

/*-|8|- 
Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, 
Contabilidad o I+D. Ordena el resultado alfabéticamente.
*/

-- SQL 1 (sin join)
select e.*
from empleado e, departamento d
where e.id_departamento = d.id
  and d.nombre in ('Sistemas','Contabilidad','I+D')
order by e.apellido1, e.apellido2;

-- SQL 2 (con join)
select e.*
from departamento d 
inner join empleado e on d.id = e.id_departamento
where d.nombre in ('Sistemas','Contabilidad','I+D')
order by e.apellido1, e.apellido2;

/*-|9|- 
Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un 
presupuesto entre 100000 y 200000 euros.
*/

-- SQL 1 (sin join)
select e.nombre, e.apellido1
from empleado e, departamento d
where e.id_departamento = d.id
  and d.presupuesto not between 100000 and 200000;

-- SQL 2 (con join)
select e.nombre, e.apellido1 
from departamento d 
inner join empleado e on d.id = e.id_departamento
where d.presupuesto not between 100000 and 200000;

/*-|10|- 
Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo 
apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén 
repetidos.
*/

-- SQL 1 (sin join)
select distinct d.nombre
from empleado e, departamento d
where e.id_departamento = d.id
  and e.apellido2 is null;

-- SQL 2 (con join)
select distinct d.nombre 
from departamento d 
inner join empleado e on d.id = e.id_departamento
where e.apellido2 is null;
