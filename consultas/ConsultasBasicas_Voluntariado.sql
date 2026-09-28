/*-|1|- 
Extranjeros que vienen al FOJE
*/

select v.IdVoluntarios, v.nombre, localidades.localidad, provincias.provincia, 
	paises.pais  
from voluntarios v, localidades, provincias, paises
where (v.idLocalidad  = localidades.idLocalidad) 
	and (localidades.idProvincia = provincias.idProvincia) 
	and (provincias.idPais = paises.idPais)
	and paises.pais = 'Extranjeros';

/*-|2|- 
Personas de fuera de Aragón
*/

select v.IdVoluntarios, v.nombre, localidades.localidad, provincias.provincia  
from voluntarios v, localidades, provincias
where (v.idLocalidad = localidades.idLocalidad) 
	and (localidades.idProvincia = provincias.idProvincia) 
	and not provincias.provincia in ('Zaragoza','Huesca','Teruel');

/*-|3|-
Personas de Jaca
*/

select v.IdVoluntarios, v.nombre, localidades.localidad, provincias.provincia  
from voluntarios v, localidades, provincias
where (v.idLocalidad  = localidades.idLocalidad) 
	and (localidades.idProvincia  = provincias.idProvincia) 
	and localidades.localidad = 'Jaca';

/*-|4|-
Personas que no tengan alojamiento durante el FOJE
*/

select v.IdVoluntarios, v.nombre, v.alojamiento  
from voluntarios v
where v.alojamiento = 'False';

/*-|5|-
Personas entre 25 y 34 años que pesen más de 70Kg y lleven la talla M o L
*/

select v.IdVoluntarios, v.nombre, 
	timestampdiff(year, v.fNacimiento, current_date()) as edad, v.peso, v.talla  
from voluntarios v
where (timestampdiff(year, v.fNacimiento, current_date()) between 25 and 34) 
	and (v.peso > 70)
	and (v.talla = 'M' or v.talla = 'L');
	

/*-|6|-
Personas entre 26 y 40 años de Zaragoza o Personas entre 41 y 55 años de huesca
*/

select v.IdVoluntarios, v.nombre, 
	timestampdiff(year, v.fNacimiento, current_date()) as edad, 
	localidades.localidad, provincias.provincia 
from voluntarios v, localidades, provincias
where (v.idLocalidad  = localidades.idLocalidad) 
	and (localidades.idProvincia  = provincias.idProvincia)
	and (((timestampdiff(year, v.fNacimiento, current_date()) between 26 and 40)
	and provincias.provincia = 'Zaragoza')
	or ((timestampdiff(year, v.fNacimiento, current_date()) between 41 and 55)
	and provincias.provincia = 'Huesca'));

/*-|7|-
Personas mayores a 55 años
*/

select v.IdVoluntarios, v.nombre, 
	timestampdiff(year, v.fNacimiento, current_date()) as edad
from voluntarios v
where timestampdiff(year, v.fNacimiento, current_date()) > 55;
	
/*-|8|-
Personas con una talla XXL y cuya altura sea inferior a 175cm
*/

select v.IdVoluntarios, v.nombre, v.talla, v.altura 
from voluntarios v
where (v.talla = 'XXL') 
	and (v.altura < '175');

/*-|9|-
Personas estudiantes con nivel ALTO en informatica
*/

select v.IdVoluntarios, v.nombre, l.labor, v.nivelInformatica  
from voluntarios v, laboral l 
where (v.idLabor = l.IdLabor)
	and l.labor = 'Estudiante'
	and v.nivelInformatica = 'ALTO';

/*-|10|-
Personas estudiantes con un nivel ALTO en ingles hablado y escrito
*/

select v.IdVoluntarios, v.nombre, l.labor, i.idioma, n.hablado, n.escrito   
from voluntarios v, laboral l, idiomas i, nivel n  
where (v.idLabor = l.IdLabor)
	and (v.IdVoluntarios = n.IdVoluntario)
	and (n.IdIdioma = i.Ididioma)
	and (l.labor = 'Estudiante')
	and (i.idioma = 'Inglés')
	and (n.hablado = 'ALTO')
	and (n.escrito = 'ALTO');

/*-|11|-
Personas jubiladas con un nivel ALTO en frances hablado y escrito o con un nivel
ALTO en inglés hablado y escrito
*/

