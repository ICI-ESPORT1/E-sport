/*PROCEDIMIENTOS*/
/*1. PROCEDIMIENTO PARA OBTENER LA CLASIFICACION*/
desc resultados_temporada
/*Nombre    ¿Nulo?   Tipo         
--------- -------- ------------ 
JORNADA   NOT NULL NUMBER(3)    
FECHA              DATE         
SEMANA             VARCHAR2(2)  
PARTIDO   NOT NULL NUMBER(3)    
HORA               DATE         
CODEQUIPO NOT NULL NUMBER(3)    
EQUIPO             VARCHAR2(20) 
RESULTADO          VARCHAR2(5)  */

select * from resultados_temporada;

create or replace procedure resultadoUltimoPartido
(
v_resultado out varchar2,
v_equipo out varchar2
)
as
v_registro resultados_temporada%rowtype;
select * from resultados_tempora