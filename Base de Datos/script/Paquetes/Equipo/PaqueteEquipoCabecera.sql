/*PAQUETE EQUIPO CABECERA*/
create or replace package gestionarEquipos as
procedure nuevo_equipo
(
p_nombre equipo.nombre%type,
p_nacionalidad equipo.nacionalidad%type,
p_fecha_creacion equipo.fecha_creacion%type,
p_telefono equipo.telefono%type,
p_mail equipo.mail%type,
p_escudo equipo.escudo%type,
p_idAsistente equipo.id_asistente%type
);

procedure borrar_equipo
(
p_nombre equipo.nombre%type --Utilizamos el nombre, ya que es unique y no se puede repetir
);

procedure cambiar_nombre_equipo
(
p_nombre equipo.nombre%type,
p_nombre_nuevo equipo.nombre%type
);

end gestionarEquipos;