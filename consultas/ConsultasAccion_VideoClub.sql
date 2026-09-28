/*-|41|- 
Borrar todos los registros de clientes que residan fuera de Zaragoza.
*/

delete from clientes where CIUDAD != 'Zaragoza';

/*-|42|- 
Borrar todos los registros de Peliculas cuyo precio sea inferior a 15 €.
*/

delete from peliculas where PRECIO < 15;

/*-|43|- 
Borrar todos los registros de películas que empiecen por H.
*/

delete from peliculas where TITULO like 'H%';

/*-|44|- 
Borrar todos los registros de películas cuya modalidad sea ESTRENO
*/

delete from peliculas where TIPOPELICULA in (
	select p.TIPOPELICULA 
	from peliculas p, tipopeliculas t
	where p.TIPOPELICULA = t.CODIGOENTREGA 
		and t.MODALIDAD = 'ESTRENO'
);	

/*-|45|- 
Borrar todos los registros de películas del género de TERROR
*/

delete from peliculas where GENERO in (
	select p.GENERO 
	from peliculas p, generos g
	where p.GENERO = g.CODIGOGENERO 
		and g.NOMBREGENERO = 'TERROR'
);

/*-|46|- 
Borrar todos los registros de películas cuyo género sea AVENTURAS y hayan sido
adquiridas en el año 98
*/

delete from peliculas where GENERO in (
	select p.GENERO 
	from peliculas p, generos g
	where p.GENERO = g.CODIGOGENERO 
		and g.NOMBREGENERO = 'AVENTURAS'
)and CODIGOPELICULA in ( 
	select p.CODIGOPELICULA 
	from peliculas p, alquileres a
	where p.CODIGOPELICULA = a.CODIGOPELICULA 
		and year(a.FECHADESCARGA) = 1998
);
	
/*-|47|- 
Añadir un registro nuevo en Generos cuyo numero sea 14 y se denomine DOCUMENTAL
*/

insert into generos 
values (14, 'DOCUMENTAL');
	
/*-|48|- 
Añadir un registro nuevo en la tabla de clientes cuya información corresponda a
vuestros datos personales.
*/

insert into clientes 
values (21,'Marcos','Burgos','Lopez','25360099T','C/ Pedro IV, 10, 9ºC','Zaragoza',50009,'Zaragoza',638128495,2020-06-21,'')

/*-|49|- 
Crear una tabla vacía (llamada CopiaGeneros) con los mismos campos de la tabla de
Generos. Traspasar toda la información de Generos a CopiaGeneros.
*/

create table CopiaGeneros like generos;
insert into CopiaGeneros 
select * from generos;

/*-|50|- 
Eliminar los registros de la tabla de CopiaGeneros cuyo nombre comience por C
*/

delete from copiageneros where NOMBREGENERO like 'C%';

/*-|51|- 
Añadir a la tabla CopiaGeneros los registros de Generos cuyo nombre comience por C
*/

insert into copiageneros 
select * from generos where NOMBREGENERO like 'C%';

/*-|52|- 
Crear una tabla vacía (llamada Infantiles) con los mismos campos de la tabla de Peliculas. 
Traspasar todos los registros de la tabla Peliculas a la tabla Infantiles, que tengan como 
genero Infantil, Aventuras, Ciencia-ficción
*/

create table Infantiles like peliculas;
insert into Infantiles
select p.* 
from peliculas p, generos g 
where p.GENERO = g.CODIGOGENERO 
	and g.NOMBREGENERO in ('Infantil','Aventuras','Ciencia-Ficción');
	
-- otra forma de hacerlo
create table Infantiles as 
select p.* 
from peliculas p, generos g 
where p.GENERO = g.CODIGOGENERO 
	and g.NOMBREGENERO in ('Infantil','Aventuras','Ciencia-Ficción');

/*-|53|- 
Dividir la tabla de clientes en dos tablas llamadas Capital y Provincias con la misma
estructura, en la primera guardaremos todos los registros de clientes que sean de Zaragoza 
y en Provincias el resto.
*/

create table Capital like clientes;
insert into Capital
select * from clientes where CIUDAD = 'Zaragoza';

create table Provincias like clientes;
insert into Provincias
select * from clientes where CIUDAD != 'Zaragoza';


/*-|54|- 
Modificar el campo de Codigo Postal de la tabla de clientes para que a todos les
aparezca 50900
*/

update clientes 
set codigopostal = '50900'; 

/*-|55|- 
Modificar el campo de Observaciones de la tabla de clientes para que a todos les
ponga un CODIGO formado por 3 caracteres de la izda del nombre + los 2 ultimos del 
2 apellido+ 3 digitos centrales del telefono
*/

update clientes 
set OBSERVACIONES = concat(
	left(NOMBRECLIENTE,3),
	right(APELLIDO1CLIENTE,2),
	mid(TELEFONO,4,3) 
);

/*-|56|- 
Modificar el campo de Observaciones de la tabla de clientes para que a todos los que
se dieron de alta en el mes de Abril del 99 les aparezca el mensaje de BONIFICADO
*/

update clientes 
set OBSERVACIONES = 'BONIFICADO'
where monthname(FECHALTA) = 'April'
	and year(FECHALTA) = '1999'; 

/*-|57|- 
Modificar el campo de Ciudad de la tabla de clientes para que todos los que residan
en Zaragoza les aparezca la ciudad en mayúsculas.
*/

update clientes 
set CIUDAD = upper(CIUDAD) 
where CIUDAD = 'Zaragoza';
	
/*-|58|- 
Modificar el título de películas para que en todas que empiecen por R les aparezca -----
*/

update peliculas 
set TITULO = '-----'
where TITULO like 'R%';

/*-|59|- 
Incrementar el precio de cada película un cinco por ciento.
*/

update peliculas 
set PRECIO = PRECIO + (PRECIO * 0.05) ;

/*-|60|- 
Acentuar el apellido de López en la tabla de Clientes.
*/

update clientes 
set APELLIDO1CLIENTE = 'López'
where APELLIDO1CLIENTE = 'Lopez';