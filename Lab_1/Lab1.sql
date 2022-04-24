-- Creación de Rol
CREATE ROLE ALUMNO NOT IDENTIFIED;
-- System privileges granted to ALUMNO
GRANT CREATE MATERIALIZED VIEW TO ALUMNO;
GRANT SELECT ANY DICTIONARY TO ALUMNO;
-- Roles granted to ALUMNO
GRANT CONNECT TO ALUMNO;
GRANT CREATE SESSION TO ALUMNO;
GRANT GATHER_SYSTEM_STATISTICS TO ALUMNO;
GRANT RESOURCE TO ALUMNO;
GRANT SELECT_CATALOG_ROLE TO ALUMNO;
-- Creación de usuario en este caso cambia
-- TuUsuario por tu matricula, ejemplo: A00250584
-- TuContraseña les sugiero dejen “oracle”
CREATE USER A01703613 IDENTIFIED BY "oracle"
PROFILE DEFAULT;
-- Otorgar permisos a A01703613, de la misma
-- manera cámbialo por tu matricula
GRANT ALUMNO TO A01703613;
-- Asignar el rol default al usuario
ALTER USER A01703613 DEFAULT ROLE ALL;
-- Quitar restriccion de espacio en tablespace de usuario
ALTER USER A01703613 QUOTA UNLIMITED ON USERS;