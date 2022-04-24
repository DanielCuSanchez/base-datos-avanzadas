-- Ventas de cada uno de los productos para todos los viernes del mes de FEBRERO

select descproducto as "PRODUCTO",sum(cantidad) as "CANTIDAD VENDIDA"
from d_producto dp,h_ventas hv,d_tiempo dt,d_ubicacion du
where dp.dprodpk = hv.dprodpk and dt.dtiempopk =hv.dtiempopk and du.dubipk=hv.dubipk
and dt.fecha between to_date ('01-02-2022','DD-MM-YYYY') and to_date('28-02-2022','DD-MM-YYYY')
and dt.nombredia ='FRIDAY'
group by descproducto
order by 1 asc;

-- Ventas de “Pay de Nuez” en cada sucursal

select descproducto as "PRODUCTO",du.codsucursal,sum(cantidad) as "CANTIDAD VENDIDA"
from d_producto dp,h_ventas hv,d_tiempo dt,d_ubicacion du
where dp.dprodpk = hv.dprodpk and dt.dtiempopk =hv.dtiempopk and du.dubipk=hv.dubipk
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
and dp.descproducto ='Pay de nuez'
group by descproducto, du.codsucursal
order by 1 asc;

--Ventas de “Pinguinos” en cada sucursal, pero solamente los miércoles

select descproducto as "PRODUCTO",du.codsucursal,sum(cantidad) as "CANTIDAD VENDIDA"
from d_producto dp,h_ventas hv,d_tiempo dt,d_ubicacion du
where dp.dprodpk = hv.dprodpk and dt.dtiempopk =hv.dtiempopk and du.dubipk=hv.dubipk
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
and dp.descproducto ='Pinguinos' and dt.nombredia ='WEDNESDAY'
group by descproducto, du.codsucursal
order by 1 asc;

--Ventas de TODOS los productos por sucursal y mes
select descproducto as "PRODUCTO",du.codsucursal,sum(cantidad) as "CANTIDAD VENDIDA"
from d_producto dp,h_ventas hv,d_tiempo dt,d_ubicacion du
where dp.dprodpk = hv.dprodpk and dt.dtiempopk =hv.dtiempopk and du.dubipk=hv.dubipk
and dt.fecha between to_date ('01-01-2022','DD-MM-YYYY') and to_date('01-04-2022','DD-MM-YYYY')
group by descproducto, du.codsucursal
order by 1 asc;