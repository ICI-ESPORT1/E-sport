create or replace TRIGGER jugadoresMaximoEquipo
BEFORE INSERT ON jugador
FOR EACH ROW

DECLARE
v_cantidadJugadores NUMBER;
v_codequipo NUMBER;
demasiadosJugadores EXCEPTION;
BEGIN
v_codequipo := :NEW.codequipo;

SELECT COUNT(*) INTO v_cantidadJugadores
FROM jugador
WHERE codequipo = v_codequipo;

IF(v_cantidadJugadores>6)THEN
RAISE demasiadosJugadores;
END IF;
EXCEPTION
WHEN demasiadosJugadores THEN
RAISE_APPLICATION_ERROR(-20100, 'Lo sentimos pero los Equipos solo pueden tener en Plantilla a 6 Jugadores'||SQLERRM);
END;

ALTER TRIGGER jugadoresMaximoEquipo DISABLED;