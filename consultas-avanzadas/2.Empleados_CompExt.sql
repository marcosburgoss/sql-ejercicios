/*-|1|- 
Devuelve un listado con todos los empleados junto con los datos de los departamentos 
donde trabajan. Este listado también debe incluir los empleados que no tienen ningún 
departamento asociado.
*/

select e.nombre, e.apellido1, d.* 
from departamento d 
right join empleado e on d.id = e.id_departamento;

/*-|2|- 
Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún 
departamento asociado.
*/

select e.*
from departamento d 
right join empleado e on d.id = e.id_departamento
where e.id_departamento is null;

/*-|3|- 
Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún 
empleado asociado.
*/

select d.*
from departamento d 
left join empleado e on d.id = e.id_departamento
where e.id_departamento is null;

/*-|4|- 
Devuelve un listado con todos los empleados junto con los datos de los departamentos 
donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento 
asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado 
alfabéticamente por el nombre del departamento.
*/

select e.nombre, e.apellido1, d.nombre as departamento
from departamento d 
right join empleado e on d.id = e.id_departamento
union 
select e2.nombre, e2.apellido1, d2.nombre as departamento
from departamento d2 
left join empleado e2 on d2.id = e2.id_departamento
order by departamento;

/*-|5|- 
Devuelve un listado con los empleados que no tienen ningún departamento asociado y los 
departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente 
por el nombre del departamento.
*/

select e.nombre, e.apellido1, d.nombre as departamento
from departamento d 
right join empleado e on d.id = e.id_departamento
where e.id_departamento is null
union 
select e2.nombre, e2.apellido1, d2.nombre as departamento
from departamento d2 
left join empleado e2 on d2.id = e2.id_departamento
where e2.id_departamento is null
order by departamento;