select v.IdVoluntarios, v.nombre, l.labor, i.idioma, n.hablado, n.escrito   
from voluntarios v, laboral l, idiomas i, nivel n  
where (v.idLabor = l.IdLabor)
	and (v.IdVoluntarios = n.IdVoluntario)
	and (n.IdIdioma = i.Ididioma)
	and (l.labor = 'Jubilado')
	and ((i.idioma = 'Francés') or (i.idioma = 'Inglés'))
	and (n.hablado = 'ALTO')
	and (n.escrito = 'ALTO');


/*-|12|-
Personas que practiquen esquí en cualquiera de sus modalidades
*/

select v.IdVoluntarios, v.nombre, d.deporte  
from voluntarios v, practicar p, deportes d  
where (v.IdVoluntarios = p.IdVoluntarios)
	and (p.IdDeportes = d.IdDeporte)
	and (d.deporte like '%Esquí%');
	
/*-|13|-
Personas que cumplen años hoy
*/

select v.IdVoluntarios, v.nombre, v.fNacimiento, 
	day(v.fNacimiento) as dia, monthname(v.fNacimiento) as mes
from voluntarios v
where month(v.fNacimiento) = month(current_date())
	and day(v.fNacimiento) = day(current_date());
	
/*-|14|-
Personas que cumplen años en el mes de diciembre
*/

select v.IdVoluntarios, v.nombre, v.fNacimiento, monthname(fNacimiento) as mes  
from voluntarios v
where monthname(v.fNacimiento) = 'December';

/*-|15|-
Personas que cumplen años en invierno
*/

select v.IdVoluntarios, v.nombre, v.fNacimiento, monthname(fNacimiento) as mes  
from voluntarios v
where (month(v.fNacimiento) = 12 and day(v.fNacimiento) > 21)
	or (month(v.fNacimiento) = 1)
	or (month(v.fNacimiento) = 2)
	or (month(v.fNacimiento) = 3 and day(v.fNacimiento) < 21);

/*-|16|-
Personas que cumplen años en el primer trimestre del año
*/

select v.IdVoluntarios, v.nombre, v.fNacimiento, monthname(fNacimiento) as mes  
from voluntarios v
where quarter(v.fNacimiento) = 1;

/*-|17|-
Personas que tengan preferencia 1 en tareas de informática o preferencia 1 en tareas
de conducción
*/

select v.IdVoluntarios, v.nombre, t.nombre, p.Preferencia  
from voluntarios v, preferencias p, tareas t
where (v.IdVoluntarios = p.IdVoluntario)
	and (p.IdTarea = t.IdTarea)
	and (p.Preferencia = '1')
	and (t.nombre = 'Informática' or t.nombre = 'Conducción');

/*-|18|-
Personas que tengan preferencia 1 en tareas de interprete y que tengan un nivel
hablado alto en cualquiera de los idiomas
*/

select v.IdVoluntarios, v.nombre, t.nombre, p.Preferencia, i.idioma, n.hablado  
from voluntarios v, preferencias p, tareas t, idiomas i, nivel n      
where (v.IdVoluntarios = p.IdVoluntario)
	and (p.IdTarea = t.IdTarea)
	and (v.IdVoluntarios = n.IdVoluntario)
	and (n.IdIdioma = i.Ididioma)
	and (p.Preferencia = '1')
	and (t.nombre = 'Intérprete')
	and (n.hablado = 'alto');

/*-|19|-
Personas que tengan preferencia 1 en tareas de informatica y tengan un nivel medio o
alto en informatica
*/

select v.IdVoluntarios, v.nombre, t.nombre, p.Preferencia, v.nivelInformatica  
from voluntarios v, preferencias p, tareas t    
where (v.IdVoluntarios = p.IdVoluntario)
	and (p.IdTarea = t.IdTarea)
	and (p.Preferencia = '1')
	and (t.nombre = 'Informática')
	and ((v.nivelInformatica = 'medio') or (v.nivelInformatica = 'alto'));

/*-|20|-
Personas que tengan preferencia 1 en tareas de conducción, tengan un nivel medio o
alto de ingles hablado, sean mayores de 26 años, tengan carnet de conducir B y sean
de Huesca.
*/

select v.IdVoluntarios, v.nombre, t.nombre, pre.Preferencia, i.idioma, n.hablado, 
	timestampdiff(year, v.fNacimiento, current_date()) as edad, v.carnetB, 
	l.localidad, pro.provincia  
from voluntarios v, preferencias pre, tareas t, idiomas i, nivel n, localidades l, 
	provincias pro   
