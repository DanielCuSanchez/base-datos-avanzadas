
--PRODUCTOS
create or replace PROCEDURE ACTUALIZA_PRODUCTO AS
BEGIN
  insert into d_producto
  select seq_d_producto.nextval, codproducto, descripcion, razonsocial
  from v_catalogoproductos CP, v_catalogoproveedores CV
  where CP.rfCProveedor = CV.rfcproveedor
  and CP.codproducto not in (select codproducto from d_producto);
commit;
END ACTUALIZA_PRODUCTO;

--UBICACION

create or replace PROCEDURE ACTUALIZA_UBICACION AS
BEGIN
  insert into dwa01703613.d_ubicacion (dubipk, region, codsucursal)
  select dwa01703613.seq_d_ubicacion.nextval,region, codsucursal
  from dwa01703613.v_catalogosucursales cs
  where cs.codsucursal not in (select codsucursal from dwa01703613.d_ubicacion);
commit;
END ACTUALIZA_UBICACION;

--VENTAS

create or replace PROCEDURE ACTUALIZA_VENTAS
(
  FECHAINICIAL IN DATE,
  FECHAFINAL IN DATE
)
AS
vFechaInicial date;
vFechaFinal date;
vdProPk number;
vdTiempoPk number;
vdUbiPk number;
v_cantidad number;
v_ingresos number;
cursor c_tiempo is
select dtiempopk
from dwa01703613.d_tiempo
where fecha BETWEEN vFechaInicial and vFechaFinal;

cursor c_ventas is
select DPO.dprodpk, DUB.dubipk, TI.dtiempopk, SUM(VE.cantidad), SUM(VE.cantidad * VE.precio)
from a01703613.ventas VE, dwa01703613.d_producto DPO, dwa01703613.d_tiempo TI, dwa01703613.d_ubicacion DUB
where VE.codproducto = DPO.codproducto
and VE.codsucursal = DUB.codsucursal
and TRUNC (VE.fechahora) = TI.fecha
group by DPO.dprodpk, DUB.dubipk, TI.dtiempopk;

BEGIN

  vFechaInicial := FECHAINICIAL;
  vFechaFinal := FECHAFINAL;

  open c_tiempo;
  LOOP
    fetch c_tiempo into vdTiempoPk;
    exit when c_tiempo%NOTFOUND;
    delete from dwa01703613.h_ventas where dtiempopk=vdTiempoPk;
    commit;
  END LOOP;
  close c_tiempo;

  open c_ventas;
  LOOP
    fetch c_ventas into vdProPk, vdUbiPk, vdTiempoPk, v_cantidad, v_ingresos;
    exit when c_ventas%NOTFOUND;
    insert into dwa01703613.h_ventas (hventaspk,dprodpk,dubipk,dtiempopk,cantidad,ingresos)
    values (dwa01703613.seq_h_ventas.nextval, vdProPk, vdUbiPk, vdTiempoPk, v_cantidad, v_ingresos);
    commit;
  END LOOP;
  close c_ventas;

END ACTUALIZA_VENTAS;

