/*PRUEBAS PROCEDIMIENTO NUEVO-JUGADOR*/
/*PRUEBO CON UN NUMERO DE EQUIPO QUE EXISTE*/
/*NOMBRE                                            
--------------------------------------------------
Ryan Joyce
Margaret Massey
Robert Labbe
Anastasie Bousquet
Klara Rose
Lukas Segebahn
Logan Miller*/
begin
  nuevo_jugador('28403035P','Logan Miller','643455403','3 Carrs Close- Prudhoe',10,'mote',9863,1);
end;
SELECT NOMBRE
FROM JUGADOR;
/*NOMBRE                                            
--------------------------------------------------
Ryan Joyce
Margaret Massey
Robert Labbe
Anastasie Bousquet
Klara Rose
Lukas Segebahn
Logan Miller
Logan Miller*/

/*PRUEBO CON UN NUMERO DE EQUIPO QUE NO EXISTE*/
begin
  nuevo_jugador('28403035P','Logan Miller','643455403','3 Carrs Close- Prudhoe',10,'mote',9863,1);
end;

/*El equipo no existe*/

/*PRUEBAS PROCEDIMIENTO BORRAR_JUGADOR*/
/*PRUEBO CON UN ID QUE EXISTE*/
begin
  borrar_jugador(22);
end;
SELECT NOMBRE
FROM JUGADOR;
/*NOMBRE                                            
--------------------------------------------------
Ryan Joyce
Margaret Massey
Robert Labbe
Anastasie Bousquet
Klara Rose
Lukas Segebahn
Logan Miller*/

/*PRUEBO CON UN ID QUE NO EXISTE*/
begin
  borrar_jugador(26);
end;
/*El jugador no existe*/

/*PRUEBAS PROCEDIMIENTO CAMBIO_EQUIPO*/
/*EL JUGADOR Y EL EQUIPO EXISTEN*/
select id_jugador, nombre, id_equipo
from jugador;
/*ID_JUGADOR NOMBRE                                              ID_EQUIPO
---------- -------------------------------------------------- ----------
        12 Ryan Joyce                                                  3
        13 Margaret Massey                                             3
        14 Robert Labbe                                                4
        15 Anastasie Bousquet                                          4
        16 Klara Rose                                                  4
        17 Lukas Segebahn                                              4
        18 Logan Miller                                                4*/
begin
cambio_equipo(18,3);
end;

select id_jugador, nombre, id_equipo
from jugador;
/*ID_JUGADOR NOMBRE                                              ID_EQUIPO
---------- -------------------------------------------------- ----------
        12 Ryan Joyce                                                  3
        13 Margaret Massey                                             3
        14 Robert Labbe                                                4
        15 Anastasie Bousquet                                          4
        16 Klara Rose                                                  4
        17 Lukas Segebahn                                              4
        18 Logan Miller                                                3*/

/*JUGADOR NO EXISTE*/
begin
cambio_equipo(20,3);
end;
/*El jugador no existe*/

/*EQUIPO NO EXISTE*/
begin
cambio_equipo(18,7);
end;
/*El equipo no existe*/




