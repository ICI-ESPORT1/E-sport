/*PAQUETE ENTRENADOR CABECERA*/
create or replace package gestionarEntrenadores as
procedure nuevo_entrenador
(
p_dni entrenador.dni%type,
p_nombre entrenador.nombre%type,
p_telefono entrenador.telefono%type,
p_direccion entrenador.direccion%type,
p_id_equipo entrenador.id_equipo%type,
p_sueldo entrenador.sueldo%type
);

procedure cambio_equipo_entrenador
(
p_idEntrenador entrenador.id_entrenador%type,
p_idEquipoNuevo entrenador.id_equipo%type
);

procedure borrar_entrenador
(
p_idEntrenador entrenador.id_entrenador%type
);

end gestionarEntrenadores;