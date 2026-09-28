/*-|65|- 
Modificar el campo de sexo para que aparezca H de Hombre dónde actualmente aparece V.
*/

update voluntarios_old 
set Sexo = 'H'
where Sexo = 'V';

/*-|66|- 
Modificar la provincia para que aparezca La Rioja dónde actualmente aparece Logroño.
*/

update voluntarios_old 
set Provincia = 'La Rioja'
where Provincia = 'Logroño';

/*-|67|- 
Modificar el campo de laboral para que en todos quede sin información.
*/

update voluntarios_old 
set Laboral = '';

/*-|68|- 
Modificar el campo LABORAL y Deporte para que el contenido aparezca en mayúsculas.
*/

update voluntarios_old 
set Laboral = upper(Laboral);

update voluntarios_old 
set Deporte = upper(Deporte);


/*-|69|- 
Modificar el campo de Edad para que aparezca a edad exacta de la persona a fecha 13/12/1990.
*/

update voluntarios_old 
set Edad = timestampdiff(year,FechaNacimiento,'1990-12-13'); 

/*-|70|- 
Seleccionar el campo de pais mostrando solo aquellos diferentes. Crear la tabla de paises 
con los registros seleccionados. (Voluntarios_OLD)
*/

create table paises_old as (
	select distinct Pais 
	from voluntarios_old
);

/*-|71|- 
Seleccionar el campo de pais y provincia mostrando sólo aquellas provincias de España 
(las provincias no tienen que repetirse). Crear una tabla de provincias con los registros 
seleccionados. Añadir a esta tabla el resto de provincias que no sean de España.
*/

create table provincias_old as (
	select distinct Provincia, Pais
	from voluntarios_old 
	where Pais = 'España'
);

insert into provincias_old
select distinct Provincia, Pais
from voluntarios_old 
where Pais != 'España';
	
/*-|72|- 
Seleccionar el campo de provincia y población mostrando solo aquellas poblaciones 
diferentes. Crear la tabla de poblaciones con los registros seleccionados.
*/

create table poblaciones_old as (
	select distinct Poblacion, Provincia 
	from voluntarios_old
);

/*-|73|- 
Asignar la tarea de Administrativo a: 15 personas con conocimientos de ingles ESCRITO o 
francés ESCRITO Medios o Altos, con nivel medio o alto de informática
*/

insert into preferencias
select v.IdVoluntarios, (
	select distinct p.IdTarea  
	from preferencias p, tareas t
	where p.IdTarea = t.IdTarea
		and t.nombre = 'Administrativas'), 1
from voluntarios v, idiomas i, nivel n
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and n.escrito in ('Medio', 'Alto')
	and i.idioma in ('Francés', 'Inglés')
	and v.nivelInformatica in ('Medio', 'Alto')
limit 15;

/*-|74|- 
Asignar la tarea de Traducción /Interprete a:
	a. 	39 personas que tengan nivel Alto de inglés HABLADO.
	b. 	10 personas que tengan nivel Alto de francés HABLADO.
	c. 	2 personas que tengan nivel Alto de alemán HABLADO.
	d. 	2 personas que tengan nivel Alto de italiano HABLADO
*/

-- a.
insert into preferencias
select v.IdVoluntarios, (
	select distinct p.IdTarea 
	from preferencias p, tareas t
	where p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	), 1 
from voluntarios v, idiomas i, nivel n
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and n.hablado = 'Alto'
	and i.idioma = 'Inglés'
limit 39;

-- b.
insert into preferencias
select v.IdVoluntarios, (
	select distinct p.IdTarea 
	from preferencias p, tareas t
	where p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	), 1
from voluntarios v, idiomas i, nivel n
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and n.hablado = 'Alto'
	and i.idioma = 'Francés'
limit 10;

-- c.
insert into preferencias
select v.IdVoluntarios, (
	select distinct p.IdTarea 
	from preferencias p, tareas t
	where p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	), 1
from voluntarios v, idiomas i, nivel n
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and n.hablado = 'Alto'
	and i.idioma = 'Alemán'
limit 2;

