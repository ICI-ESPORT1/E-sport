/*TRIGGERS*/
/*1. Controlar el max de jugadores por equipos*/
set serveroutput on

create or replace trigger jugMax
before insert on jugador
for each row
declare 
v_numJugadores PLS_INTEGER;
begin
    select count(*) into v_numJugadores
    from jugador
    where id_equipo= :new.id_equipo;
  if v_numJugadores = 6 then
    raise_application_error(-20007,'ERROR: EQUIPO COMPLETO');
  END IF;
END;

alter  trigger jugMax disable; 

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
 
 