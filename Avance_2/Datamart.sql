-- >>> Crea usuario desde usuario SYS

CREATE USER DWA01703613 IDENTIFIED BY oracle HTTP DIGEST DISABLE DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP PROFILE DEFAULT ACCOUNT UNLOCK;

GRANT ALUMNO TO DWA01703613;

ALTER USER DWA01703613 DEFAULT ROLE ALL;


ALTER USER DWA01703613 QUOTA UNLIMITED ON USERS;

grant select any table to alumno;

CREATE SEQUENCE DWA01703613.SEQ_D_TIME START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;
CREATE SEQUENCE DWA01703613.SEQ_D_CONTACTS START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.SEQ_D_EMPLOYEES START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.SEQ_D_CUSTOMERS START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.SEQ_H_CONTACTS START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.SEQ_H_SALES_EMPLOYEES  START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.SEQ_H_CUSTOMERS START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;

CREATE SEQUENCE DWA01703613.TOTAL_SALES START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE GLOBAL;


-- CREACIÓN DE TABLAS

-- DIMENSIÓN TIEMPO

create table D_TIME (
    PKDTIME NUMBER not null,
    `DATE` DATE,
    `YEAR` NUMBER
    `MONTH` VARCHAR2(10),
    `DAY` NUMBER,
    `DAYNAME` VARCHAR2(10)
)
/
create unique index D_TIME_PKDTIME_INDEX on D_TIME  (PKDTIME)
/
alter table
    D_TIME
add
    constraint D_TIME_PKDTIME primary key (PKDTIME)
/
-- DIMENSIÓN CONTACTOS
create table D_CONTACTS (
    PKDCONTACT NUMBER not null,
    CONTACT_ID NUMBER not null,
    FIRST_NAME VARCHAR2(255),
    LAST_NAME VARCHAR2(255),
    PHONE VARCHAR2(255),
    EMAIL VARCHAR2(255),
    REGION_NAME VARCHAR2(255)
)
/
create unique index D_CONTACTS_PKDCONTACT_INDEX on D_CONTACTS (PKDCONTACT)
/
alter table
    D_CONTACTS
add
    constraint D_CONTACTS_PKDCONTACT primary key (PKDCONTACT)
/

-- DIMENSIÓN EMPLEADOS
create table D_EMPLOYEES (
    PKDEMPLOYEE NUMBER not null,
    EMPLOYEE_ID NUMBER not null,
    FIRST_NAME VARCHAR2(255),
    LAST_NAME VARCHAR2(255),
    PHONE VARCHAR2(255),
    EMAIL VARCHAR2(255),
    REGION_NAME VARCHAR2(255)
)
/
create unique index D_EMPLOYEES_PKDEMPLOYEE_INDEX on D_EMPLOYEES (PKDEMPLOYEE)
/
alter table
    D_EMPLOYEES
add
    constraint D_EMPLOYEES_PKDEMPLOYEE primary key (PKDEMPLOYEE)
/

-- DIMENSIÓN CLIENTES
create table D_CUSTOMERS (
    PKDCUSTOMER NUMBER not null,
    CUSTOMER_ID NUMBER not null,
    FIRST_NAME VARCHAR2(255),
    LAST_NAME VARCHAR2(255),
    PHONE VARCHAR2(255),
    EMAIL VARCHAR2(255),
    REGION_NAME VARCHAR2(255)
)
/
create unique index D_CUSTOMERS_PKDCUSTOMER_INDEX on D_CUSTOMERS (PKDCUSTOMER)
/
alter table
    D_CUSTOMERS
add
    constraint D_CUSTOMERS_PKDCUSTOMER primary key (PKDCUSTOMER)
/

-- HECHOS CONTACTOS
create table H_CONTACTS (
    PKD_H_CONTACTS NUMBER not null,
    PKD_CONTACT NUMBER constraint H_CONTACTS_PKD_CONTACTS_D_CONTACTS_FK references D_CONTACTS
    PKD_TIME NUMBER constraint H_CONTACTS_PKD_TIME_D_TIME_FK references D_TIME,
    TOTAL_SALE NUMBER (5,2),
)
/
create unique index H_CONTACTS_PKD_H_CONTACTS_INDEX on H_CONTACTS (PKD_H_CONTACTS)
/
alter table
    H_CONTACTS
add
    constraint H_CONTACTS_PK primary key (PKD_H_CONTACTS)
/

-- HECHOS VENTAS EMPLEADOS

create table H_SALES_EMPLOYEES (
    PKD_H_SALES_EMPLOYEES NUMBER not null,
    PKD_TIME NUMBER constraint H_SALES_EMPLOYEES_PKD_TIME_D_TIME_FK references D_TIME,
    PKD_EMPLOYEE NUMBER constraint H_SALES_EMPLOYEES_PKD_EMPLOYEES_D_CONTACTS_FK references D_CONTACTS,
    SALES_UNITS NUMBER,
    TOTAL_SALE NUMBER (5,2)
)
/
create unique index H_SALES_EMPLOYEES_PKD_H_SALES_EMPLOYEES_INDEX on H_SALES_EMPLOYEES (PKD_H_SALES_EMPLOYEES)
/
alter table
    H_SALES_EMPLOYEES
add
    constraint H_SALES_EMPLOYEES_PK primary key (PKD_H_SALES_EMPLOYEES)
/


--- HECHOS CLIENTES

create table H_CUSTOMERS (
    PKD_H_CUSTOMERS NUMBER not null,
    PKD_TIME NUMBER constraint H_CUSTOMERS_PKD_TIME_D_TIME_FK references D_TIME,
    PKD_CUSTOMER NUMBER constraint H_CUSTOMERS_PKD_CUSTOMERS_D_CONTACTS_FK references D_CONTACTS,
    SALES_UNITS NUMBER,
    TOTAL_SALE NUMBER (5,2)
)
/
create unique index H_CUSTOMERS_PKD_H_CUSTOMERS_INDEX on H_CUSTOMERS (PKD_H_CUSTOMERS)
/
alter table
    H_CUSTOMERS
add
    constraint H_CUSTOMERS_PK primary key (PKD_H_CUSTOMERS)
/

-- HECHOS TOTAL DE VENTAS

create table H_TOTAL_SALES (
    PKD_H_TOTAL_SALES NUMBER not null,
    PKD_TIME NUMBER constraint H_TOTAL_SALES_PKD_TIME_D_TIME_FK references D_TIME,
    SALES_UNITS NUMBER,
    TOTAL_SALE NUMBER (5,2),
    AVERAGE_SALES_DAY NUMBER (5,2)
)
/
create unique index H_TOTAL_SALES_PKD_H_TOTAL_SALES_INDEX on H_TOTAL_SALES (PKD_H_TOTAL_SALES)
/
alter table
    H_TOTAL_SALES
add
    constraint H_TOTAL_SALES_PK primary key (PKD_H_TOTAL_SALES)
/