-- d.
insert into preferencias
select v.IdVoluntarios, (
	select distinct p.IdTarea 
	from preferencias p, tareas t
	where p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	), 1 
from voluntarios v, idiomas i, nivel n
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and n.hablado = 'Alto'
	and i.idioma = 'Italiano'
limit 2;


/*
Realizar la siguiente consulta para poder realizar las sql a continuación
indicadas
ALTER TABLE voluntariado.voluntarios ADD Puesto VARCHAR(20) NULL;
ALTER TABLE voluntariado.Voluntarios_OLD ADD Puesto VARCHAR(20) NULL;
*/

alter table voluntariado.voluntarios add Puesto VARCHAR(20) null;
alter table voluntariado.voluntarios_old add Puesto VARCHAR(20) null;

/*-|75|- 
Asignar en la tabla voluntarios la columna puesto con el valor “Informática” a: 15 personas 
con nivel alto de informática y hayan elegido Tareas Informática con preferencia 1 o 2.
*/

update voluntarios 
set Puesto = 'Informática'
where IdVoluntarios in (
	select v.IdVoluntarios 
	from voluntarios v, preferencias p, tareas t 
	where v.IdVoluntarios = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and v.nivelInformatica = 'Alto'
		and t.nombre = 'Informática'
		and p.Preferencia in ('1','2') 
	) and Puesto is null
limit 15;

/*-|76|- 
Asignar en la tabla voluntarios la columna Puesto con el valor “Protocolo” a: 20 personas
que hayan elegido Tareas Protocolo con preferencia 1 o 2, tengan nivel medio escrito de 
cualquier idioma.
*/

update voluntarios 
set Puesto = 'Protocolo'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo, nivel n 
	where vo.Idvoluntario = n.IdVoluntario 
		and vo.TareasProtocolo in ('1','2')
		and n.escrito = 'Medio'
	) and Puesto is null
limit 20;


/*-|77|- 
Asignar en la tabla voluntarios la columna puesto con el valor “Conducción” a:
	a. 	10 personas con carnet de conducir tipo C.
	b. 	60 personas con carnet de conducir tipo B que tengan nivel hablado bajo o medio de 
		algún idioma y que preferiblemente sean de Jaca o Huesca o Zaragoza.
*/

-- a.
update voluntarios 
set Puesto = 'Conducción'
where carnetC = 'true' 
	and Puesto is null
limit 10;

-- b.
update voluntarios 
set Puesto = 'Conducción'
where IdVoluntarios in (
	select v.IdVoluntarios 
	from voluntarios v, nivel n, localidades l
	where v.IdVoluntarios = n.IdVoluntario  
		and v.idLocalidad = l.idLocalidad 
		and v.carnetB = 'true'
		and n.hablado in ('Bajo','Medio')
		and l.localidad in ('Jaca','Huesca','Zaragoza')
	) and Puesto is null
limit 60;


/*-|78|- 
Asignar en la tabla voluntarios la columna puesto el valor “Sanitario” a: 30 personas, 
que hayan elegido Tareas Sanitarias con preferencia 1 o 2 y preferiblemente tengan la 
situación laboral de trabajadores en caso contrario de estudiante.
*/

update voluntarios 
set Puesto = 'Sanitario'
where IdVoluntarios in (
	select vo.Idvoluntario  
	from voluntarios_old vo
	where vo.TareasSanitaria in ('1','2')
	order by case vo.Laboral 
		when 'Trabajador' then 1
		when 'Estudiante' then 2
		else 3
	end 
	) and Puesto is null
limit 30;

/*-|79|- 
Asignar en la tabla voluntarios la columna puesto el valor “Comunicación” a: 30 personas 
que hayan elegido Tareas Comunicación con preferencia 1 ó 2
*/

update voluntarios 
set Puesto = 'Comunicación'
where IdVoluntarios in (
	select vo.Idvoluntario  
	from voluntarios_old vo
	where vo.TareasComunicacion in ('1','2')
	) and Puesto is null
limit 30;

/*-|80|- 
Asignar en la tabla voluntarios la columna puesto el valor “Acompañante” a: 20 personas 
que hayan elegido Tareas Acompañante con preferencia 1 ó 2 ó 3
*/

