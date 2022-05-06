/*TRIGGERS*/
/*1. Controlar el max de jugadores por equipos*/
set serveroutput on

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
select count(*) into v_countJugador
    from jugador
    where id_equipo= new_jugador.id_equipo;
    DBMS_OUTPUT.put_line(v_countJugador);
if v_countJugador >= 6 then
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
 

/**********************Controlar min jugadores****************************** */

create or replace trigger jugMin
for update of cerrado on calendario compound trigger

newCalendario calendario%rowtype;
v_numJugadores PLS_INTEGER;
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;

cursor id_equipo_cursor is
select COD_EQUIPO,NOMBRE,NACIONALIDAD,FECHA_CREACION,TELEFONO,MAIL,ESCUDO
from equipo;

before each row is

begin
if updating then
newCalendario.ID_CALENDARIO:= :new.ID_CALENDARIO;
newCalendario.CERRADO:= :new.CERRADO;
newCalendario.TEMPORADA:= :new.TEMPORADA;
end if;
end before each row;


before statement is
begin

select newCalendario.cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

FOR v_cod_equipo in id_equipo_cursor loop

select count(*) into v_numJugadores
from jugador
where id_equipo= v_cod_equipo.COD_EQUIPO;

if v_numJugadores < 2 then
raise_application_error(-20011,'ERROR: EQUIPO '||v_cod_equipo.COD_EQUIPO||' CON POCOS JUGADORES');
END IF;
end loop;

    EXCEPTION
    WHEN e_calendario_cerrado then
    RAISE_APPLICATION_ERROR(-20012, 'ERROR: EL CALENDARIO ESTA CERRADO');
    END BEFORE STATEMENT;
end;

alter trigger jugMin disable;
      

/**********************Controlar el insert de calendario****************************** */
     
create or replace trigger calCerrado 
before insert or update or delete on calendario 
declare
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;
begin

select cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

EXCEPTION
WHEN e_calendario_cerrado THEN
RAISE_APPLICATION_ERROR(-20201,'ERROR: EL CALENDARIO ESTA CERRADO');
end;

alter trigger calCerrado disable;


/**********************Controlar solo un asistente************************************/

create or replace trigger asistentes
for update or insert on equipo compound trigger

newEquipo equipo%rowtype;
v_numAsistentes PLS_INTEGER;
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;

cursor id_equipo_cursor is
select COD_EQUIPO,NOMBRE,NACIONALIDAD,FECHA_CREACION,TELEFONO,MAIL,ESCUDO,ID_ASISTENTE
from equipo;

before each row is

begin
if updating or inserting then
newEquipo.COD_EQUIPO:= :new.COD_EQUIPO;
newEquipo.NOMBRE:= :new.NOMBRE;
newEquipo.NACIONALIDAD:= :new.NACIONALIDAD;
newEquipo.FECHA_CREACION:= :new.FECHA_CREACION;
newEquipo.MAIL:= :new.MAIL;
newEquipo.ESCUDO:= :new.ESCUDO;
newEquipo.ID_ASISTENTE:= :new.ID_ASISTENTE;
end if;
end before each row;


before statement is
begin

select calendario.cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

FOR v_cod_equipo in id_equipo_cursor loop

select count(id_asistente) into v_numAsistentes
from equipo
where cod_equipo= v_cod_equipo.COD_EQUIPO;

if v_numAsistentes = 1 then
raise_application_error(-20011,'ERROR: EQUIPO '||v_cod_equipo.COD_EQUIPO||' YA TIENE UN ASISTENTE');
END IF;
end loop;

    EXCEPTION
    WHEN e_calendario_cerrado then
    RAISE_APPLICATION_ERROR(-20012, 'ERROR: EL CALENDARIO ESTA CERRADO');
    END BEFORE STATEMENT;
end;

alter trigger asistentes disable;


/**********************Controlar solo un entrenador************************************/

create or replace trigger entrenadores
for update or insert on entrenador compound trigger

newEntrenador entrenador%rowtype;
v_numEntrenadores PLS_INTEGER;
v_cerrado char(1);
e_calendario_cerrado EXCEPTION;

cursor id_equipo_cursor is
select COD_EQUIPO,NOMBRE,NACIONALIDAD,FECHA_CREACION,TELEFONO,MAIL,ESCUDO
from equipo;

