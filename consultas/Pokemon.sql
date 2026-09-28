-- pokemon y sus tipos

SELECT p.*, t.*
FROM pokemon p, pokemon_tipo pt, tipo t 
WHERE p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo
ORDER BY p.numero_pokedex; 

-- devuelveme todo lo que pesan todos lo pokemon de tipo eléctrico

select sum(p.peso) as peso_total, t.nombre  
from pokemon p, pokemon_tipo pt, tipo t  
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo 
	and t.nombre = 'Eléctrico'
group by t.nombre;

-- cual es el pokemon que tiene menor ataque de estadistica_base

select p.nombre, eb.ataque 
from pokemon p, estadisticas_base eb 
where p.numero_pokedex = eb.numero_pokedex 
order by eb.ataque limit 1;

-- pokemon con ataque aprendido a partir de MO

select p.nombre, tfa.tipo_aprendizaje  
from pokemon p, pokemon_movimiento_forma pmf, forma_aprendizaje fa, 
	tipo_forma_aprendizaje tfa
where p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje 
	and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
	and tfa.tipo_aprendizaje = 'MO';

-- pokemon con ataque veneno

select p.nombre, m.nombre, t.nombre 
from pokemon p, pokemon_movimiento_forma pmf,  movimiento m, tipo t  
where p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and m.id_tipo = t.id_tipo 
	and t.nombre = 'veneno';

-- todos los pokemon que evolucionan con piedra x

select p.nombre, te.tipo_evolucion, tp.nombre_piedra  
from pokemon p, pokemon_forma_evolucion pfe, forma_evolucion fe, tipo_evolucion te,
	piedra, tipo_piedra tp  
where p.numero_pokedex = pfe.numero_pokedex 
	and pfe.id_forma_evolucion = fe.id_forma_evolucion 
	and fe.tipo_evolucion = te.id_tipo_evolucion 
	and fe.id_forma_evolucion = piedra.id_forma_evolucion 
	and piedra.id_tipo_piedra = tp.id_tipo_piedra 
	and te.tipo_evolucion = 'piedra';
	
-- pokemon con ataque tipo especial

select p.nombre, ta.tipo 
from pokemon p, pokemon_tipo pt, tipo t, tipo_ataque ta 
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo 
	and t.id_tipo_ataque = ta.id_tipo_ataque 
	and ta.tipo = 'especial';

-- calcula imc pokemon
	
select p.*, round((p.peso/(p.altura*p.altura)),2) as imc 
from pokemon p 
order by imc desc;
	
-- cuales son los pokemon con sobrepeso

select p.*, round((p.peso/(p.altura*p.altura)),2) as imc,
	if((round((p.peso/(p.altura*p.altura)),2) > 25),'True','False') as sobrepeso
from pokemon p 
order by altura desc;

-- la consulta de los pokemon tipo fuego

select p.numero_pokedex, p.nombre, t.nombre  
from pokemon p, pokemon_tipo pt, tipo t  
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo 
	and t.nombre = 'fuego';

-- muestra el número de pokemon y su evolución

select p1.numero_pokedex, p1.nombre as 'Pokemon original',
	ed.pokemon_evolucionado, p2.nombre as 'Pokemon evolucionado' 
from pokemon p1, evoluciona_de ed, pokemon p2   
where p1.numero_pokedex = ed.pokemon_origen 
	and p2.numero_pokedex = ed.pokemon_evolucionado;
	
-- 1. Mostrar el nombre de todos los pokemon.

select p.nombre 
from pokemon p;

-- 2. mostrar los pokemon que pesen menos de 10k.

select p.nombre, p.peso  
from pokemon p 
where p.peso < 10;

-- 3. mostrar los pokemon de tipo agua.

select p.nombre, t.nombre  
from pokemon p, pokemon_tipo pt, tipo t 
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo 
	and t.nombre = 'agua';

-- 4. Mostrar los pokemon que son de tipo fuego y volador.

-- 5. mostrar los pokemon con una estadística base de ps mayor que 200.

select p.nombre, eb.ps  
from pokemon p, estadisticas_base eb  
where p.numero_pokedex = eb.numero_pokedex 
	and eb.ps > 200;

-- 6. mostrar los datos(nombre, peso, altura) de la prevolucion de Arbok.

select p1.* 
from pokemon p1, evoluciona_de ed, pokemon p2 
where p1.numero_pokedex = ed.pokemon_origen 
	and p2.numero_pokedex = ed.pokemon_evolucionado 
	and p2.nombre = 'Arbok';

-- 7. Mostrar aquellos pokemon que evolucionan por intercambio.

select p.nombre, te.tipo_evolucion 
from pokemon p, pokemon_forma_evolucion pfe, forma_evolucion fe, tipo_evolucion te  
where p.numero_pokedex = pfe.numero_pokedex 
	and pfe.id_forma_evolucion = fe.id_forma_evolucion 
	and fe.tipo_evolucion = te.id_tipo_evolucion 
	and te.tipo_evolucion = 'intercambio';

-- 8. Mostrar el nombre del movimiento con mas prioridad.

select m.nombre, m.prioridad  
from movimiento m  
order by m.prioridad desc limit 1;

-- 9. Mostrar el pokemon mas pesado.

select p.nombre, p.peso  
from pokemon p 
order by p.peso desc limit 1;

-- 10. Mostrar el nombre y tipo del ataque con mas potencia.

select m.nombre, m.potencia, t.nombre  
from movimiento m, tipo t 
where m.id_tipo = t.id_tipo 
order by m.potencia desc limit 1;

