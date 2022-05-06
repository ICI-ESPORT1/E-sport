/*CUERPO PAQUETE GESTIONAR JUGADORES*/
create or replace package body gestionarDueno as
/*declaro las funciones que son comunes a todos los procedimientos*/
    function validar_equipo
    (p_equipo in number)
    return boolean;
function validar_dueno
    (p_dueno in number)
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
    
    function validar_dueno
    (p_dueno in number)
    return boolean
    is
        v_idDueno number;
    begin
        select id_dueno into v_idDueno
        from dueno
        where dueno.id_dueno = p_dueno;
        return true;
    exception
        when no_data_found then 
        return false;
    end validar_dueno;
    
    
    
/*EMPIEZAN LOS PROCEDIMIENTOS***********************************************/
/*PROCEDIMIENTO PARA AÑADIR JUGADORES*/
procedure nuevo_dueno
(
p_dni dueno.dni%type,
p_nombre dueno.nombre%type,
p_telefono dueno.telefono%type,
p_direccion dueno.direccion%type,
p_id_equipo dueno.id_equipo%type
)
as
begin
  if validar_equipo(p_id_equipo)then

     insert into dueno
     (DNI, NOMBRE, TELEFONO, DIRECCION, ID_EQUIPO)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_dueno;


/*PROCEDIMIENTO PARA CAMBIAR EQUIPO*******************************************/
procedure cambio_equipo
(
p_idDueno dueno.id_dueno%type,
p_idEquipoNuevo dueno.id_equipo%type
)
is
begin
 if validar_dueno(p_idDueno) then
    if validar_equipo(p_idEquipoNuevo)then
      update dueno
      set id_equipo = p_idEquipoNuevo
      where id_dueno = p_idDueno;
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


/*PROCEDIMIENTO PARA BORRAR JUGADOR*******************************************/

end gestionarDueno;