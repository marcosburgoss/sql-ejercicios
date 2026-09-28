/*-|1|- 
Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION de todas las 
películas, ordenado descendentemente por el Título.
*/

select p.TITULO, p.FECHAPUBLICACION 
from peliculas p
order by p.TITULO desc;

/*-|2|- 
Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION y Género de 
todas las películas, ordenando ascendentemente por FECHAPUBLICACION y descendentemente 
por Género.
*/

select p.TITULO, p.FECHAPUBLICACION, p.GENERO 
from peliculas p
order by p.FECHAPUBLICACION asc, p.GENERO desc; 

/*-|3|-
Realiza una consulta que nos muestre los campos Título, FECHAPUBLICACION, Género y 
Tipo de todas las películas, ordenando ascendentemente por Tipo y Título.
*/

select p.TITULO, p.FECHAPUBLICACION, p.GENERO, p.TIPOPELICULA
from peliculas p 
order by p.TIPOPELICULA, p.TITULO; 

/*-|4|-
Realiza una consulta que nos muestre el Título y Género de las 7 últimas películas 
(en orden alfabético) del género Comedia.
*/

select p.TITULO, g.NOMBREGENERO 
from peliculas p, generos g 
where (g.CODIGOGENERO = p.GENERO) 
	and g.NOMBREGENERO = 'Comedia'
order by p.TITULO desc limit 7; 

/*-|5|-
Realiza una consulta que nos muestre todos los campos de las películas cuyo género sea
Drama o Comedia, ordenadas por genero.
*/

select p.*
from peliculas p, generos g
where (g.CODIGOGENERO = p.GENERO) 
	and (g.NOMBREGENERO = 'Drama' or g.NOMBREGENERO = 'Comedia')
order by g.NOMBREGENERO; 

/*-|6|-
Realiza una consulta que nos muestre todos los campos de las películas cuyo precio 
esté entre 15 y 16, ordenadas por título.
*/

select p.*
from peliculas p
where p.PRECIO between 15 and 16
order by p.TITULO; 

/*-|7|-
Realiza una consulta que nos muestre todos los campos de las películas PUBLICADAS en 
el año 2017.
*/

select p.*
from peliculas p
where year(p.FECHAPUBLICACION) = 2017;

/*-|8|-
Realiza una consulta que nos muestre todos los campos de las películas PUBLICADAS en 
el mes de marzo del año 2017.
*/

select p.*
from peliculas p
where year(p.FECHAPUBLICACION) = 2017 
	and monthname(p.FECHAPUBLICACION) = 'March';

/*-|9|-
Realiza una consulta que nos muestre el Título de la película y al lado una columna 
donde aparezca 'Para niños' si el género es INFANTIL, o que aparezca 'Para adultos' 
en caso contrario. (El título de la nueva columna se llamará RECOMENDADA).
*/

select p.TITULO, 
	if(g.NOMBREGENERO = 'Infantil', 'Para niños', 'Para adultos') as RECOMENDADA
from peliculas p, generos g 
where (p.GENERO = g.CODIGOGENERO);

/*-|10|-
Realiza una consulta que nos muestre los Títulos de películas que empiezan por M o P.
*/

select p.TITULO 
from peliculas p
where (p.TITULO like 'M%') or (p.TITULO like 'P%');

/*-|11|-
Realiza una consulta que nos muestre los Títulos de películas que acaben en la letra S.
*/

select p.TITULO 
from peliculas p
where p.TITULO like '%S'; 

/*-|12|-
Realiza una consulta que nos muestre los Títulos de películas que contengan la palabra
AMOR.
*/

select p.TITULO 
from peliculas p
where p.TITULO like '%AMOR%'; 

/*-|13|-
Realiza una consulta que nos muestre los Títulos y Géneros de películas que tengan 4
caracteres en su título.
*/

select p.TITULO, p.GENERO  
from peliculas p
where p.TITULO like '____';

/*-|14|-
Realiza una consulta que nos muestre los Títulos y Géneros de películas que tengan 4
caracteres en su título y sean de género Acción.
*/

select p.TITULO, g.NOMBREGENERO  
from peliculas p, generos g 
where (p.GENERO = g.CODIGOGENERO) 
	and (p.TITULO like '____') 
	and (g.NOMBREGENERO = 'Acción');

/*-|15|-
Realiza una consulta que nos muestre los Títulos de películas que tengan por lo menos 
un carácter numérico.
*/

select p.TITULO
from peliculas p
where p.TITULO rlike '[0-9]+';

/*-|16|-
Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las 
películas que empiezan por alguno de los siguientes caracteres: C,D,E,F,G,H
*/

select p.TITULO, p.FECHAPUBLICACION 
from peliculas p
where p.TITULO rlike '^[C-H]';

/*-|17|-
Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las 
películas que empiezan por alguno de los siguientes caracteres: 
C,D,E,F,G,H,P,Q,R,S,T,U,V
*/

select p.TITULO, p.FECHAPUBLICACION 
from peliculas p
where p.TITULO rlike '^[C-H,P-V]';

/*-|18|-
Realiza una consulta que nos muestre los Títulos y la fecha de publicación de las 
películas que no terminen por alguno de los siguientes caracteres: I,J,K,L,M,N,O,P
*/

select p.TITULO, p.FECHAPUBLICACION 
from peliculas p
where p.TITULO rlike '[^I-P]$';

/*-|19|-
Realiza una consulta que muestre los Títulos de películas que no contengan la letra a.
*/

select p.TITULO 
from peliculas p
where p.TITULO not like '%a%'; 

/*-|20|-
Realiza una consulta que nos muestre los Títulos y el género de las películas cuyo 
género sea TERROR, COMEDIA, INFANTIL ordenadas ascendentemente por el título.
*/

select p.TITULO, g.NOMBREGENERO 
from peliculas p, generos g
where (g.CODIGOGENERO = p.GENERO) 
	and g.NOMBREGENERO in ('Terror', 'Comedia', 'Infantil')
order by p.TITULO; 
