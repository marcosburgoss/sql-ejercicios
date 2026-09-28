/*-|60|- 
Mostrar voluntarios de la provincia de Madrid cuya edad supere la media de
edades de los voluntarios de Zaragoza.
*/

select v.nombre, p.provincia, timestampdiff(year, v.fNacimiento, now()) as edad
from voluntarios v, localidades l, provincias p  
where v.idLocalidad = l.idLocalidad 
	and l.idProvincia = p.idProvincia 
	and p.provincia = 'Madrid'
	and	timestampdiff(year, v.fNacimiento, now()) > (
		select avg(timestampdiff(year, v2.fNacimiento, now()))
		from voluntarios v2, localidades l2, provincias p2
		where v2.idLocalidad = l2.idLocalidad 
			and l2.idProvincia = p2.idProvincia 
			and p2.provincia = 'Zaragoza'
	);

/*-|61|- 
Mostrar voluntarios y edad que superen a todas las edades de los voluntarios
de la provincia de Madrid.
*/

select v.nombre, timestampdiff(year, v.fNacimiento, now()) as edad
from voluntarios v 
where timestampdiff(year, v.fNacimiento, now()) > all (
	select timestampdiff(year, v2.fNacimiento, now())
	from voluntarios v2, localidades l, provincias p 
	where v2.idLocalidad = l.idLocalidad
		and l.idProvincia = p.idProvincia
		and p.provincia = 'Madrid'
);
	

/*-|62|- 
Mostrar voluntarios y altura, que superen el peso más alto de los voluntarios de
Barcelona.
*/

select v.nombre, v.altura
from voluntarios v 
where v.peso > (
	select max(v2.peso) 
	from voluntarios v2, localidades l, provincias p  
	where v2.idLocalidad = l.idLocalidad
		and l.idProvincia = p.idProvincia
		and p.provincia = 'Barcelona'
);
	
/*-|63|- 
Mostrar voluntarios y altura cuyo altura sea inferior a cualquier altura de los
voluntarios de Burgos.
*/

select v.nombre, v.altura 
from voluntarios v 
where v.altura < all (
	select v2.altura -- tambien funciona con 'MIN(v2.altura)' en vez de 'ALL'
	from voluntarios v2, localidades l, provincias p  
	where v2.idLocalidad = l.idLocalidad
		and l.idProvincia = p.idProvincia
		and p.provincia = 'Burgos'
);

SELECT v.nombre, v.altura
FROM voluntarios v
WHERE v.altura < (
    SELECT min(v2.altura)
    FROM voluntarios v2
    JOIN localidades l ON v2.idLocalidad = l.idLocalidad
    JOIN provincias p ON l.idProvincia = p.idProvincia
    WHERE p.provincia = 'Burgos'
);

/*-|64|- 
Mostrar nombre de voluntarios y altura cuya altura coincida con alturas de
voluntarios de Valencia.
*/
	
select v.nombre, v.altura
from voluntarios v 
where v.altura in (
	select v2.altura 
	from voluntarios v2, localidades l, provincias p
	where v2.idLocalidad = l.idLocalidad
		and l.idProvincia = p.idProvincia
		and p.provincia = 'Valencia/València'
);
