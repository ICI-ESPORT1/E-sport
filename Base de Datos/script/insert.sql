/*insert equipo*/

insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('force', 'espanola', to_date('01/01/2022', 'DD/MM/YYYY'),654987321, 
        'force@gmail.com', 'tiene');

insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('alliance', 'francesa', to_date('23/04/2022', 'DD/MM/YYYY'),698745125, 
        'alliance@gmail.com', 'no_tiene');


insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('stacks', 'inglesa', to_date('14/03/2021', 'DD/MM/YYYY'),632598145, 
        'stacks@gmail.com', 'tiene');


insert into equipo (nombre, nacionalidad, fecha_creacion, telefono, mail, escudo)
values('players', 'alemana', to_date('01/04/2020', 'DD/MM/YYYY'),648211557, 
        'players@gmail.com', 'tiene');

/*INSERT ENTRENADOR*/
insert into entrenador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('49547320h','antonio fernandez','66677788','calle dato 5 4� izq', 1, 1450);

insert into entrenador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('82184054v','gaston gael','665887994','calle gatien 35 1� a', 2, 1530);

insert into entrenador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('34899408j','harry wilson','655881226','calle davies taylor 2 4�', 3, 1750);

insert into entrenador(dni,nombre,telefono,direccion,id_equipo,sueldo)
values('56499147s','unter den linden','68822154','calle dato 59', 4, 1950);


/*INSERT JUGADOR 4 EQUIPOS (1-4), MIN 2 JUGADORES, MAX 6*/
/*JUGADORES EQUIPO ESPA�OL ID1*/
insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('14226872s','iker','654321987', 'calle gorbea, 7 5�d', 1, 1234);

insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('84494056Z','ana','789654123', 'calle reyes catolicos, 5 3�a', 1, 1234);

insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('95393136S','ivan','865412354', 'calle alcala, 2 4�c', 1, 1234);

insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('23971838L','i�igo','678854112', 'calle zaragoza, 12 1�d', 1, 1234);

insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('32219983L','celia','633144887', 'calle salamanca, 1', 1, 1234);

insert into jugador (dni,nombre,telefono,direccion,id_equipo,sueldo)
values('44108428V','alba','877412332', 'calle villareal, 12 a', 1, 1234); 

select * from jugador;

/*JUGADORES EQUIPO FRANCES ID2*/

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo)
VALUES ('50012708J',' tienne Pages','876091601','3 Chelmsford Close- Sutton',2,10291);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('70603538R','Denis-Yves Camus','657137657','8 Oakes Close- Somercotes',2,10388);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('77026329L','Bertrand Leroy','765473435','153 Mayors Walk- Peterborough',2,8256);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('23731311A','Brigitte de la Mathieu','796453015','43 Granta Road- Sawston',2,3083);

/*JUGADORES EQUIPO INGLES ID3*/

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('76848552D','Rachel Brown','830962107','14 York Road- Leamington Spa',3,19841);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('85139209V','Ryan Joyce','664524665','19 Clarence Road- Southport',3,8772);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('21710938L','Margaret Massey','724239824','16 Sence House- Welland Place- Market Harborough',3,9867);

/*JUGADORES EQUIPO ALEMAN ID4*/
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('80846588R','Robert Labbe','846511423','96 Wellington Road- Tilbury',4,11823);
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('32956493T','Anastasie Bousquet','605706577','14 Grange Avenue- Huddersfield',4,2692);
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('21676980D','Klara Rose','611532859','6 Forest Road- Bordon',4,9217);
INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('39021894W','Lukas Segebahn','640262731','Talyryn Stables- Cilycwm',4,17653);

INSERT INTO jugador(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('28403030P','Logan Miller','643454503','3 Carrs Close- Prudhoe',4,9863);

/*INSERT HECHO!*/

/*ASISTENTE EQUIPOS 1,2 Y 4*/

INSERT INTO asistente(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('30252486B','Herr Eggert Lorch B.Sc.','707526124','3 Millstones- Wetheral Shields',1,6624);

INSERT INTO asistente(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('35734533P','John Kim','747673873','10 Redwood Road- Poole',2,5186);

INSERT INTO asistente(dni,nombre,telefono,direccion,id_equipo,sueldo) 
VALUES ('37899993H','Mariah Brown','801343181','10 Minshull Street- Knutsford',4,4249);
/*INSERT HECHO*/

/*DUENOS*/

INSERT INTO dueno(dni,nombre,telefono,direccion,id_equipo) 
VALUES ('76025134Z','Michael Jordan','701384248','la paz 8',1);

INSERT INTO dueno(dni,nombre,telefono,direccion,id_equipo) 
VALUES ('72707248Q','Lisa Walker','670678362','Flat 4- Gleneagles- Fairway Drive- Christchurch',2);

INSERT INTO dueno(dni,nombre,telefono,direccion,id_equipo) 
VALUES ('69364787F','Chase Bradley','831835380','53 Dykes End- Collingham',3);

INSERT INTO dueno(dni,nombre,telefono,direccion,id_equipo) 
VALUES ('72670608S','Jeffrey Ortiz','890652188','75 Grange Valley- Haydock',4);

/*INSERT HECHO!*/


/*INSERT ROL. Hay que cambiar las relaciones*/


/*INSERT CALENDARIO*/
desc calendario;
/*temporada???*/
/*hecho!*/

insert into calendario (cerrado, temporada) values ('n','uno');

/*INSERT JORNADA*/
DESC JORNADA;
insert into jornada(fecha,num_semana,id_calendario) 
values (to_date('07/05/2022','DD/MM/YYYY'),'18',1);

insert into jornada(fecha,num_semana,id_calendario) 
values (to_date('14/05/2022','DD/MM/YYYY'),'19',1);

insert into jornada(fecha,num_semana,id_calendario) 
values (to_date('20/05/2022','DD/MM/YYYY'),'20',1);

insert into jornada(fecha,num_semana,id_calendario) 
values (to_date('27/05/2022','DD/MM/YYYY'),'21',1);

/*hecho!*/

/*INSERT PARTIDO*/

insert into partido(hora,num_jornada) values(to_date('07/05/2022','DD/MM/YYYY'),1);

insert into partido (hora,num_jornada) values (to_date('14/05/2022','DD/MM/YYYY'),2);

insert into partido (hora,num_jornada) values (to_date('20/05/2022','DD/MM/YYYY'),3);

insert into partido (hora,num_jornada) values (to_date('27/05/2022','DD/MM/YYYY'),4);

/*INSERT RESULTADO*/
insert into resultado(id_equipo,id_partido, resultado) values(1,1,'G');

insert into resultado(id_equipo,id_partido, resultado) values(2,1,'P');

insert into resultado(id_equipo,id_partido, resultado) values(3,2,'G');

insert into resultado(id_equipo,id_partido, resultado) values(4,2,'P');

insert into resultado(id_equipo,id_partido, resultado) values(1,3,'G');

insert into resultado(id_equipo,id_partido, resultado) values(3,3,'P');

insert into resultado(id_equipo,id_partido, resultado) values(2,4,'G');

insert into resultado(id_equipo,id_partido, resultado) values(4,4,'P');







