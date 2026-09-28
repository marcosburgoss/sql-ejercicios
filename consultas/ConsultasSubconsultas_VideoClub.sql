/*-|36|- 
Selecciona el Titulo y el Precio de las películas cuyo precio supere al precio medio de
todas las películas.
*/

select p.TITULO, p.PRECIO  
from peliculas p 
where p.PRECIO > (
	select avg(p2.PRECIO)
	from peliculas p2
);
				
/*-|37|- 
Selecciona el Titulo de las películas que nunca han sido alquiladas.
*/
				
select p.TITULO 
from peliculas p
where p.CODIGOPELICULA not in (
	select a.CODIGOPELICULA 
	from alquileres a
);

SELECT  p.TITULO
FROM peliculas p
LEFT JOIN alquileres a
ON p.CODIGOPELICULA = a.CODIGOPELICULA
WHERE a.CODIGOPELICULA is null;
				
/*-|38|- 
Selecciona el Titulo de aquellas películas que superen el precio mas bajo de las películas
del género Terror
*/

select p.TITULO, p.PRECIO  
from peliculas p 
where p.PRECIO > (
	select min(p2.PRECIO)
	from peliculas p2, generos g
	where p2.GENERO = g.CODIGOGENERO
		and g.NOMBREGENERO = 'Terror'
);

/*-|39|- 
Seleccionar el Titulo de las películas que tengan como inicial una letra diferente a las
iniciales de las películas del género comedia.
*/
	
select p.TITULO 
from peliculas p 
where left(p.TITULO, 1) not in (
	select left(p2.TITULO, 1)
	from peliculas p2, generos g 
	where p2.GENERO = g.CODIGOGENERO 
		and g.NOMBREGENERO = 'Comedia'
);

/*-|40|- 
Seleccionar el Título de las películas que contengan las letras 'el' o que hayan sido
alquiladas por personas cuyo nombre contenga las letras 'el'
*/

select p.TITULO
from peliculas p 
where p.TITULO like '%el%' or p.TITULO in (
	select p2.TITULO 
	from peliculas p2, alquileres a, clientes c 
	where p2.CODIGOPELICULA = a.CODIGOPELICULA 
		and a.CODIGOCLIENTE = c.CODIGOCLIENTE 
		and c.NOMBRECLIENTE like '%el%'
);
		
	
	