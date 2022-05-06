/*PRUEBAS*/
/*TRIGGERS*/
/*TRIGGER JUGADORES MAXIMOS*/
select count(*)
from jugador
where id_equipo=1;
/*
  COUNT(*)
----------
         6*/
         
/*El equipo 1 tiene 6 jugadores, el trigger debe impedir que se a�ada un 
nuevo jugador*/
select nombre
from jugador
where id_equipo=1;

delete from jugador
where upper(nombre)='ISABEL';
/*NOMBRE                                            
---------
iker
ana
ivan
i�igo
celia
alba*/

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34483018M','Isabel','666333113','estoy probando 7',1, 15700);


/*Error que empieza en la l�nea: 21 del comando :
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34483008M','Isabel','666333111','estoy probando 7',1, 1500)
Informe de error -
ORA-20007: ERROR: EQUIPO COMPLETO
ORA-06512: en "SYSTEM.JUGMAX", l�nea 8
ORA-04088: error durante la ejecuci�n del disparador 'SYSTEM.JUGMAX'*/

select nombre
from jugador
where id_equipo=1;

/*NOMBRE                                            
---------
iker
ana
ivan
i�igo
celia
alba*/

/*PRUEBA CON UPDATE JUGADOR*/
update jugador
set id_equipo = 1
where upper(nombre)= 'BERTRAND LEROY';

/*HAGO UN INSERT EN OTRO EQUIPO QUE NO ESTE COMPLETO*/
select count(*)
from jugador
where id_equipo=2;
/*  COUNT(*)
----------
         4*/
         
select nombre
from jugador
where id_equipo=2;
/*NOMBRE                                            
--------------------------
 tienne Pages
Denis-Yves Camus
Bertrand Leroy
Brigitte de la Mathieu*/    

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34483008M','Isabel','666333111','estoy probando 7',2, 1500);

/*1 FILA INSERTADAS*/

select nombre
from jugador
where id_equipo=2;
/*NOMBRE                                            
--------------------------------------------------
 tienne Pages
Denis-Yves Camus
Bertrand Leroy
Brigitte de la Mathieu
Isabel*/

/*********************TRIGGER existeCalendario ****************************/
desc calendario;
insert into calendario(cerrado, temporada) values('n',2);
/*
Error que empieza en la l�nea: 84 del comando :
insert into calendario(cerrado, temporada) values('n',2)
Informe de error -
ORA-20009: ERROR: YA EXISTE UN CALENDARIO
ORA-06512: en "SYSTEM.EXISTECALENDARIO", l�nea 8
ORA-04088: error durante la ejecuci�n del disparador 'SYSTEM.EXISTECALENDARIO'*/

/*********************TRIGGER jugMin ****************************/


update calendario
set cerrado='N';

insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('playedsrs', 'alemadasna', to_date('01/04/2020', 'DD/MM/YYYY'),648557, 
        'plafasyers@gmail.com', 'tiene');
        
       
update calendario
set cerrado='N';

/*

ORA-20011: ERROR: EQUIPO 5 CON POCOS JUGADORES ORA-06512: at "SQL_GWDIJBHCYXYWBMKRQCUJUBWXD.JUGMIN", line 40
ORA-06512: at "SQL_GWDIJBHCYXYWBMKRQCUJUBWXD.JUGMIN", line 40
ORA-06512: at "SYS.DBMS_SQL", line 1721
*/
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
VALUES ('512708J',' tine Pages','8901','3 Chelmsford Close- Sutton',6,10291);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
VALUES ('500108J',' enne Pages','871601','3 Chelmsford Close- Sutton',6,10291);

update calendario
set cerrado='N';
/*
1 row(s) updated.
*/

/*********************TRIGGER calCerrado ****************************/

-- Si se intenta cambiar una vez el calendario este cerrado
update calendario
set cerrado='S';
/*
Error que empieza en la línea: 176 del comando :
update calendario
set cerrado='S'
Informe de error -
ORA-20201: ERROR: EL CALENDARIO ESTA CERRADO
ORA-06512: en "EQDAW02.CALCERRADO", línea 15
ORA-04088: error durante la ejecución del disparador 'EQDAW02.CALCERRADO'
*/

