/*CABECERA PAQUETE GESTIONAR ASISTENTES*/
create or replace package gestionarAsistente as
procedure nuevo_asistente
(
p_dni asistente.dni%type,
p_nombre asistente.nombre%type,
p_telefono asistente.telefono%type,
p_direccion asistente.direccion%type,
p_id_equipo asistente.id_equipo%type,
p_sueldo asistente.sueldo%type
);

procedure cambio_equipo
(
p_idAsistente asistente.id_asistente%type,
p_idEquipoNuevo asistente.id_equipo%type
);

procedure borrar_asistente
(
p_idAsistente asistente.id_asistente%type
);
end gestionarAsistente;