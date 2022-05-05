/*CREATE VISTAS*/
create or replace view resultados_temporada as
select j.num_jornada as jornada, j.fecha as fecha, j.num_semana as semana, 
p.id as partido, p.hora as hora,r.id_equipo as codEquipo, e.nombre as equipo,r.resultado as resultado
from jornada j, partido p, resultado r, equipo e
where p.num_jornada = j.num_jornada and r.id_partido = p.id and r.id_equipo=e.cod_equipo
with read only;


SELECT *
FROM USER_VIEWS
WHERE VIEW_NAME = RESULTADOS_TEMPORADA;

DESC USER_VIEWS