create or replace PACKAGE gestionResultados as
type tcursor is ref Cursor;
procedure obtenerClasificacion
(
c_resultado out tcursor
);
end gestionResultados;

/*cursor c_resultados is
select equipo, ganados 
from (select equipo, count(resultado) as ganados 
      from resultados_temporada 
      where upper(resultado)='G' 
      group by equipo);
*/
/*if c_resultados%notFound then
  raise e_quipoNoExiste;
  
else
  for reg in c_resultados
loop
 dbms_output.put_line(reg.equipo || ' ' || reg.ganados); 
 end loop;
end if;  
*/
