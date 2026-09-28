/*-|41|- 
Cantidad de personas de cada país.
*/

select count(v.IdVoluntarios) as total_personas, pa.pais 
from voluntarios v, localidades l, provincias pr, paises pa  
where v.idLocalidad = l.idLocalidad
	and l.idProvincia = pr.idProvincia
	and pr.idPais = pa.idPais
group by pa.pais;

/*-|42|- 
Cantidad de personas de las diferentes provincias de España.
*/

select count(v.IdVoluntarios) as total_personas, pr.provincia, pa.pais 
from voluntarios v, localidades l, provincias pr, paises pa  
where v.idLocalidad = l.idLocalidad
	and l.idProvincia = pr.idProvincia
	and pr.idPais = pa.idPais
	and pa.pais = 'España'
group by pr.provincia, pa.pais;

/*-|43|-
Cantidad de personas de las tres provincias de Aragón.
*/

select count(v.IdVoluntarios) as total_personas, pr.provincia
from voluntarios v, localidades l, provincias pr
where v.idLocalidad = l.idLocalidad
	and l.idProvincia = pr.idProvincia
	and pr.provincia in ('Zaragoza', 'Huesca', 'Teruel')
group by pr.provincia;

/*-|44|-
Cantidad de personas de las diferentes poblaciones de Huesca.
*/

select count(v.IdVoluntarios) as total_personas, l.localidad, pr.provincia
from voluntarios v, localidades l, provincias pr
where v.idLocalidad = l.idLocalidad
	and l.idProvincia = pr.idProvincia
	and pr.provincia = 'Huesca'
group by l.localidad, pr.provincia;

/*-|45|-
a. Cantidad de personas que se llaman igual.
b. Nombre que más se repite.
c. Nombre que se repiten entre 5 y 10 veces.
*/

select count(v.nombre) as total_personas, v.nombre 
from voluntarios v
group by v.nombre
having total_personas > 1;

select count(v.nombre) as total_personas, v.nombre 
from voluntarios v 
group by v.nombre 
order by total_personas desc limit 1;

select count(v.nombre) as total_personas, v.nombre 
from voluntarios v 
group by v.nombre 
having total_personas between 5 and 10;

/*-|46|-
Cantidad de personas por edades.
*/

select count(v.IdVoluntarios) as total_personas, 
	timestampdiff(year, v.fNacimiento, now()) as edad 
from voluntarios v 
group by edad;

/*-|47|-
Cantidad de personas por tallas.
*/

select count(v.IdVoluntarios) as total_personas, v.talla 
from voluntarios v 
group by v.talla;

/*-|48|-
Cantidad de personas por profesion.
*/

select count(v.IdVoluntarios) as total_personas, l.labor 
from voluntarios v, laboral l 
where v.idLabor = l.IdLabor 
group by l.labor;

/*-|49|-
Cantidad de personas por sexo.
*/

select count(v.IdVoluntarios) as total_personas, vo.Sexo 
from voluntarios v, voluntarios_old vo 
where v.IdVoluntarios = vo.Idvoluntario 
group by vo.Sexo;

/*-|50|-
Cantidad de personas nacidas en cada mes.
*/

select count(v.IdVoluntarios) as total_personas, monthname(v.fNacimiento) as mes
from voluntarios v
group by month(v.fNacimiento);

/*-|51|-
Cantidad de personas nacidas en cada trimestre.
*/

select count(v.IdVoluntarios) as total_personas, quarter(v.fnacimiento) as trimestre
from voluntarios v 
group by trimestre;

/*-|52|-
Cantidad de personas nacidas en cada trimestre, pero solo de aquellos trimestres
que tengan más de 110 personas.
*/

select count(v.IdVoluntarios) as total_personas, quarter(v.fnacimiento) as trimestre
from voluntarios v 
group by trimestre
having total_personas > 110;

/*-|53|-
Cantidad de personas de los diferentes niveles de italiano hablado.
*/

select count(IdVoluntarios) as total_personas, n.hablado, i.idioma  
from voluntarios v, nivel n, idiomas i  
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and i.idioma = 'italiano'
group by n.hablado, i.idioma;  

/*-|54|-
Cantidad de personas de los diferentes niveles de frances hablado
*/

select count(IdVoluntarios) as total_personas, n.hablado, i.idioma  
from voluntarios v, nivel n, idiomas i  
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and i.idioma = 'francés'
group by n.hablado, i.idioma;  

/*-|55|-
Cantidad de personas de los diferentes niveles de ingles hablado.
*/

select count(IdVoluntarios) as total_personas, n.hablado, i.idioma  
from voluntarios v, nivel n, idiomas i  
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and i.idioma = 'inglés'
group by n.hablado, i.idioma;  

/*-|56|-
Cantidad de personas de los diferentes niveles de ingles hablado y por edades.
*/

select count(IdVoluntarios) as total_personas, n.hablado, i.idioma,  
	timestampdiff(year, v.fNacimiento, now()) as edad 
from voluntarios v, nivel n, idiomas i  
where v.IdVoluntarios = n.IdVoluntario 
	and n.IdIdioma = i.Ididioma 
	and i.idioma = 'inglés'
group by n.hablado, i.idioma, edad;  

/*-|57|-
Promedio de edades, Más viejo, Más Joven
*/

select avg(timestampdiff(year, v.fNacimiento, now())) as edad_promedio, 
	max(timestampdiff(year, v.fNacimiento, now())) mas_viejo,  
	min(timestampdiff(year, v.fNacimiento, now())) mas_joven
from voluntarios v

/*-|58|-
Promedio de edades de cada provincia.
*/

select p.provincia, avg(timestampdiff(year, v.fNacimiento, now())) as edad_promedio
from voluntarios v, localidades l, provincias p 
where v.idLocalidad = l.idLocalidad 
	and l.idProvincia = p.idProvincia 
group by p.provincia; 

/*-|59|-
Edad de la persona más vieja y más joven de cada pais.
*/

select pa.pais, 
	max(timestampdiff(year, v.fNacimiento, now())) as mas_viejo,
	min(timestampdiff(year, v.fNacimiento, now())) as mas_joven
from voluntarios v, localidades l, provincias pr, paises pa
where v.idLocalidad = l.idLocalidad 
	and l.idProvincia = pr.idProvincia
	and pr.idPais = pa.idPais 
group by pa.pais; 
