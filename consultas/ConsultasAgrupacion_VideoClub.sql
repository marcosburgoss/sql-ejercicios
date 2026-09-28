/*-|21|- 
Realiza una consulta que nos agrupe las películas por género.
*/

select p.GENERO, p.TITULO, g.NOMBREGENERO  
from peliculas p, generos g 
where (p.GENERO = g.CODIGOGENERO)
group by p.GENERO, p.TITULO, g.NOMBREGENERO;  

/*-|22|- 
Realiza una consulta que nos muestre cuantas películas existen de cada género. (Mostrar
como título de columna TOTAL PELICULAS)
*/

select p.GENERO, g.NOMBREGENERO, count(p.TITULO) as TOTAL_PELICULAS  
from peliculas p, generos g  
where p.GENERO = g.CODIGOGENERO 
group by P.GENERO, g.NOMBREGENERO;

/*-|23|-
Realiza una consulta que nos muestre cuantas películas existen de cada género y nos
muestre aquellos que superen 10 películas (Mostrar como título de columna TOTAL
PELICULAS)
*/

select p.GENERO, g.NOMBREGENERO, count(p.TITULO) as TOTAL_PELICULAS  
from peliculas p, generos g  
where (p.GENERO = g.CODIGOGENERO)
group by p.GENERO, g.NOMBREGENERO
having TOTAL_PELICULAS > 10;

/*-|24|-
Realiza una consulta que nos muestre cuantas películas existen de los géneros INFANTIL
y MUSICAL. (Mostrar como título de columna TOTAL PELICULAS)
*/

select p.GENERO, g.NOMBREGENERO, count(p.TITULO) as TOTAL_PELICULAS  
from peliculas p, generos g  
where (p.GENERO = g.CODIGOGENERO)
	and (g.NOMBREGENERO = 'Infantil' or g.NOMBREGENERO = 'Musical')
group by p.GENERO, g.NOMBREGENERO;

/*-|25|-
Realiza una consulta que nos agrupe las películas por fecha de publicación.
*/

select p.TITULO, p.FECHAPUBLICACION 
from peliculas p
group by p.FECHAPUBLICACION, p.CODIGOPELICULA, p.TITULO;

/*-|26|-
Realiza una consulta que nos muestre cuantas películas existen de cada fecha de
publicación. (Mostrar como título de columna TOTAL PELICULAS)
*/

select count(p.TITULO) as TOTAL_PELICULAS, p.FECHAPUBLICACION 
from peliculas p
group by p.FECHAPUBLICACION;

/*-|27|-
Realiza una consulta que nos muestre cuantas películas existen de cada fecha de
publicación mostrando sólo aquellas fechas que tengan 1 película. (Mostrar como título de
columna TOTAL PELICULAS)
*/

select count(p.TITULO) as TOTAL_PELICULAS, p.FECHAPUBLICACION 
from peliculas p
group by p.FECHAPUBLICACION 
having TOTAL_PELICULAS = 1;

/*-|28|-
Realiza una consulta que nos agrupe las películas por genero y fecha de publicación.
*/

select p.TITULO, g.NOMBREGENERO, p.FECHAPUBLICACION  
from peliculas p, generos g 
where (p.GENERO = g.CODIGOGENERO)
group by g.NOMBREGENERO, p.FECHAPUBLICACION, p.TITULO;

/*-|29|-
Realiza una consulta que nos muestre cuantas películas existen de cada género y fecha
de publicación. (Mostrar como título de columna TOTAL PELICULAS)
*/

select count(p.TITULO) as TOTAL_PELICULAS, g.NOMBREGENERO, p.FECHAPUBLICACION  
from peliculas p, generos g 
where (p.GENERO = g.CODIGOGENERO)
group by g.NOMBREGENERO, p.FECHAPUBLICACION;

/*-|30|-
Añadir a la consulta anterior, la suma del precio. (Mostrar como título de columna 
TOTAL)
*/

select count(p.TITULO) as TOTAL_PELICULAS, g.NOMBREGENERO, p.FECHAPUBLICACION, 
	sum(p.PRECIO) as TOTAL_PRECIO
from peliculas p, generos g
where (p.GENERO = g.CODIGOGENERO)
group by g.NOMBREGENERO, p.FECHAPUBLICACION;

/*-|31|-
Realiza una consulta que nos muestre el sumatorio de los precios de las películas
publicadas en el año 2017 y al lado el sumatorio de los precios con un incremento 
del 21% de IVA . (Mostrar como título de columnas TOTAL AÑO 2017 y TOTAL AÑO 2017 
con IVA)
*/

select sum(p.PRECIO) as TOTAL_AÑO_2017, 
	sum(p.PRECIO + p.PRECIO * 0.21) as TOTAL_AÑO_2017_IVA, 
	year(p.FECHAPUBLICACION) as año
from peliculas p
where year(p.FECHAPUBLICACION) = '2017';

/*-|32|-
Realiza una consulta que nos muestre por cada fecha de publicación, el promedio de los
precios de las películas. (Mostrar como título de columna PROMEDIO)
*/

select round(avg(p.PRECIO),2) as PROMEDIO, p.FECHAPUBLICACION
from peliculas p
group by p.FECHAPUBLICACION;

/*-|33|-
Realiza una consulta que nos muestre de cada tipo de película la primera y la última 
fecha de publicación.
*/

select count(p.TITULO) as TOTAL_PELICULAS, t.MODALIDAD,
	min(p.FECHAPUBLICACION) as PRIMERA,
	max(P.FECHAPUBLICACION) as ULTIMA
from peliculas p, tipopeliculas t 
where p.TIPOPELICULA = t.CODIGOENTREGA
group by p.TIPOPELICULA;

/*-|34|-
Realiza una consulta que nos muestre por cada género, el precio más barato, el precio
más caro y el promedio de precios de las películas.
*/

select g.NOMBREGENERO,
	min(p.PRECIO) as MAS_BARATO,
	max(p.PRECIO) as MAS_CARO,
	round(avg(p.PRECIO),2) as PROMEDIO
from peliculas p, generos g  
where (p.GENERO = g.CODIGOGENERO) 
group by g.NOMBREGENERO;



