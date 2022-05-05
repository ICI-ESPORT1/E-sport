/*CREACION VISTAS*/

desc jornada;

select j.num_jornada as jornada, p.id as partido, r.id_equipo as IDequipo, e.nombre as nombre ,r.resultado as resultado
from partido p, jornada j, resultado r
where p.num_jornada = j.num_jornada and p.num_jornada = (select num_jornada
                                                        from jornada
                                                        where fecha = (select min(fecha) 
                                                        from jornada))
and r.id_partido = p.id ;

select j.num_jornada as jornada, j.fecha as fecha, j.num_semana as semana, 
p.id as partido, p.hora as hora,r.id_equipo as codEquipo, e.nombre as equipo,r.resultado as resultado
from jornada j, partido p, resultado r, equipo e
where p.num_jornada = j.num_jornada and r.id_partido = p.id and r.id_equipo=e.cod_equipo
group by j.num_jornada, j.fecha, j.num_semana, p.id, p.hora, 
r.id_equipo, e.nombre, r.resultado;





create or replace view resultados_temporada as
(select j.num_jornada as jornada, j.fecha as fecha, j.num_semana as semana, 
p.id as partido, p.hora as hora,r.id_equipo as codEquipo, e.nombre as equipo,r.resultado as resultado
from jornada j, partido p, resultado r, equipo e
where p.num_jornada = j.num_jornada and r.id_partido = p.id and r.id_equipo=e.cod_equipo)
with read only;

select * from resultados_temporada;





