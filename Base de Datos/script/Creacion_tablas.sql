DROP TABLE equipo CASCADE CONSTRAINTS;
DROP TABLE entrenador CASCADE CONSTRAINTS;
DROP TABLE jugador CASCADE CONSTRAINTS;
DROP TABLE asistente CASCADE CONSTRAINTS;
DROP TABLE dueno CASCADE CONSTRAINTS;
DROP TABLE rol CASCADE CONSTRAINTS;
DROP TABLE partido CASCADE CONSTRAINTS;
DROP TABLE resultado CASCADE CONSTRAINTS;
DROP TABLE jornada CASCADE CONSTRAINTS;
DROP TABLE calendario CASCADE CONSTRAINTS;
DROP TABLE fichero CASCADE CONSTRAINTS;
DROP TABLE administrador CASCADE CONSTRAINTS;
DROP TABLE grupo_usuario CASCADE CONSTRAINTS;


CREATE TABLE equipo(
cod_equipo number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT eq_cod_pk PRIMARY KEY,
nombre varchar2(20) CONSTRAINT eq_nom_un UNIQUE,
nacionalidad varchar2(50),
fecha_creacion date,
telefono number(9) CONSTRAINT eq_tel_un UNIQUE,
mail VARCHAR2(150) CONSTRAINT eq_mail_un UNIQUE,
escudo varchar2(150)
);


CREATE TABLE entrenador(
id_entrenador number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT entr_id_pk PRIMARY KEY,
dni varchar2(9) CONSTRAINT entr_dni_un UNIQUE,
nombre varchar2(50),
telefono varchar2(9) CONSTRAINT entr_tel_un UNIQUE,
direccion varchar2(50),
id_equipo number(3),
sueldo number(5) CONSTRAINT entr_suel_ck CHECK(sueldo BETWEEN 1000 AND 200000),
	CONSTRAINT entr_ideq_fk FOREIGN KEY (id_equipo)
				REFERENCES equipo(cod_equipo) ON DELETE SET NULL
);


CREATE TABLE rol(
id_rol number(2) GENERATED ALWAYS AS IDENTITY CONSTRAINT rol_id_pk PRIMARY KEY,
nombre varchar2(50) CONSTRAINT rol_nom_un UNIQUE,
descripcion varchar2(250)
);


CREATE TABLE jugador(
id_jugador number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT jug_id_pk PRIMARY KEY,
dni varchar2(9) CONSTRAINT jug_dni_un UNIQUE,
nombre varchar2(50),
telefono varchar2(9) CONSTRAINT jug_tel_un UNIQUE,
direccion varchar2(50),
id_equipo number(3),
nickname varchar2(50) CONSTRAINT jug_nick_un UNIQUE,
sueldo number(6) CONSTRAINT jug_suel_ck CHECK(sueldo BETWEEN 1000 AND 200000),
id_rol number(2),
    CONSTRAINT jug_ideq_fk FOREIGN KEY (id_equipo)
				REFERENCES equipo(cod_equipo) ON DELETE SET NULL,
    CONSTRAINT jug_idr_fk FOREIGN KEY (id_rol)
                REFERENCES rol(id_rol) ON DELETE SET NULL  
);


CREATE TABLE asistente(
id_asistente number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT asis_id_pk PRIMARY KEY,
dni varchar2(9) CONSTRAINT asis_dni_un UNIQUE,
nombre varchar2(50),
telefono varchar2(9) CONSTRAINT asis_tel_un UNIQUE,
direccion varchar2(50),
id_equipo number(3),
sueldo number(5) CONSTRAINT asis_suel_ck CHECK(sueldo BETWEEN 1000 AND 200000),
	CONSTRAINT asis_ideq_fk FOREIGN KEY (id_equipo)
				REFERENCES equipo(cod_equipo) ON DELETE SET NULL
);


CREATE TABLE dueno(
id_dueno number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT due_id_pk PRIMARY KEY,
dni varchar2(9) CONSTRAINT due_dni_un UNIQUE,
nombre varchar2(50),
telefono varchar2(9),
direccion varchar2(50),
id_equipo number(3),
    CONSTRAINT due_ideq_fk FOREIGN KEY (id_equipo)
				REFERENCES equipo(cod_equipo) ON DELETE SET NULL
);



CREATE TABLE calendario(
id_calendario number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT cal_id_pk PRIMARY KEY,
cerrado char,
temporada varchar2(3)
);

CREATE TABLE jornada(
num_jornada number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT jor_num_pk PRIMARY KEY,
fecha date,
num_semana varchar2(2) CONSTRAINT jor_nums_un UNIQUE,
id_calendario number(3),
CONSTRAINT jor_num_fk FOREIGN KEY (id_calendario)
        REFERENCES calendario(id_calendario) ON DELETE SET NULL
);


CREATE TABLE partido(
id_partido number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT part_id_pk PRIMARY KEY ,
hora date,
num_jornada number(3),
CONSTRAINT par_num_fk FOREIGN KEY (num_jornada)
        REFERENCES jornada(num_jornada) ON DELETE SET NULL
);


CREATE TABLE resultado(
id_equipo number(3),
id_partido number(3),
resultado varchar2 (5),
    CONSTRAINT res_ide_fk FOREIGN KEY (id_equipo)
        REFERENCES equipo(cod_equipo) ON DELETE SET NULL,
    CONSTRAINT res_idp_fk FOREIGN KEY (id_partido)
        REFERENCES partido(id_partido) ON DELETE SET NULL,
        CONSTRAINT res_id_pk PRIMARY KEY(id_equipo,id_partido)
);


CREATE TABLE fichero (
num_doc number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT fic_num_pk PRIMARY KEY,
nombre_clob clob,
id_calendario number(3),
CONSTRAINT fic_num_fk FOREIGN KEY (id_calendario)
        REFERENCES calendario(id_calendario) ON DELETE SET NULL
);


CREATE TABLE grupo_usuario(
id_rol number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT gru_id_pk PRIMARY KEY,
descripcion varchar2(150)
);


CREATE TABLE administrador(
id_admin number(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT adm_id_pk PRIMARY KEY,
nombre varchar2(20),
nombreusu varchar2(25) CONSTRAINT adm_usu_un UNIQUE,
apellido varchar2(20),
pass varchar(20),
id_rol number(3),
CONSTRAINT adm_id_fk FOREIGN KEY (id_rol)
        REFERENCES grupo_usuario(id_rol) ON DELETE SET NULL
);


COMMIT;