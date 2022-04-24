create or replace PROCEDURE ACTUALIZA_VENTAS 
(
    FECHAINICIAL IN DATE  
    , FECHAFINAL IN DATE  
)   AS 
    vFechaInicial date;
    vFechaFinal   date;
    vdProPk       number;
    vdTiempoPk    number;
    vdUbiPk       number;
    v_cantidad    number;
    v_ingresos    number;

     CURSOR c_tiempo IS
     SELECT dtiempopk
     FROM d_tiempo
     WHERE fecha BETWEEN vFechaInicial AND vFechaFinal;

    CURSOR c_ventas IS
    SELECT dpr.dprodpk, du.dubipk, dt.dtiempopk, SUM(vv.cantidad), SUM(vv.cantidad * vv.precio)
    FROM d_producto dpr, d_ubicacion du, d_tiempo dt, v_ventas vv
    WHERE dpr.codproducto = vv.codproducto
    AND du.codsucursal = vv.codsucursal
    AND dt.fecha = TRUNC (vv.fechahora)
    GROUP BY dpr.dprodpk, du.dubipk, dt.dtiempopk;


BEGIN
  
    vFechaInicial :=  FECHAINICIAL;
    vFechaFinal   :=  FECHAFINAL;
  
    OPEN c_tiempo;
    LOOP
        FETCH c_tiempo into vdTiempoPk;
        EXIT WHEN c_tiempo%NOTFOUND;
        DELETE FROM h_ventas WHERE dtiempopk = vdTiempoPk;
        commit;
    END LOOP;
    CLOSE c_tiempo;
    
    OPEN c_ventas;
    LOOP
        FETCH c_ventas into vdProPk, vdUbiPk, vdTiempoPk, v_cantidad, v_ingresos;
        EXIT WHEN c_ventas%NOTFOUND;
        INSERT INTO h_ventas (hventaspk, dprodpk, dubipk, dtiempopk, cantidad, ingresos)
        VALUES (seq_h_ventas.nextval, vdProPk, vdUbiPk, vdTiempoPk, v_cantidad, v_ingresos);
        commit;
    END LOOP;
    CLOSE c_ventas;
    
END ACTUALIZA_VENTAS;