/*-|1|- 
Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con 
los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos 
fabricantes que no tienen productos asociados.
*/

select f.nombre as fabricante, p.*
from producto p 
right join fabricante f on p.id_fabricante = f.id;

/*-|2|- 
Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún 
producto asociado.
*/

select f.nombre
from producto p 
right join fabricante f on p.id_fabricante = f.id
where p.id is null;

/*-|3|- 
¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.
*/
-- Sería raro pero sí, puede ocurrir, ya sea por fallo al no asociarle un fabricante o que
-- sea de un fabricante que no aparezca en el registro porque ya no existe ese fabricante 
-- o porque no es muy conocido... o simplemente no tiene un fabricante.



