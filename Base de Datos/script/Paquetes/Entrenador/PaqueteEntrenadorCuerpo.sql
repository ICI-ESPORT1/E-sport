/*CUERPO PAQUETE GESTIONAR ENTRENADORES*/
create or replace package body gestionarEntrenadores as
/*declaro las funciones que son comunes a todos los procedimientos*/
    function validar_equipo
    (p_equipo in number)
    return boolean;
function validar_entrenador
    (p_jugador in number)
    return boolean; 
    
/*Programacion de las funciones*/    

function validar_equipo
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

    
function validar_entrenador
(p_entrenador in number)
return boolean
is
  v_idEntrenador number;
begin
  select id_entrenador into v_idEntrenador
  from entrenador
  where entrenador.id_entrenador = p_entrenador;
return true;
exception
  when no_data_found then 
    return false;
end validar_entrenador;
/*EMPIEZAN LOS PROCEDIMIENTOS***********************************************/
/*PROCEDIMIENTO PARA AÑADIR ENTRENADORES*/
procedure nuevo_entrenador
(
p_dni entrenador.dni%type,
p_nombre entrenador.nombre%type,
p_telefono entrenador.telefono%type,
p_direccion entrenador.direccion%type,
p_id_equipo entrenador.id_equipo%type,
p_sueldo entrenador.sueldo%type,
)
is
begin
  if validar_entrenador(p_id_equipo)then

     insert into entrenador
     (DNI,NOMBRE,TELEFONO,DIRECCION,ID_EQUIPO,SUELDO)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo,
               p_sueldo);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_entrenador;

/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN ENTRENADOR*/
procedure cambio_equipo_entrenador
(
p_idEntrenador entrenador.id_entrenador%type,
p_idEquipoNuevo entrenador.id_equipo%type
)
is
begin
 if validar_entrenador(p_idEntrenador) then
    if validar_equipo(p_idEquipoNuevo)then
      update entrenador
      set id_equipo = p_idEquipoNuevo
      where id_entrenador = p_idEntrenador;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El entrenador no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo_entrenador;   


/*PROCEDIMIENTO PARA BORRAR ENTRENADOR*/
procedure borrar_entrenador
(
p_idEntrenador entrenador.id_entrenador%type
)
is
begin
  if validar_entrenador(p_idEntrenador) then
   delete from entrenador
   where id_entrenador = p_idEntrenador;
   
   else
        dbms_output.put_line ('El entrenador no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_entrenador;  

end gestionarEntrenadores;