create or replace package body gestionarEquipos as
/*declaro las funciones que son comunes a todos los procedimientos*/
function validar_equipo_nombre
(p_equipo_nom in varchar2)
return boolean;

/*Programacion de las funciones*/

function validar_equipo_nombre
(p_equipo_nom in varchar2)
return boolean
is
v_idEquipo NUMBER;
begin
select cod_equipo into v_idEquipo
from equipo
where nombre= p_equipo_nom;
return true;
exception
when no_data_found then
return false;
end validar_equipo_nombre;

/*EMPIEZAN LOS PROCEDIMIENTOS***********************************************/
/*PROCEDIMIENTO PARA AÑADIR EQUIPOS*/
procedure nuevo_equipo
(
p_nombre equipo.nombre%type,
p_nacionalidad equipo.nacionalidad%type,
p_fecha_creacion equipo.fecha_creacion%type,
p_telefono equipo.telefono%type,
p_mail equipo.mail%type,
p_escudo equipo.escudo%type,
p_idAsistente equipo.id_asistente%type
)
is
begin
if validar_equipo_nombre(p_nombre)then
dbms_output.put_line('El equipo no existe');
else
insert into equipo
(nombre,nacionalidad,fecha_creacion,telefono,mail,escudo,id_asistente)
values(p_nombre,p_nacionalidad,p_fecha_creacion,
p_telefono,p_mail,p_escudo,p_idAsistente);
end if;
exception
when others then
dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_equipo;

/*PROCEDIMIENTO PARA BORRAR EQUIPOS*/
procedure borrar_equipo
(
p_nombre equipo.nombre%type --Utilizamos el nombre, ya que es unique y no se puede repetir
)
is
begin
if validar_equipo_nombre(p_nombre) then
delete from equipo
where nombre = p_nombre;

else
dbms_output.put_line ('El equipo no existe');
end if;
exception
when others then
dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_equipo;

/*PROCEDIMIENTO PARA CAMBIAR NOMBRE EQUIPO*/
procedure cambiar_nombre_equipo
(
p_nombre equipo.nombre%type,
p_nombre_nuevo equipo.nombre%type
)
is
begin

if validar_equipo_nombre(p_nombre) then
update equipo
set nombre=p_nombre_nuevo
where nombre=p_nombre;

else
dbms_output.put_line('El equipo no existe');
end if;
exception
when others then
dbms_output.put_line('HA OCURRIDO UN ERROR');
END cambiar_nombre_equipo;

end gestionarEquipos;