-- Si se intenta cambiar una y el calendario esta abierto
update calendario
set cerrado='N';

/*1 fila actualizadas.*/

-- Si se intenta insertar un calendario una vez el calendario este cerrado
insert into calendario (cerrado,temporada) values ('N','5');
/*
Error que empieza en la línea: 179 del comando :
insert into calendario (cerrado,temporada) values ('N','5')
Informe de error -
ORA-20201: ERROR: EL CALENDARIO ESTA CERRADO
ORA-06512: en "EQDAW02.CALCERRADO", línea 15
ORA-04088: error durante la ejecución del disparador 'EQDAW02.CALCERRADO'
*/

-- Si se intenta borrar un calendario una vez el calendario este cerrado
delete calendario;
/*
Error que empieza en la línea: 181 del comando :
delete calendario
Informe de error -
ORA-20201: ERROR: EL CALENDARIO ESTA CERRADO
ORA-06512: en "EQDAW02.CALCERRADO", línea 15
ORA-04088: error durante la ejecución del disparador 'EQDAW02.CALCERRADO'
*/

/*********************TRIGGER asistentes ****************************/


--Si intentamos cambiar un asistente a otro equipo que ya tiene uno
update equipo
set id_asistente=4
where id_asistente=2;
/*
Informe de error -
ORA-20011: ERROR: EQUIPO 1 YA TIENE UN ASISTENTE
ORA-06512: en "EQDAW02.ASISTENTES", línea 44
ORA-04088: error durante la ejecución del disparador 'EQDAW02.ASISTENTES'
*/


/*********************TRIGGER entrenadores ****************************/


--Si intentamos hacer un insert en entrenador donde el id_equipo esta usado por otro entrenador
insert into entrenador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('569147s','unter den linden','68154','calle dato 59', 4, 1950);
/*
Informe de error -
ORA-20011: ERROR: EQUIPO YA TIENE UN ENTRENADOR
ORA-06512: en "EQDAW02.ENTRENADORES", línea 43
ORA-04088: error durante la ejecución del disparador 'EQDAW02.ENTRENADORES'
*/

--Si intentamos hacer un update en entrenador donde el id_equipo esta usado por otro entrenador
update entrenador
set id_equipo=4
where id_equipo=3;
/*
Informe de error -
ORA-20011: ERROR: EQUIPO YA TIENE UN ENTRENADOR
ORA-06512: en "EQDAW02.ENTRENADORES", línea 43
ORA-04088: error durante la ejecución del disparador 'EQDAW02.ENTRENADORES'
*/

/**********************Controlar equiposPares ************************************/
insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo,id_asistente)
values('alliadsgance', 'francesa', to_date('23/04/2022', 'DD/MM/YYYY'),695125, 
        'alnce@gmail.com', 'no_tiene',2);

--Si intentamos cerrar el calendario con un numero impar de equipos
update calendario
set cerrado='S'
/*
Informe de error -
ORA-20100:  LO SENTIMOS PERO LOS EQUIPOS SON IMPARES User-Defined Exception
ORA-06512: en "EQDAW02.EQUIPOSPARES", línea 16
ORA-04088: error durante la ejecución del disparador 'EQDAW02.EQUIPOSPARES'
*/
--Si intentamos cerrar el calendario con un numero par de equipos
update calendario
set cerrado='S'
/*
1 fila actualizadas.
*/

/**********************Controlar SalarioMinimo ************************************/

--Si se intenta insertar un nuevo jugador con un salario superior a 200000
insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('142272s','ikr','4321987', 'calle gorbea, 7 5�d', 1, 200000);
/*
ORA-20101:  Estás introduciendo un salario superior al salario mínimo
ORA-06512: en "EQDAW02.SALARIOMINIMO", línea 44
ORA-04088: error durante la ejecución del disparador 'EQDAW02.SALARIOMINIMO'
*/

--Si intentamos hacer un update para poner un salario menor a 1000
update jugador
set salario=50
where nombre='iker';
/*
Error SQL: ORA-00904: "SALARIO": identificador no válido
00904. 00000 -  "%s: invalid identifier"
*/