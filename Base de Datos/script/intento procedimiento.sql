/*PROCEDIMIENTO OBTENER CLASIFICACION resultados_temporada*/
/*   JORNADA FECHA    SE    PARTIDO HORA      CODEQUIPO EQUIPO               RESUL
---------- -------- -- ---------- -------- ---------- -------------------- -----
         1 07/05/22 18          1 07/05/22          1 force                G    
         3 20/05/22 20          3 20/05/22          1 force                G    
         1 07/05/22 18          1 07/05/22          2 alliance             P    
         4 27/05/22 21          4 27/05/22          2 alliance             G    
         2 14/05/22 19          2 14/05/22          3 stacks               G    
         3 20/05/22 20          3 20/05/22          3 stacks               P    
         2 14/05/22 19          2 14/05/22          4 players              P    
         4 27/05/22 21          4 27/05/22          4 players              P */
         

   
select equipo, ganados
from (select equipo, count(resultado) as ganados 
      from resultados_temporada 
      where upper(resultado)='G' 
      group by equipo)
where ganados=(select max(count(resultado))
               from resultados_temporada
               where upper(resultado)='G'
               group by equipo);
               






       
    
create or replace procedure consultarClasificacion
(
p_cursor out sys_refcursor
)
as
v_error varchar2(250);
begin
open p_cursor for
 select equipo, ganados 
from (select equipo, count(resultado) as ganados 
      from resultados_temporada 
      where upper(resultado)='G' 
      group by equipo)
order by ganados desc;

exception
when others then
 raise_application_error(-200010, 'ERROR');
END consultarClasificacion;

declare
 c_clasificacion SYS_REFCURSOR;
 reg_clasificacion c_clasificacion%rowtype;
begin
 consultarClasificacion(c_clasificacion);
 fetch c_clasificacion into reg_clasificacion;
 while(c_clasificacion%found) loop
  dbms_output.put_line(reg_clasificacion.equipo ||' ' || reg_clasificacion.ganados);
  fetch c_clasificacion into reg_clasificacion;
  end loop;
end;






