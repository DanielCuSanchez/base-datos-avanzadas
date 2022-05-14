-- Contactos

-- ¿Qué contacto compro más en un periodo de tiempo?

create or replace view GET_CONTACTS_ORDERS_MAX as
select first_name, last_name
from d_contacts dp, h_contacts hc, d_time dt
where dp.PKDCONTACT = hc.PKD_CONTACT
and dt.PKDTIME =hc.PKD_TIME
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
order by 1 asc;

-- Empleados

-- ¿Cuáles fue el empleado que más ventas hizo en un periodo de tiempo?
create or replace view GET_EMPLOYEES_SALES_MAX as
select first_name, last_name
from d_employees dp, h_sales_employees hc, d_time dt
where dp.PKDCONTACT = hc.PKD_CONTACT
and dt.PKDTIME =hc.PKD_TIME
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
order by 1 asc;

-- Clientes

-- ¿Qué cliente compro más?
create or replace view GET_CUSTOMERS_ORDERS_MAX as
select first_name, last_name
from d_customers dp, h_sales_customers hc, d_time dt
where dp.PKDCONTACT = hc.PKD_CONTACT
and dt.PKDTIME =hc.PKD_TIME
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
order by 1 asc;


-- Ventas totales

-- ¿Cuánto vendí en un determinado tiempo?
create or replace view GET_H_TOTAL_SALES_MAX as
select sum(TOTAL_SALE) as "Cantidad vendida"
from d_producto dp,h_ventas hv,d_tiempo dt,d_ubicacion du
and dt.PKDTIME =hc.PKD_TIME
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
order by 1 asc;