where (v.IdVoluntarios = pre.IdVoluntario)
	and (pre.IdTarea = t.IdTarea)
	and (v.IdVoluntarios = n.IdVoluntario)
	and (n.IdIdioma = i.Ididioma)
	and (v.idLocalidad = l.idLocalidad)	
	and (l.idProvincia = pro.idProvincia)
	and (pre.Preferencia = '1')
	and (t.nombre = 'Conducción')
	and (i.idioma = 'Inglés')
	and ((n.hablado = 'alto') or (n.hablado = 'medio'))
	and (timestampdiff(year, v.fNacimiento, current_date()) > 26)
	and (v.carnetB = 'True')
	and (pro.provincia = 'Huesca');


/*-|21|-
Personas que tengan preferencia 2 en tareas administrativas, tengan un nivel medio o
alto de ingles hablado y sean mayores de 40 años.
*/

select v.IdVoluntarios, v.nombre, t.nombre, p.Preferencia, i.idioma, n.hablado, 
	timestampdiff(year, v.fNacimiento, current_date()) as edad 
from voluntarios v, preferencias p, tareas t, idiomas i, nivel n  
where (v.IdVoluntarios = p.IdVoluntario)
	and (p.IdTarea = t.IdTarea)
	and (v.IdVoluntarios = n.IdVoluntario)
	and (n.IdIdioma = i.Ididioma)
	and (p.Preferencia = '2')
	and (i.idioma = 'Inglés')
	and (t.nombre = 'Administrativas')	
	and ((n.hablado = 'alto') or (n.hablado = 'medio'))
	and (timestampdiff(year, v.fNacimiento, current_date()) > 40);
	
/*-|22|-
Personas cuyo nombre comience por A y que sean de Cataluña
*/

select v.IdVoluntarios, v.nombre, l.localidad, p.provincia  
from voluntarios v, localidades l, provincias p 
where (v.idLocalidad = l.idLocalidad)
	and (l.idProvincia = p.idProvincia)
	and (v.nombre like 'A%')
	and (p.provincia in ('Barcelona','Tarragona','Lleida','Girona'));

/*-|23|-
Personas cuyo codigo postal comience por 2 y termine en 6
*/

select v.IdVoluntarios, v.nombre, vo.Cp  
from voluntarios v, voluntarios_old vo 
where (v.IdVoluntarios = vo.Idvoluntario)
	and (vo.Cp like '2%') 
	and (vo.Cp like '%6');

/*-|24|-
Personas cuya población comience por CAN
*/

select v.IdVoluntarios, v.nombre, l.localidad
from voluntarios v, localidades l
where (v.idLocalidad = l.idLocalidad)
	and (l.localidad like 'CAN%');

/*-|25|-
Personas cuyo nombre comience por cualquiera de las siguientes letras F,G,H,I,J,K,L,M
*/

select v.*
from voluntarios v
where v.nombre rlike '^[F-M]';

/*-|26|-
Personas cuya cuarta letra del nombre tenga una de las siguientes letras P,Q,R,S,T
y además sean aragonesas.
*/

select v.IdVoluntarios, v.nombre, l.localidad, p.provincia   
from voluntarios v, localidades l, provincias p  
where (v.idLocalidad = l.idLocalidad)
	and (l.idProvincia = p.idProvincia)
	and (v.nombre rlike '^...[P-T]')
	and (p.provincia in ('Zaragoza','Huesca','Teruel'));

/*-|27|-
Personas cuyo nombre comience por cualquiera de las siguientes letras
A,B,C,D,E,F,G,H,I,J,K,L sean varones y residan en Galicia
*/

select v.IdVoluntarios, v.nombre, vo.Sexo, l.localidad, p.provincia  
from voluntarios v, voluntarios_old vo, localidades l, provincias p  
where (v.IdVoluntarios = vo.Idvoluntario)
	and (v.idLocalidad = l.idLocalidad)
	and (l.idProvincia = p.idProvincia)
	and (v.nombre rlike '^[A-L]') 
	and (vo.Sexo = 'M')
	and (p.provincia in ('A Coruña','Lugo','Pontevedra','Ourense'));

/*-|28|-
Personas cuyo nombre comience y termine por una vocal
*/

select v.IdVoluntarios, v.nombre  
from voluntarios v
where (v.nombre rlike '^[aeiou]') and (v.nombre rlike '[aeiou]$');

/*-|29|-
Personas cuyo nombre tenga 3 letras o tenga 10 letras
*/

