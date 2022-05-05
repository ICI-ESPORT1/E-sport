/*PAQUETE JUGADORES CABECERA*/
create or replace package gestionarJugadores as
procedure nuevo_jugador
(
p_dni jugador.dni%type,
p_nombre jugador.nombre%type,
p_telefono jugador.telefono%type,
p_direccion jugador.direccion%type,
p_id_equipo jugador.id_equipo%type,
p_nickname jugador.nickname%type,
p_sueldo jugador.sueldo%type,
p_id_rol jugador.id_rol%type
);

procedure cambio_equipo
(
p_idJugador jugador.id_jugador%type,
p_idEquipoNuevo jugador.id_equipo%type
);

procedure borrar_jugador
(
p_idJugador jugador.id_jugador%type
);


end gestionarJugadores;