create or replace package body gestionarJornada as
/*declaro las funciones que son comunes a todos los procedimientos*/
function validar_jornada
(p_jornada in varchar2)
return boolean;


/*Programacion de las funciones*/
function validar_jornada
(p_jornada in varchar2)
return boolean
is
v_idJornada NUMBER;
begin
select num_jornada into v_idJornada
from jornada
where jornada.num_jornada = p_jornada;
return true;
exception
when no_data_found then
return false;
end validar_jornada;







/*EMPIEZAN LOS PROCEDIMIENTOS***********************************************/
/*PROCEDIMIENTO PARA AÑADIR EQUIPOS+*/
procedure nuevo_jornada
(
p_fecha jornada.fecha%type,
p_numSemana jornada.num_semana%type,
p_idCalendario jornada.id_calendario%type
)
is
begin
if validar_jornada(p_idCalendario)then
dbms_output.put_line('El equipo no existe');
else
insert into jornada
    (FECHA,NUM_SEMANA,id_calendario)
    values(p_fecha,p_numSemana,p_idCalendario);
end if;
exception
when others then
dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_jornada;



/*PROCEDIMIENTO PARA BORRAR EQUIPOS+*/
procedure borrar_jornada
(
p_numJornada jornada.num_jornada%type --Utilizamos el nombre, ya que es unique y no se puede repetir
)
is
begin
if validar_jornada(p_numJornada) then
delete from jornada
where num_jornada = p_numJornada;

else
dbms_output.put_line ('El equipo no existe');
end if;
exception
when others then
dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_jornada;

end gestionarJornada;