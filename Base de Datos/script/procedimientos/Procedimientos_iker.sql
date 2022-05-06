/*PROCEDIMIENTO EQUIPO*/

/*FUNCION PARA VER SI EXISTE EL NOMRBE DE EQUIPO*/

create or replace function validar_equipo_nombre
(p_equipo_nom in varchar2)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where nombre= p_equipo_nom;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo_nombre;


/*PROCEDIMIENTO PARA AÑADIR EQUIPOS*/
create or replace procedure nuevo_equipo
(
p_nombre equipo.nombre%type,
p_nacionalidad equipo.nacionalidad%type,
p_fecha_creacion equipo.fecha_creacion%type,
p_telefono equipo.telefono%type,
p_mail equipo.mail%type,
p_escudo equipo.escudo%type
)
is
begin
  if validar_equipo_nombre(p_nombre)then
  dbms_output.put_line ('El equipo no existe');
     
  else
  insert into equipo
     (nombre,nacionalidad,fecha_creacion,telefono,mail,escudo)
        values(p_nombre,p_nacionalidad,p_fecha_creacion,
          p_telefono,p_mail,p_escudo);
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_equipo;


begin
nuevo_equipo('asf','asderg',to_date('01/01/88','DD/MM/YY'),123123123,'adsg','aerdhf');
end;

select * from EQUIPO;


/*PROCEDIMIENTO PARA BORRAR EQUIPOS*/
create or replace procedure borrar_equipo
(
p_nombre equipo.nombre%type --Utilizamos el nombre, ya que es unique y no se puede repetir
)
is
begin
  if validar_equipo_nombre(p_nombre) then
   delete from equipo
   where nombre = p_nombre;
   
   else
        dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_equipo;  


begin
borrar_equipo('asf');
end;

select * from EQUIPO;



/*PROCEDIMIENTO PARA CAMBIAR NOMBRE EQUIPO*/
create or replace procedure cambiar_nomre_equipo
(
p_nombre equipo.nombre%type,
p_nombre_nuevo equipo.nombre%type
)
is
begin

  if validar_equipo_nombre(p_nombre) then
    update equipo
    set nombre=p_nombre_nuevo
    where nombre=p_nombre;

    else
    dbms_output.put_line('El equipo no existe');
    end if;
    exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END cambiar_nomre_equipo;


begin
cambiar_nomre_equipo('asf','sdagasdg');
end;

select * from EQUIPO;



/*PROCEDIMIENTO ENTRENADORES*/

/*FUNCION PARA COMPROBAR SI EXISTE EL EQUIPO AL QUE SE QUIERE AÑADIR EL ENTRENADOR*/
create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;


/*FUNCION PARA COMPROBAR QUE UN ENTRENADOR EXISTE*/
create or replace function validar_entrenador
(p_entrenador in number)
return boolean
is
  v_idEntrenador number;
begin
  select id_entrenador into v_idEntrenador
  from entrenador
  where entrenador.id_entrenador = p_entrenador;
return true;
exception
  when no_data_found then 
    return false;
end validar_entrenador;

/*PROCEDIMIENTO PARA AÑADIR ENTRENADORES*/
create or replace procedure nuevo_entrenador
(
p_dni entrenador.dni%type,
p_nombre entrenador.nombre%type,
p_telefono entrenador.telefono%type,
p_direccion entrenador.direccion%type,
p_id_equipo entrenador.id_equipo%type,
p_sueldo entrenador.sueldo%type
)
is
begin
  if validar_entrenador(p_id_equipo)then

     insert into entrenador
     (DNI,NOMBRE,TELEFONO,DIRECCION,ID_EQUIPO,SUELDO)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo,
               p_sueldo);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_entrenador;

/*PRUEBO CON UN NUMERO DE EQUIPO QUE EXISTE*/
begin
  nuevo_entrenador('28403035P','Logan Miller','643455403','3 Carrs Close- Prudhoe',10,9863);
end;
SELECT NOMBRE
FROM ENTRENADOR;

/*PRUEBO CON UN NUMERO DE EQUIPO QUE NO EXISTE*/
begin
  nuevo_jugador('28403035P','Logan Miller','643455403','3 Carrs Close- Prudhoe',10,'mote',9863,1);