update voluntarios 
set Puesto = 'Acompañante'
where IdVoluntarios in (
	select vo.Idvoluntario  
	from voluntarios_old vo
	where vo.TareasAcompañantes in ('1','2','3')
	) and Puesto is null
limit 20;

/*-|81|- 
Asignar en la tabla voluntarios la columna puesto el valor “Logística” a: 30 personas 
que hayan elegido Tareas Logistica con preferencia 1 ó 2 ó 3 ó 4
*/

update voluntarios 
set Puesto = 'Logística'
where IdVoluntarios in (
	select vo.Idvoluntario  
	from voluntarios_old vo
	where vo.TareasLogistico in ('1','2','3','4')
	) and Puesto is null
limit 30;

/*-|82|- 
Asignar en la tabla voluntarios old la labor de Promoción a: 30 personas
que hayan elegido Tareas Promocion con preferencia 1 ó 2 ó 3 ó 4
*/

update voluntarios 
set Puesto = 'Promoción'
where IdVoluntarios in (
	select vo.Idvoluntario  
	from voluntarios_old vo
	where vo.TareasPromocion in ('1','2','3','4')
	) and Puesto is null
limit 30;

/*-|83|- 
Asignar en la tabla voluntarios la columna puesto el valor “Apoyo” a: 60 personas 
que practiquen esquí
*/

update voluntarios 
set Puesto = 'Apoyo'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, practicar p, deportes d
	where v.IdVoluntarios = p.IdVoluntarios 
		and p.IdDeportes = d.IdDeporte 
		and d.deporte like '%esquí%'
	) and Puesto is null
limit 60;

/*-|84|- 
Asignar en la tabla voluntarios la columna puesto el valor “Accesos” a: 30 personas 
más altas.
*/

update voluntarios 
set Puesto = 'Accesos'
where Puesto is null
order by altura desc 
limit 30;

/*-|85|- 
Asignar en la tabla voluntarios la columna puesto el valor “Voluntarios” a: 30 personas 
de menor peso
*/

update voluntarios
set Puesto = 'Voluntarios'
where Puesto is null
order by peso asc 
limit 30;

/*-|86|- 
Asignar en la tabla voluntarios la columna puesto el valor “Información” a: 30 personas
*/

update voluntarios
set Puesto = 'Información'
where Puesto is null
limit 30;

/*-|87|- 
Asignar en la tabla voluntarios la columna puesto el valor “Palacio de congresos” a 
personas con las siguientes tareas:
	a. 	10 personas Traducción o Interprete
	b. 	4 sanitarios
	c. 	10 administrativos
	d. 	5 información
	e. 	5 informaticos,
	f. 	10 protocolo
	g. 	5 logistica
*/

-- a.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	) and Puesto is null
limit 10;

-- b.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasSanitaria = '1'
	) and Puesto is null
limit 4;

-- c.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Administrativas'
	) and Puesto is null
limit 10;

-- d.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Información'
	) and Puesto is null
limit 5;

-- e.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Informática'
	) and Puesto is null
limit 5;

-- f.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasProtocolo = '1'
	) and Puesto is null
limit 10;

-- g.
update voluntarios
set Puesto = 'Palacio de congresos'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasLogistico = '1'
	) and Puesto is null
limit 5;

/*-|88|- 
Asigna en la tabla voluntarios la columna puesto el valor “Pista de Hielo” a personas 
con las siguientes tareas:
	a. 	8 personas de Accesos,
	b. 	8 personas de logística,
	c. 	6 sanitarios ,
	d. 	5 información,
	e. 	5 informaticos
*/

-- a.
update voluntarios
set Puesto = 'Pista de Hielo'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasAccesos = '1'
	) and Puesto is null
limit 8;

-- b.
update voluntarios
set Puesto = 'Pista de Hielo'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasLogistico = '1'
	) and Puesto is null
limit 8;

-- c.
update voluntarios
set Puesto = 'Pista de Hielo'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasSanitaria = '1'
	) and Puesto is null
limit 6;

-- d.
update voluntarios
set Puesto = 'Pista de Hielo'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Información'
	) and Puesto is null
limit 5;

