create or replace package body gestionResultados as
procedure obtenerClasificacion
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

set SERVEROUTPUT ON;