end;



/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN ENTRENADOR*/
create or replace procedure cambio_equipo_entrenador
(
p_idEntrenador entrenador.id_entrenador%type,
p_idEquipoNuevo entrenador.id_equipo%type
)
is
begin
 if validar_entrenador(p_idEntrenador) then
    if validar_equipo(p_idEquipoNuevo)then
      update entrenador
      set id_equipo = p_idEquipoNuevo
      where id_entrenador = p_idEntrenador;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El entrenador no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo_entrenador;   


begin
cambio_equipo_entrenador(18,3);
end;

select id_entrenador, nombre, id_equipo
from entrenador;


/*ENTRENADOR NO EXISTE*/
begin
cambio_equipo_entrenador(20,3);
end;

/*EQUIPO NO EXISTE*/
begin
cambio_equipo_entrenador(18,7);
end;




/*PROCEDIMIENTO PARA BORRAR ENTRENADOR*/
create or replace procedure borrar_entrenador
(
p_idEntrenador entrenador.id_entrenador%type
)
is
begin
  if validar_entrenador(p_idEntrenador) then
   delete from entrenador
   where id_entrenador = p_idEntrenador;
   
   else
        dbms_output.put_line ('El entrenador no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_entrenador;  


/*PRUEBO CON UN ID QUE EXISTE*/
begin
  borrar_entrenador(22);
end;
SELECT NOMBRE
FROM ENTRENADOR;


/*PRUEBO CON UN ID QUE NO EXISTE*/
begin
  borrar_entrenador(26);
end;

select id_entrenador, nombre, id_equipo
from entrenador;





/*FUNCION PARA COMPROBAR SI EXISTE EL EQUIPO AL QUE SE QUIERE AÑADIR EL JUGADOR*/
create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;


/*PROCEDIMIENTO datos equipo*/
create or replace procedure datos_equipo
(
p_id_equipo equipo.cod_equipo%type,
p_nombre_entrenador out entrenador.nombre%type,
p_nombre_asistente out asistente.nombre%type,
p_nombre_dueno out dueno.nombre%type,
p_nombre_jugador out jugador.nombre%type
)
is
begin
if validar_equipo(p_id_equipo) then
  
  select nombre into p_nombre_dueno
  from dueno
  where id_equipo=p_id_equipo;

  select nombre into p_nombre_entrenador
  from entrenador
  where id_equipo=p_id_equipo;

  select nombre into p_nombre_asistente
  from asistente
  where id_equipo=p_id_equipo;

  select nombre into p_nombre_jugador
  from jugador
  where id_equipo=p_id_equipo;


  else
  dbms_output.put_line('EL EQUIPO NO EXISTE');

  end if;
end datos_equipo; 

declare
entr entrenador.nombre%type;
asis asistente.nombre%type;
due dueno.nombre%type;
    
jug jugador.nombre%type;
begin
datos_equipo(1,entr,asis,due,jug);
dbms_output.put_line(entr);
end;

/*PROCEDIMIENTO JUGADORES*/
/*FUNCION PARA COMPROBAR SI EXISTE EL EQUIPO AL QUE SE QUIERE A�ADIR EL JUGADOR*/
create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;
/*FUNCION PARA COMPROBAR QUE UN JUGADOR EXISTE*/
create or replace function validar_jugador
(p_jugador in number)
return boolean
is
  v_idJugador number;
begin
  select id_jugador into v_idJugador
  from jugador
  where jugador.id_jugador = p_jugador;
return true;
exception
  when no_data_found then 
    return false;
end validar_jugador;


/*PROCEDIMIENTO PARA A�ADIR JUGADORES*/
create or replace procedure nuevo_jugador
(
p_dni jugador.dni%type,
p_nombre jugador.nombre%type,
p_telefono jugador.telefono%type,
p_direccion jugador.direccion%type,
p_id_equipo jugador.id_equipo%type,
p_nickname jugador.nickname%type,
p_sueldo jugador.sueldo%type,
p_id_rol jugador.id_rol%type
)
is
begin
  if validar_equipo(p_id_equipo)then

     insert into jugador
     (DNI,NOMBRE,TELEFONO,DIRECCION,ID_EQUIPO,NICKNAME,SUELDO,ID_ROL)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo,p_nickname,
               p_sueldo,p_id_rol);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_jugador;
