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




--Vista para conseguir los nombre de los integrantes de todos los equipos que tengan asistente
create or replace view dat_equipo_con_asistente as
select  DISTINCT j.nombre as nombre_jugador,eq.nombre as nombre_equipo, e.nombre as nombre_entrenador, a.nombre as nombre_asistente, 
d.nombre as nombre_dueno, eq.cod_equipo as id_equipo
from entrenador e, asistente a, dueno d, jugador j, equipo eq
where eq.cod_equipo=e.id_equipo and eq.id_asistente=a.id_asistente and 
eq.cod_equipo=d.id_equipo and eq.cod_equipo=j.id_equipo 
ORDER BY eq.cod_equipo
with read only;

--Vista para conseguir los nombre de los integrantes de todos los equipos que no tengan asistente
create or replace view dat_equipo_sin_asistente as
select  eq.nombre as nombre_equipo, e.nombre as nombre_entrenador, 
d.nombre as nombre_dueno, j.nombre as nombre_jugador, eq.cod_equipo as id_equipo
from entrenador e, dueno d, jugador j, equipo eq
where eq.cod_equipo=e.id_equipo and
eq.cod_equipo=d.id_equipo and eq.cod_equipo=j.id_equipo and eq.id_asistente is null
with read only;