-- e.
update voluntarios
set Puesto = 'Pista de Hielo'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Informática'
	) and Puesto is null
limit 5;


/*-|89|- 
Asigna en la tabla voluntarios la columna puesto el valor “Centro de Transporte” a personas 
con las siguientes tareas:
	a. 	70 personas de conducción,
	b. 	5 administrativos
	c. 	5 informaticos
	d. 	5 logistica
	e. 	5 informacion
*/

-- a.
update voluntarios
set Puesto = 'Centro de Transporte'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasConduccion = '1'
	) and Puesto is null
limit 70;

-- b.
update voluntarios
set Puesto = 'Centro de Transporte'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Administrativas'
	) and Puesto is null
limit 5;

-- c.
update voluntarios
set Puesto = 'Centro de Transporte'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Informática'
	) and Puesto is null
limit 5;

-- d.
update voluntarios
set Puesto = 'Centro de Transporte'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasLogistico = '1'
	) and Puesto is null
limit 5;

-- e.
update voluntarios
set Puesto = 'Centro de Transporte'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre = 'Información'
	) and Puesto is null
limit 5;

/*-|90|- 
Asigna en la tabla voluntarios la columna puesto el valor “Nave de Logistica” a personas 
con las siguientes tareas:
	a. 	2 personas de Accesos
	b. 	30 promocion
	c. 	5 logistica
*/

-- a.
update voluntarios
set Puesto = 'Nave de Logística'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasAccesos = '1'
	) and Puesto is null
limit 2;

-- b.
update voluntarios
set Puesto = 'Nave de Logística'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasPromocion = '1'
	) and Puesto is null
limit 30;

-- c.
update voluntarios
set Puesto = 'Nave de Logística'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasLogistico = '1'
	) and Puesto is null
limit 5;

/*-|91|- 
Asigna en la tabla voluntarios la columna puesto el valor “Escuela militar de montaña” a 
personas con las siguientes tareas:
	a. 	5 Accesos
	b. 	30 voluntarios
*/

-- a.
update voluntarios
set Puesto = 'Escuela militar de montaña'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasAccesos = '1'
	) and Puesto is null
limit 5;

-- b.
update voluntarios
set Puesto = 'Escuela militar de montaña'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasVoluntarios = '1'
	) and Puesto is null
limit 30;

/*-|92|- 
Asigna en la tabla voluntarios la columna puesto el valor “delegaciones” a personas con las 
siguientes tareas:
	a. 	43 personas de Traducción/Interprete
	b. 	10 protocolo
	c. 	20 acompañantes
	d. 	7 logistica
	e. 	5 comunicación
*/

-- a.
update voluntarios
set Puesto = 'Delegaciones'
where IdVoluntarios in (
	select v.IdVoluntarios  
	from voluntarios v, preferencias p, tareas t
	where v.IdVoluntarios  = p.IdVoluntario 
		and p.IdTarea = t.IdTarea 
		and t.nombre in ('Traducción','Intérprete')
	) and Puesto is null
limit 43;

-- b.
update voluntarios
set Puesto = 'Delegaciones'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasProtocolo = '1'
	) and Puesto is null
limit 10;

-- c.
update voluntarios
set Puesto = 'Delegaciones'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasAcompañantes = '1'
	) and Puesto is null
limit 20;

-- d.
update voluntarios
set Puesto = 'Delegaciones'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasLogistico = '1'
	) and Puesto is null
limit 7;

-- e.
update voluntarios
set Puesto = 'Delegaciones'
where IdVoluntarios in (
	select vo.Idvoluntario 
	from voluntarios_old vo
	where vo.TareasComunicacion = '1'
	) and Puesto is null
limit 5;

/*-|93|- 
Asigna en la tabla voluntarios la localidad “Berja” a personas con las siguientes tareas:
	a. 	12 personas Apoyo
	b. 	4 sanitarios
	c. 	3 informacion
	d. 	5 comunicacion
	e. 	3 accesos
*/

-- a.
update voluntarios_old vo
set vo.Puesto = 'Berja'
where vo.TareasApoyo = '1' 
	and vo.Puesto is null
limit 12;