/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN JUGADOR*/
create or replace procedure cambio_equipo
(
p_idJugador jugador.id_jugador%type,
p_idEquipoNuevo jugador.id_equipo%type
)
is
begin
 if validar_jugador(p_idJugador) then
    if validar_equipo(p_idEquipoNuevo)then
      update jugador
      set id_equipo = p_idEquipoNuevo
      where id_jugador = p_idJugador;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El jugador no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo;   

/*PROCEDIMIENTO PARA BORRAR JUGADORES*/
create or replace procedure borrar_jugador
(
p_idJugador jugador.id_jugador%type
)
is
begin
  if validar_jugador(p_idJugador) then
   delete from jugador
   where id_jugador = p_idJugador;
   
   else
        dbms_output.put_line ('El jugador no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_jugador; 

/*PROCEDIMIENTOS ASISTENTES*/

/*FUNCION PARA COMPROBAR SI EXISTE EL EQUIPO AL QUE SE QUIERE A�ADIR EL ASISTENTE*/
create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;

/*FUNCION PARA COMPROBAR QUE UN JUGADOR EXISTE*/
create or replace function validar_asistente
(p_asistente in number)
return boolean
is
  v_idAsistente number;
begin
  select id_asistente into v_idAsistente
  from asistente
  where asistente.id_asistente = p_asistente;
return true;
exception
  when no_data_found then 
    return false;
end validar_asistente;
   
create or replace procedure nuevo_asistente
(
p_dni asistente.dni%type,
p_nombre asistente.nombre%type,
p_telefono asistente.telefono%type,
p_direccion asistente.direccion%type,
p_id_equipo equipo.cod_equipo%type,
p_sueldo asistente.sueldo%type
)
is
begin
  if validar_equipo(p_id_equipo)then
   insert into asistente
   (dni,nombre,telefono,direccion,sueldo) values
   (p_dni,p_nombre,p_telefono,p_direccion,p_sueldo);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
 exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_asistente;  
/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN ASISTENTE*/
create or replace procedure cambio_equipo
(
p_idAsistente asistente.id_asistente%type,
p_idEquipoNuevo equipo.cod_equipo%type
)
is
begin
 if validar_asistente(p_idAsistente) then
    if validar_equipo(p_idEquipoNuevo)then
      update equipo
      set id_asistente =  p_idAsistente
      where cod_equipo = p_idEquipoNuevo;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El asistente no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo; 
/*PROCEDIMIENTO PARA BORRAR ASISTENTE*/
create or replace procedure borrar_asistente
(
p_idAsistente asistente.id_asistente%type
)
is
begin
  if validar_asistente(p_idAsistente) then
   delete from asistente
   where id_asistente = p_idAsistente;
   
   else
        dbms_output.put_line ('El asistente no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_asistente; 

create or replace procedure obtenerClasificacion
(
c_resultado out tcursor
)
as
v_codError number;
v_mensError varchar2(300);
e_quipoNoExiste exception;
pragma exception_init(e_quipoNoExiste, -20010);

begin


open c_resultado for 
select equipo,count(resultado) as ganados
      from resultados_temporada 
      where upper(resultado)='G' 
      group by equipo;
      
exception
when no_data_found then
 raise e_quipoNoExiste ;
when e_quipoNoExiste then
v_codError := sqlcode;
v_mensError := 'El equipo no existe';

dbms_output.put_line('ERROR: '||v_codError || v_mensError );
END;
end gestionResultados;

declare
sc_cursor  gestionResultados.tcursor;
--reg_c sc_cursor%rowtype;
v_eq varchar2(89);
v_con number(7);
begin
gestionResultados.obtenerClasificacion(sc_cursor);

/*for reg in sc_cursor loop
 dbms_output.put_line ('EQUIPO: '||reg.equipo || 'GANADOS: '|| reg.ganados);
end loop;*/


 loop
 fetch sc_cursor into v_eq,v_con;
dbms_output.put_line ('resultado: '|| v_eq ||' '|| v_con);
exit when sc_cursor%notfound;
end loop;

end;

/*PROCEDIMIENTO PARA DUENO*/

create or replace function validar_equipo
(p_equipo in number)
return boolean
is
  v_idEquipo NUMBER;
begin
  select cod_equipo into v_idEquipo
  from equipo
  where equipo.cod_equipo= p_equipo;
return true;
exception
   when no_data_found then
     return false;
end validar_equipo;


/*FUNCION PARA COMPROBAR QUE UN DUEÑO EXISTE*/
create or replace function validar_dueno
(p_dueno in number)
return boolean
is
  v_idDueno number;
begin
  select id_dueno into v_idDueno
  from dueno
  where dueno.id_dueno = p_dueno;
return true;
exception
  when no_data_found then 
    return false;
end validar_dueno;


/*PROCEDIMIENTO PARA AÑADIR DUEÑO*/
create or replace procedure nuevo_dueno
(
p_dni dueno.dni%type,
p_nombre dueno.nombre%type,
p_telefono dueno.telefono%type,
p_direccion dueno.direccion%type,
p_id_equipo dueno.id_equipo%type
)
is
begin
  if validar_equipo(p_id_equipo)then

     insert into dueno
     (DNI,NOMBRE,TELEFONO,DIRECCION,ID_EQUIPO)
        values(p_dni,p_nombre,p_telefono,p_direccion,p_id_equipo);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_dueno;


/*PROCEDIMIENTO PARA CAMBIAR DE EQUIPO A UN Dueño*/
create or replace procedure cambio_equipo_dueno
(
p_idDueno dueno.id_dueno%type,
p_idEquipoNuevo dueno.id_dueno%type
)
is
begin
 if validar_dueno(p_idDueno) then
    if validar_equipo(p_idEquipoNuevo)then
      update dueno
      set id_equipo = p_idEquipoNuevo
      where id_dueno = p_idDueno;
    else
      dbms_output.put_line ('El equipo no existe');
    end if;
 else
  dbms_output.put_line ('El dueno no existe');
 end if;
 exception
   when others then
      dbms_output.put_line('HA OCURRIDO UN ERROR');
end cambio_equipo_dueno;   

/*PROCEDIMIENTO PARA BORRAR DUEÑO*/
create or replace procedure borrar_dueno
(
p_idDueno dueno.id_dueno%type
)
is
begin
  if validar_dueno(p_idDueno) then
   delete from dueno
   where id_dueno = p_idDueno;
   
   else
        dbms_output.put_line ('El dueno no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_dueno;  


/*PROCEDIMIENTO JORNADA*/

/*FUNCION PARA COMPROBAR QUE UNA JORNADA EXISTE*/
create or replace function validar_jornada
(p_jornada in number)
return boolean
is
  v_idJornada number;
begin
  select num_jornada into v_idJornada
  from jornada
  where jornada.num_jornada = p_jornada;
return true;
exception
  when no_data_found then 
    return false;
end validar_jornada;


/*PROCEDIMIENTO PARA AÑADIR jornada*/
create or replace procedure nuevo_jornada
(
p_fecha jornada.fecha%type,
p_numSemana jornada.num_semana%type,
p_idCalendario jornada.id_calendario%type
)
is
begin
  if validar_jornada(p_idCalendario)then

     insert into jornada
     (FECHA,NUM_SEMANA,id_calendario)
        values(p_fecha,p_numSemana,p_idCalendario);
  else
    dbms_output.put_line ('El equipo no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END nuevo_jornada;



/*PROCEDIMIENTO PARA BORRAR jronada*/
create or replace procedure borrar_jornada(
p_numJornada jornada.num_jornada%type
)
is
begin
  if validar_jornada(p_numJornada) then
   delete from jornada
   where num_jornada = p_numJornada;
   
   else
        dbms_output.put_line ('El dueno no existe');
  end if;
  exception
   when others then
     dbms_output.put_line('HA OCURRIDO UN ERROR');
END borrar_jornada;  