select v.IdVoluntarios, v.nombre  
from voluntarios v
where (v.nombre like '___') or (v.nombre like '__________');

/*-|30|-
Personas en cuya población aparezca la palabra VILLANUEVA
*/

select v.IdVoluntarios, v.nombre, l.localidad  
from voluntarios v, localidades l 
where (v.idLocalidad = l.idLocalidad)
	and (L.localidad like '%VILLANUEVA%');

/*-|31|-
Personas en cuya población aparezca la letra Ñ
*/

select v.IdVoluntarios, v.nombre, l.localidad  
from voluntarios v, localidades l 
where (v.idLocalidad = l.idLocalidad)
	and (l.localidad rlike 'ñ');
	
/*-|32|-
Personas en cuya población aparezca una vocal acentuada
*/

select v.IdVoluntarios, v.nombre, l.localidad  
from voluntarios v, localidades l 
where (v.idLocalidad = l.idLocalidad)
	and (l.localidad rlike '[áéíóú]');
	
/*-|33|-
Seleccionar el campo nombre, otro que contenga las tres primeras posiciones del
nombre, otro que contenga las dos últimas posiciones del nombre.
*/

select v.nombre, 
	left(v.nombre, 3), 
	right(v.nombre, 2)
from voluntarios v;
	
/*-|34|-
Seleccionar el campo nombre, población, otro que contenga las posiciones 2 y 3 del
nombre, y otro que contenga la posición primera y última de la población.
*/

select v.nombre, vo.Poblacion, mid(v.nombre, 2, 2),
	concat(left(vo.Poblacion, 1), right(vo.Poblacion, 1)) 
from voluntarios v, voluntarios_old vo 
where v.IdVoluntarios = vo.Idvoluntario;
	
/*-|35|-
Seleccionar el campo nombre, población, otro al que llamaremos usuario, que
contenga las tres primeras posiciones del nombre junto con las tres ultimas posiciones
de la población y el idvoluntario y otro al que llamaremos clave que contenga los
dígitos 3 y 4 del codigo postal junto con el idvoluntario y el mes de nacimiento.
*/

select v.nombre, vo.Poblacion, 
	concat(left(v.nombre, 3), right(vo.Poblacion, 3), v.IdVoluntarios) as usuario,
	concat(mid(vo.Cp, 3, 2), v.IdVoluntarios, month(v.fNacimiento)) as clave
from voluntarios v, voluntarios_old vo 
where v.IdVoluntarios = vo.Idvoluntario;
	
/*-|36|-
Seleccionar el campo nombre y otro llamado Dias Vividos donde muestre la diferencia
de dias entre la fecha actual y la de su nacimiento.
*/

select v.nombre, timestampdiff(day, v.fNacimiento, current_date()) as Dias_Vividos	
from voluntarios v;

/*-|37|-
Seleccionar el campo de nombre, fecha, otro llamado Dia Nacimiento en el que se
muestre el día de la semana en el que nació, otro llamado Trimestre en el que se
muestre el trimestre correspondiente a la fecha de nacimiento.
*/

select v.nombre, v.fNacimiento, dayname(v.fNacimiento) as Dia_Nacimiento,
	quarter(v.fNacimiento) as Trimestre 
from voluntarios v;

/*-|38|-
Seleccionar el campo de nombre, provincia y otro al que llamaremos comunidad y el
cual llevará ARAGONES si la persona reside en cualquier provincia de Aragón,
ANDALUZ si reside en cualquier provincia de Andalucía y guiones (--------) en caso
contrario.
*/

select v.nombre, p.provincia,
	case
		when p.provincia in ('Zaragoza','Huesca','Teruel') 
			then 'ARAGONÉS'
		when p.provincia in ('Sevilla','Córdoba','Málaga','Almería','Granada','Huelva','Cádiz','Jaén') 
			then 'ANDALUZ'
		else '--------'
	end as comunidad
from voluntarios v, localidades l, provincias p 
where (v.idLocalidad = l.idLocalidad)
	and (l.idProvincia = p.idProvincia);

/*-|39|-
Selecciona el campo de nombre, fecha, edad y prepara un campo llamado Edad
Exacta que contenga la edad exacta de la persona.
*/

select v.nombre, v.fNacimiento,
	timestampdiff(year, v.fNacimiento, current_date()) as Edad,
	datediff(now(),v.fNacimiento)/365.25 as Edad_exacta
from voluntarios v, voluntarios_old vo 
where v.IdVoluntarios = vo.Idvoluntario;


