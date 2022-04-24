
-- "Set define off" turns off substitution variables.
Set define off; 


--
-- SEQ_D_PRODUCTO  (Sequence) 
--
CREATE SEQUENCE SEQ_D_PRODUCTO
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--
-- SEQ_D_TIEMPO  (Sequence) 
--
CREATE SEQUENCE SEQ_D_TIEMPO
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--
-- SEQ_D_UBICACION  (Sequence) 
--
CREATE SEQUENCE SEQ_D_UBICACION
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--
-- SEQ_H_VENTAS  (Sequence) 
--
CREATE SEQUENCE SEQ_H_VENTAS
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--
-- D_PRODUCTO  (Table) 
--
--   Row Count: 0
CREATE TABLE D_PRODUCTO
(
  DPRODPK       NUMBER,
  CODPRODUCTO   CHAR(10 BYTE),
  DESCPRODUCTO  VARCHAR2(50 BYTE),
  NOMPROVEEDOR  VARCHAR2(50 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- D_PRODUCTO_PK  (Index) 
--
--  Dependencies: 
--   D_PRODUCTO (Table)
--
CREATE UNIQUE INDEX D_PRODUCTO_PK ON D_PRODUCTO
(DPRODPK)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE D_PRODUCTO ADD (
  CONSTRAINT D_PRODUCTO_PK
  PRIMARY KEY
  (DPRODPK)
  USING INDEX D_PRODUCTO_PK
  ENABLE VALIDATE);



--
-- D_TIEMPO  (Table) 
--
--   Row Count: 0
CREATE TABLE D_TIEMPO
(
  DTIEMPOPK  NUMBER                             NOT NULL,
  FECHA      DATE                               NOT NULL,
  ANIO       VARCHAR2(4 BYTE)                   NOT NULL,
  MES        VARCHAR2(10 BYTE)                  NOT NULL,
  DIA        NUMBER                             NOT NULL,
  NOMBREDIA  VARCHAR2(10 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- D_TIEMPO_PK  (Index) 
--
--  Dependencies: 
--   D_TIEMPO (Table)
--
CREATE UNIQUE INDEX D_TIEMPO_PK ON D_TIEMPO
(DTIEMPOPK)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE D_TIEMPO ADD (
  CONSTRAINT D_TIEMPO_PK
  PRIMARY KEY
  (DTIEMPOPK)
  USING INDEX D_TIEMPO_PK
  ENABLE VALIDATE);



--
-- D_UBICACION  (Table) 
--
--   Row Count: 0
CREATE TABLE D_UBICACION
(
  DUBIPK       NUMBER,
  REGION       VARCHAR2(10 BYTE),
  CODSUCURSAL  CHAR(5 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- D_UBICACION_PK  (Index) 
--
--  Dependencies: 
--   D_UBICACION (Table)
--
CREATE UNIQUE INDEX D_UBICACION_PK ON D_UBICACION
(DUBIPK)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE D_UBICACION ADD (
  CONSTRAINT D_UBICACION_PK
  PRIMARY KEY
  (DUBIPK)
  USING INDEX D_UBICACION_PK
  ENABLE VALIDATE);



--
-- H_VENTAS  (Table) 
--
--  Dependencies: 
--   D_PRODUCTO (Table)
--   D_UBICACION (Table)
--   D_TIEMPO (Table)
--
--   Row Count: 0
CREATE TABLE H_VENTAS
(
  HVENTASPK  NUMBER,
  DPRODPK    NUMBER,
  DUBIPK     NUMBER,
  DTIEMPOPK  NUMBER,
  CANTIDAD   NUMBER,
  INGRESOS   NUMBER
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


--
-- H_VENTAS_PK  (Index) 
--
--  Dependencies: 
--   H_VENTAS (Table)
--
CREATE UNIQUE INDEX H_VENTAS_PK ON H_VENTAS
(HVENTASPK)
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE H_VENTAS ADD (
  CONSTRAINT H_VENTAS_PK
  PRIMARY KEY
  (HVENTASPK)
  USING INDEX H_VENTAS_PK
  ENABLE VALIDATE);




--
-- ACTUALIZA_PRODUCTO  (Procedure) 
--
--  Dependencies: 
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--
CREATE OR REPLACE PROCEDURE ACTUALIZA_PRODUCTO AS 
BEGIN
  --codigo
  commit;
END ACTUALIZA_PRODUCTO;

/


--
-- ACTUALIZA_UBICACION  (Procedure) 
--
--  Dependencies: 
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--
CREATE OR REPLACE PROCEDURE ACTUALIZA_UBICACION AS 
BEGIN
  --codigo
  commit; 
END ACTUALIZA_UBICACION;

/


--
-- ACTUALIZA_VENTAS  (Procedure) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--
CREATE OR REPLACE PROCEDURE ACTUALIZA_VENTAS 
(
  FECHAINICIAL IN DATE  
, FECHAFINAL IN DATE  
) AS 
  vFechaInicial date;
  vFechaFinal   date;
  vdProPk       number;
  vdTiempoPk    number;
  vdUbiPk       number;
  v_cantidad    number;
  v_ingresos    number;

  --cursor c_tiempo is
  --codigo select

  --cursor c_ventas is
  -- codigo select


BEGIN
  --codigo
  commit; --eliminar
END ACTUALIZA_VENTAS;

/


--
-- PDIMTIEMPO  (Procedure) 
--
--  Dependencies: 
--   D_TIEMPO (Table)
--   SEQ_D_TIEMPO (Sequence)
--   STANDARD (Package)
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--
CREATE OR REPLACE PROCEDURE PDIMTIEMPO (FechaInicial in date, FechaFinal in date) AS 
vFechaInicial date;
vFechaFinal date;
v_numdias  number;
vAnio      varchar2(4);
vMes       varchar2(10);
vDia       number;
vNDia      varchar2(20);

BEGIN
  vFechaInicial := FechaInicial;
  vFechaFinal := FechaFinal;
  v_numdias := vFechaFinal - vFechaInicial;

  for contador in 1..v_numdias
  LOOP
  vAnio := to_char(vFechaInicial, 'YYYY');
  vMes  := to_char(vFechaInicial, 'MONTH');
  vDia  := to_number(to_char(vFechaInicial,'DD'));
  vNDia := to_char(vFechaInicial,'FMDAY');
  insert into d_tiempo values (seq_d_tiempo.nextval, vFechaInicial, vAnio, vMes, vDia,vNDia);
  commit;
  vFechaInicial := vFechaInicial+1;
  END LOOP;

END PDIMTIEMPO;

/


ALTER TABLE H_VENTAS ADD (
  CONSTRAINT H_VENTAS_FK1 
  FOREIGN KEY (DPRODPK) 
  REFERENCES D_PRODUCTO (DPRODPK)
  ENABLE VALIDATE);

ALTER TABLE H_VENTAS ADD (
  CONSTRAINT H_VENTAS_FK2 
  FOREIGN KEY (DUBIPK) 
  REFERENCES D_UBICACION (DUBIPK)
  ENABLE VALIDATE);

ALTER TABLE H_VENTAS ADD (
  CONSTRAINT H_VENTAS_FK3 
  FOREIGN KEY (DTIEMPOPK) 
  REFERENCES D_TIEMPO (DTIEMPOPK)
  ENABLE VALIDATE);


--- Creación de vistas, AJUSTAR EL esquema AL DE CADA UNO DE USTEDES----

--
-- CATALOGOPRODUCTOS  (View) 
--
CREATE OR REPLACE FORCE VIEW V_CATALOGOPRODUCTOS
(CODPRODUCTO, DESCRIPCION, RFCPROVEEDOR, PRECIO, INVENTARIOMIN)
AS 
select "CODPRODUCTO","DESCRIPCION","RFCPROVEEDOR","PRECIO","INVENTARIOMIN" from A01703613.catalogoproductos;



--
-- CATALOGOPROVEEDORES  (View) 
--
CREATE OR REPLACE FORCE VIEW V_CATALOGOPROVEEDORES
(RFCPROVEEDOR, RAZONSOCIAL, DIRECCIONFISCAL)
AS 
select "RFCPROVEEDOR","RAZONSOCIAL","DIRECCIONFISCAL" from A01703613.catalogoproveedores;


--
-- CATALOGOSUCURSALES  (View) 
--
CREATE OR REPLACE FORCE VIEW V_CATALOGOSUCURSALES
(CODSUCURSAL, DIRECCION, REGION, RESPONSABLE, CODIGOPOSTAL)
AS 
select  "CODSUCURSAL","DIRECCION","REGION","RESPONSABLE","CODIGOPOSTAL" from A01703613.catalogosucursales;


--
-- VENTAS  (View) 
--
CREATE OR REPLACE FORCE VIEW V_VENTAS
(CODPRODUCTO, CODSUCURSAL, FECHAHORA, CANTIDAD, PRECIO)
AS 
select "CODPRODUCTO","CODSUCURSAL","FECHAHORA","CANTIDAD","PRECIO" from A01703613.ventas;