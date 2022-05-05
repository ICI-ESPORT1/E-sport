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
         
/*El equipo 1 tiene 6 jugadores, el trigger debe impedir que se añada un 
nuevo jugador*/
select nombre
from jugador
where id_equipo=1;
/*NOMBRE                                            
---------
iker
ana
ivan
iñigo
celia
alba*/
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34483008M','Isabel','666333111','estoy probando 7',1, 1500);
/*Error que empieza en la línea: 21 del comando :
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34483008M','Isabel','666333111','estoy probando 7',1, 1500)
Informe de error -
ORA-20007: ERROR: EQUIPO COMPLETO
ORA-06512: en "SYSTEM.JUGMAX", línea 8
ORA-04088: error durante la ejecución del disparador 'SYSTEM.JUGMAX'*/

select nombre
from jugador
where id_equipo=1;

/*NOMBRE                                            
---------
iker
ana
ivan
iñigo
celia
alba*/

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
Error que empieza en la línea: 84 del comando :
insert into calendario(cerrado, temporada) values('n',2)
Informe de error -
ORA-20009: ERROR: YA EXISTE UN CALENDARIO
ORA-06512: en "SYSTEM.EXISTECALENDARIO", línea 8
ORA-04088: error durante la ejecución del disparador 'SYSTEM.EXISTECALENDARIO'*/