-- b.
update voluntarios_old vo
set vo.Puesto = 'Berja'
where vo.TareasSanitaria = '1' 
	and vo.Puesto is null
limit 4;

-- c.
update voluntarios_old vo
set vo.Puesto = 'Berja'
where vo.TareasInformacion = '1' 
	and vo.Puesto is null
limit 3;

-- d.
update voluntarios_old vo
set vo.Puesto = 'Berja'
where vo.TareasComunicacion = '1' 
	and vo.Puesto is null
limit 5;

-- e.
update voluntarios_old vo
set vo.Puesto = 'Berja'
where vo.TareasAccesos = '1' 
	and vo.Puesto is null
limit 3;

/*-|94|- 
Asigna en la tabla voluntarios la localidad “Jaca” a personas con las siguientes tareas:
	a. 	12 personas Apoyo
	b. 	4 sanitarios
	c. 	3 informacion
	d. 	5 comunicacion
	e. 	3 accesos
*/

-- a.
update voluntarios_old vo
set vo.Puesto = 'Jaca'
where vo.TareasApoyo = '1' 
	and vo.Puesto is null
limit 12;

-- b.
update voluntarios_old vo
set vo.Puesto = 'Jaca'
where vo.TareasSanitaria = '1' 
	and vo.Puesto is null
limit 4;

-- c.
update voluntarios_old vo
set vo.Puesto = 'Jaca'
where vo.TareasInformacion = '1' 
	and vo.Puesto is null
limit 3;

-- d.
update voluntarios_old vo
set vo.Puesto = 'Jaca'
where vo.TareasComunicacion = '1' 
	and vo.Puesto is null
limit 5;

-- e.
update voluntarios_old vo
set vo.Puesto = 'Jaca'
where vo.TareasAccesos in ('1','2') 
	and vo.Puesto is null
limit 3;

/*-|95|- 
Asigna en la tabla voluntarios la localidad “Formentera” a personas con las 
siguientes tareas:
	a. 	12 personas Apoyo
	b. 	4 sanitarios
	c. 	3 informacion
	d. 	5 comunicacion
	e. 	3 accesos
*/

-- a.
update voluntarios_old vo
set vo.Puesto = 'Formentera'
where vo.TareasApoyo = '1' 
	and vo.Puesto is null
limit 12;

-- b.
update voluntarios_old vo
set vo.Puesto = 'Formentera'
where vo.TareasSanitaria = '1' 
	and vo.Puesto is null
limit 4;

-- c.
update voluntarios_old vo
set vo.Puesto = 'Formentera'
where vo.TareasInformacion = '1' 
	and vo.Puesto is null
limit 3;

-- d.
update voluntarios_old vo
set vo.Puesto = 'Formentera'
where vo.TareasComunicacion = '1' 
	and vo.Puesto is null
limit 5;

-- e.
update voluntarios_old vo
set vo.Puesto = 'Formentera'
where vo.TareasAccesos in ('1','2') 
	and vo.Puesto is null
limit 3;

/*-|96|- 
Asigna la tarea de Panticosa a personas con las siguientes tareas:
	a. 	12 personas Apoyo
	b. 	4 sanitarios
	c. 	3 informacion
	d. 	5 comunicacion
	e. 	3 accesos
*/

-- a.
update voluntarios_old vo
set vo.Puesto = 'Panticosa'
where vo.TareasApoyo = '1' 
	and vo.Puesto is null
limit 12;

-- b.
update voluntarios_old vo
set vo.Puesto = 'Panticosa'
where vo.TareasSanitaria = '1' 
	and vo.Puesto is null
limit 4;

-- c.
update voluntarios_old vo
set vo.Puesto = 'Panticosa'
where vo.TareasInformacion = '1' 
	and vo.Puesto is null
limit 3;

-- d.
update voluntarios_old vo
set vo.Puesto = 'Panticosa'
where vo.TareasComunicacion = '1' 
	and vo.Puesto is null
limit 5;

-- e.
update voluntarios_old vo
set vo.Puesto = 'Panticosa'
where vo.TareasAccesos in ('1','2') 
	and vo.Puesto is null
limit 3;