-- 11. Mostrar el numero de movimientos de cada tipo.

select count(m.nombre) as numMovimientos, t.nombre  
from movimiento m, tipo t 
where m.id_tipo = t.id_tipo 
group by t.nombre;

-- 12. Mostrar todos los movimientos que puedan envenenar.

select m.nombre, t.nombre  
from movimiento m, tipo t 
where m.id_tipo = t.id_tipo 
	and t.nombre = 'veneno';

select m.nombre, m.descripcion, es.efecto_secundario  
from movimiento m, movimiento_efecto_secundario mes, efecto_secundario es  
where m.id_movimiento = mes.id_movimiento 
	and mes.id_efecto_secundario = es.id_efecto_secundario 
	and es.efecto_secundario like '%envenena%';

-- 13. Mostrar todos los movimientos que aprende pikachu.

select p.nombre, m.nombre  
from pokemon p, pokemon_movimiento_forma pmf, movimiento m  
where p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and p.nombre = 'Pikachu';

-- 14. Mostrar todos los movimientos que aprende pikachu por MT.

select p.nombre, m.nombre, m.descripcion, tfa.tipo_aprendizaje, mt.MT 
from pokemon p, pokemon_movimiento_forma pmf, movimiento m, forma_aprendizajefa , 
	tipo_forma_aprendizaje tfa, mt
where p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje 
	and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje 
	and fa.id_forma_aprendizaje = mt.id_forma_aprendizaje 
	and p.nombre = 'Pikachu'
	and tfa.tipo_aprendizaje = 'MT';

-- 15. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.

select p.nombre, m.nombre, m.descripcion, tfa.tipo_aprendizaje, t.nombre  
from pokemon p, pokemon_movimiento_forma pmf, movimiento m, forma_aprendizaje fa, 
	tipo_forma_aprendizaje tfa, tipo t 
where p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and m.id_tipo = t.id_tipo 
	and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje 
	and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje 
	and p.nombre = 'Pikachu'
	and tfa.tipo_aprendizaje = 'nivel'
	and t.nombre = 'normal';

-- 16. Mostrar todos los pokemon que evolucionan por piedra.

select p.numero_pokedex, p.nombre, te.tipo_evolucion, tp.nombre_piedra  
from pokemon p, pokemon_forma_evolucion pfe, forma_evolucion fe, tipo_evolucion te,
	piedra pdr, tipo_piedra tp  
where p.numero_pokedex = pfe.numero_pokedex 
	and pfe.id_forma_evolucion = fe.id_forma_evolucion 
	and fe.tipo_evolucion = te.id_tipo_evolucion 
	and pfe.id_forma_evolucion = pdr.id_forma_evolucion 
	and pdr.id_tipo_piedra = tp.id_tipo_piedra 
	and te.tipo_evolucion = 'piedra';

-- 17. Mostrar todos los pokemon que no pueden evolucionar.

-- 18. Mostrar la cantidad de los pokemon de cada tipo.

select count(p.numero_pokedex) as 'total pokemon', t.nombre  
from pokemon p, pokemon_tipo pt, tipo t 
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t.id_tipo 
group by t.nombre;

-- pokemon de tipo electrico que tienen ataques tipo veneno

select p.nombre, t1.nombre as tipoPokemon, m.nombre as nombreMov, m.descripcion, t2.nombre as tipoMov
from pokemon p, pokemon_tipo pt, tipo t1, tipo t2, pokemon_movimiento_forma pmf, movimiento m  
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t1.id_tipo 
	and p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and m.id_tipo = t2.id_tipo 
	and t1.nombre = 'electrico'
	and t2.nombre = 'veneno';

-- numero de movimientos por tipo

select count(m.id_movimiento) as totalMov, t.nombre 
from movimiento m, tipo t  
where m.id_tipo = t.id_tipo 
group by t.nombre; 

-- pokemon de tipo normal que tenga ataques de 0 potencia y que sean de ataque especial
	
select p.nombre as nombrePokemon, t1.nombre as tipoPokemon, m.nombre as nombreMov, m.potencia, 
	ta.tipo as tipoAtaque  
from pokemon p, pokemon_tipo pt, tipo t1, tipo t2, tipo_ataque ta, pokemon_movimiento_forma pmf, movimiento m  
where p.numero_pokedex = pt.numero_pokedex 
	and pt.id_tipo = t1.id_tipo 
	and t2.id_tipo_ataque = ta.id_tipo_ataque 
	and p.numero_pokedex = pmf.numero_pokedex 
	and pmf.id_movimiento = m.id_movimiento 
	and m.potencia = 0
	and t1.nombre = 'normal'
	and ta.tipo = 'especial';

SELECT p.nombre, m.nombre as movimiento, t.nombre as tipo, ta.tipo as tipo_ataque, 
	tfa.tipo_aprendizaje
FROM pokemon p, pokemon_movimiento_forma pmf, movimiento m, tipo t, tipo_ataque ta, 
	forma_aprendizaje fa, tipo_forma_aprendizaje tfa
WHERE p.numero_pokedex = pmf.numero_pokedex
	and pmf.id_movimiento = m.id_movimiento
	and m.id_tipo = t.id_tipo
	and t.id_tipo_ataque = ta.id_tipo_ataque
	and pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
	and fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
	and t.nombre = 'fantasma'
	and ta.tipo = 'especial'
	and tfa.tipo_aprendizaje = 'nivel';



