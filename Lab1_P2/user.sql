CREATE OR REPLACE PROCEDURE PDIMTIEMPOFECHA (FechaInicial in DATE, FechaFinal in DATE) AS
  vFechaInicial date;
  vFechaFinal date;
  v_numdias number;
  v_Anio varchar2(4);
  VMes varchar2(10);
  vDia number;
  vNDia varchar2(20);
  BEGIN
    vFechaInicial :=To_Date('01/01/22','DD,MM,YY');
    vFechaFinal := To_Date('08/04/22','DD,MM,YY');
    v_numdias := vFechaFinal - vFechaInicial;
    for contador in 1..v_numdias
    LOOP
      v_Anio := to_char(vFechaInicial, 'YY') ;
      vMes := to_char(vFechaInicial, 'MM');
      vDia := to_number(to_char(vFechaInicial, 'DD'));
      vNDia:= to_char(vFechaInicial, 'FMDAY');
    insert into D_TIEMPO values (contador, vFechaInicial,v_Anio,vMes,VDia,vNDia);
      vFechaInicial := vFechaInicial + 1;
    commit;
  END LOOP;
END PDIMTIEMPOFECHA;