before each row is

begin
if updating or inserting then
newEntrenador.DNI:= :new.DNI;
newEntrenador.NOMBRE:= :new.NOMBRE;
newEntrenador.TELEFONO:= :new.TELEFONO;
newEntrenador.DIRECCION:= :new.DIRECCION;
newEntrenador.ID_EQUIPO:= :new.ID_EQUIPO;
newEntrenador.SUELDO:= :new.SUELDO;
end if;
end before each row;


before statement is
begin

select calendario.cerrado into v_cerrado
from calendario;

if upper(v_cerrado)='S' then
raise e_calendario_cerrado;
end if;

FOR v_cod_equipo in id_equipo_cursor loop

select count(*) into v_numEntrenadores
from entrenador
where id_equipo= v_cod_equipo.COD_EQUIPO;

if v_numEntrenadores = 1 then
raise_application_error(-20011,'ERROR: EQUIPO YA TIENE UN ENTRENADOR');
END IF;
end loop;

    EXCEPTION
    WHEN e_calendario_cerrado then
    RAISE_APPLICATION_ERROR(-20012, 'ERROR: EL CALENDARIO ESTA CERRADO');
    END BEFORE STATEMENT;
end;

alter trigger entrenadores disable;
/**********************Controlar equipos pares ************************************/

create or replace trigger equiposPares
  before update on CALENDARIO
  FOR EACH ROW
  DECLARE
  cant_equipos PLS_INTEGER;
  equipos_Impares EXCEPTION;
  BEGIN
  DBMS_OUTPUT.PUT_LINE('S');
  SELECT COUNT(*) INTO cant_equipos 
  FROM EQUIPO;

  IF (MOD(cant_equipos,2) = 0) THEN
  dbms_output.put_line('SE HA EJECUTADO CORRECTAMENTE');
  ELSE
  RAISE equipos_Impares;
  END IF;
  EXCEPTION
  WHEN equipos_Impares THEN
  RAISE_APPLICATION_ERROR(-20100, ' LO SENTIMOS PERO LOS EQUIPOS SON IMPARES ' ||SQLERRM);
  
END;

update calendario
set cerrado='S'

select * from equipo;

insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo,id_asistente)
values('allifaadsgance', 'francesa', to_date('23/04/2022', 'DD/MM/YYYY'),6925125, 
        'alnfasce@gmail.com', 'no_tiene',2);

/**********************Controlar salario minimo************************************/

CREATE OR REPLACE TRIGGER SalarioMinimo
FOR INSERT OR UPDATE OF sueldo ON jugador COMPOUND TRIGGER

newJugador jugador%rowtype;
v_sueldosTotal NUMBER; --La suma de todo el sueldo
v_presupuestoMaximoPorEquipo number:=200000; --El presupuesto maximo
v_nuevoSueldo NUMBER;
v_errorSalario EXCEPTION;

BEFORE EACH ROW IS
BEGIN
if inserting then
newJugador.ID_JUGADOR:= :new.ID_JUGADOR;
newJugador.DNI:= :new.DNI;
newJugador.NOMBRE:= :new.NOMBRE;
newJugador.TELEFONO:= :new.TELEFONO;
newJugador.DIRECCION:= :new.DIRECCION;
newJugador.ID_EQUIPO:= :new.ID_EQUIPO;
newJugador.NICKNAME:= :new.NICKNAME;
newJugador.SUELDO:= :new.SUELDO;
newJugador.ID_ROL:= :new.ID_ROL;

end if;

END BEFORE EACH ROW;


BEFORE STATEMENT IS

BEGIN

SELECT sum(newJugador.SUELDO)
INTO v_sueldosTotal
FROM jugador;

v_nuevoSueldo := newJugador.SUELDO + v_sueldosTotal;

IF(v_nuevoSueldo>v_presupuestoMaximoPorEquipo)THEN
dbms_output.put_line(' FUNCIONA ');
ELSE
RAISE v_errorSalario;
END IF;
EXCEPTION
WHEN v_errorSalario THEN
RAISE_APPLICATION_ERROR(-20101, ' Estás introduciendo un salario menor al salario mínimo ' );

end BEFORE STATEMENT;
END;
alter trigger SalarioMinimo disable;