/*PROCEDIMIENTOS*/
/*PROCEDIMIENTO JUGADORES*/
/*FUNCION PARA COMPROBAR SI EXISTE EL EQUIPO AL QUE SE QUIERE AÑADIR EL JUGADOR*/
create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;
/*FUNCION PARA COMPROBAR QUE UN JUGADOR EXISTE*/
create or replace function validar_jugador
(p_jugador in number)
return boolean
is
  v_idJugador number;
begin
  select id_jugador into v_idJugador
  from jugador
  where jugador.id_jugador = p_jugador;
return true;
exception
  when no_data_found then 
    return false;
end validar_jugador;


/*PROCEDIMIENTO PARA AÑADIR JUGADORES*/
create or replace procedure nuevo_jugador
(
p_dni jugador.dni%type,
p_nombre jugador.nombre%type,
p_telefono jugador.telefono%type,
p_direccion jugador.direccion%type,
p_id_equipo jugador.id_equipo%type,
p_nickname jugador.nickname%type,
p_sueldo jugador.sueldo%type,
p_id_rol jugador.id_rol%type
)
is
begin
  if validar_equipo(p_id_equipo)then

     insert into jugador
     (DNI,NOMBRE,TELEFONO,DIRECCION,ID_EQUIPO,NICKNAME,SUELDO,ID_ROL)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo,p_nickname,
               p_sueldo,p_id_rol);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_jugador;
/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN JUGADOR*/
create or replace procedure cambio_equipo
(
p_idJugador jugador.id_jugador%type,
p_idEquipoNuevo jugador.id_equipo%type
)
is
begin
 if validar_jugador(p_idJugador) then
    if validar_equipo(p_idEquipoNuevo)then
      update jugador
      set id_equipo = p_idEquipoNuevo
      where id_jugador = p_idJugador;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El jugador no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo;   

/*PROCEDIMIENTO PARA BORRAR JUGADORES*/
create or replace procedure borrar_jugador
(
p_idJugador jugador.id_jugador%type
)
is
begin
  if validar_jugador(p_idJugador) then
   delete from jugador
   where id_jugador = p_idJugador;
   
   else
        dbms_output.put_line ('El jugador no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_jugador;  













/*1. PROCEDIMIENTO PARA OBTENER LA CLASIFICACION*/
desc resultados_temporada
/*Nombre    Â¿Nulo?   Tipo         
--------- -------- ------------ 
JORNADA   NOT NULL NUMBER(3)    
FECHA              DATE         
SEMANA             VARCHAR2(2)  
PARTIDO   NOT NULL NUMBER(3)    
HORA               DATE         
CODEQUIPO NOT NULL NUMBER(3)    
EQUIPO             VARCHAR2(20) 
RESULTADO          VARCHAR2(5)  */

select * from resultados_temporada;
/*OBTENER ULTIMO PARTIDO*/


select equipo, resultado
from resultados_temporada
where fecha = (select max(fecha)
                from resultados_temporada);



create or replace procedure resultadoUltimoPartido
(
v_resultado out varchar2,
v_equipo out varchar2
)
as
v_registro resultados_temporada%rowtype;












