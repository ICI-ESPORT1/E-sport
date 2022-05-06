/*TRIGGERS*/

/*1. Controlar el max de jugadores por equipos*/
set serveroutput on

create or replace function contarJugadores
(p_newEquipo in number)
return boolean
is
  v_countJugador NUMBER;
begin
  select count(*) into v_countJugador
    from jugador
    where id_equipo= p_newEquipo;
if v_countJugador >= 6 then
  return true;
else
return false;
end if;
exception
   when no_data_found then
     return false;
end contarJugadores;



/*triggerCompuesto*/
create or replace trigger equipoCompleto
for insert or update on jugador compound trigger
new_jugador jugador%rowtype;
v_countJugador number;

before each row is
begin

if inserting then
new_jugador.id_jugador := :new.id_jugador;
new_jugador.dni := :new.dni;
new_jugador.nombre := :new.nombre;
new_jugador.telefono := :new.telefono;
new_jugador.direccion := :new.direccion;
new_jugador.id_equipo := :new.id_equipo;
new_jugador.sueldo := :new.sueldo;
new_jugador.id_rol := :new.id_rol;


else
new_jugador.id_equipo := :new.id_equipo;
end if;

end before each row;

after statement is
begin

if contarJugadores(new_jugador.id_equipo) then
    raise_application_error(-20007,'ERROR: EQUIPO COMPLETO');
  END IF;
end after statement;
end equipoCompleto;

/*alter  trigger equipoCompleto disable; */

/*2. Controlar que una vez generado el calendario no se pueden modificar,
ni equipos, ni jugadores*/
desc calendario;
select * from calendario;
/**********************PARA LA TABLA JUGADORES****************************** */
create or replace trigger calCerradoJU
before insert or update or delete on jugador
for each row
declare
  v_crud varchar2 (250);
  v_cerrado char(1);
begin
 select cerrado into v_cerrado
 from calendario;
 CASE
  when inserting then
     v_crud :='NO SE PUEDE INSERTAR JUGADOR, EL CALENDARIO ESTA CERRADO';
  when updating then
      v_crud :='NO SE PUEDE MODIFICAR EL JUGADOR, EL CALENDARIO ESTA CERRADO';
  when deleting then
     v_crud:= 'NO SE PUEDE BORRAR EL JUGADOR EL CALENDARIO ESTA CERRADO';
 END CASE;
 if upper(v_cerrado)='S' then
 raise_application_error(-20008,('ERROR: ' || v_crud));
 END IF;
END; 
 
 alter  trigger calCerrado disable; 
 
/**********************PARA LA TABLA EQUIPOS****************************** */
create or replace trigger calCerradoEQ
before insert or update or delete on equipo
for each row
declare
  v_crud varchar2 (250);
  v_cerrado char(1);
begin
 select cerrado into v_cerrado
 from calendario;
 CASE
  when inserting then
     v_crud :='NO SE PUEDE INSERTAR EQUIPO, EL CALENDARIO ESTA CERRADO';
  when updating then
      v_crud :='NO SE PUEDE MODIFICAR EL EQUIPO, EL CALENDARIO ESTA CERRADO';
  when deleting then
     v_crud:= 'NO SE PUEDE BORRAR EL EQUIPO EL CALENDARIO ESTA CERRADO';
 END CASE;
 if upper(v_cerrado)='S' then
 raise_application_error(-20008,('ERROR: ' || v_crud));
 END IF;
END;  
 
 