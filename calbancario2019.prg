// Programa   : CALBANCARIO2019  
// Fecha/Hora : 26/10/2018 11:34:08
// Propósito  : Calendario Bancario 2019
// Creado Por :
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(lSave)
 LOCAL aData:={},oTable

 SQLUPDATE("dpcampos","CAM_LEN",1,[CAM_TYPE="L" AND CAM_LEN>1])

 DEFAULT lSave:=.T.

 AADD(aData,{"05/11/2018","Jueves 1 de noviembre: Día de Todos los Santoss"})
 AADD(aData,{"06/01/2019","Reyes"})
 AADD(aData,{"19/03/2019","Día de San José"})
 AADD(aData,{"03/06/2019","Jueves 30 de mayo , Ascensión del Señor"})
 AADD(aData,{"17/06/2019","Jueves 13 de junio, Día de San Antonio "})
 AADD(aData,{"24/06/2019","Jueves 20 de junio, Corpus Christi"     })
 AADD(aData,{"29/06/2019","Día de San Pedro y San Pablo (No se ejecuta feriado por ser fin de semana)"})
 AADD(aData,{"19/08/2019","Jueves 15 de agosto: Asunción de Nuestra Señora"})
 AADD(aData,{"16/09/2019","Miércoles 11 de septiembre: Día de la Virgen de Coromoto patrona de Venezuela"})
 AADD(aData,{"12/10/2019","Día de la Resistencia"})
 AADD(aData,{"04/11/2019","Viernes 1 de noviembre: Día de Todos los Santos"})
 AADD(aData,{"08/12/2019","Día de la Inmaculada Concepción (No se ejecuta feriado por ser fin de semana)"})

 AEVAL(aData,{|a,n| aData[n,1]:=CTOD(a[1]),AADD(aData[n],CSEMANA(a[1]))})

 IF ValType(lSave)="L" .AND. lSave

   AEVAL(aData,{|a,n,dFecha| dFecha:=a[1],;
                             SQLUPDATE("DPDIARIO","DIA_LUNBAN",.T.,"DIA_FECHA"+GetWhere("=",dFecha))})

   IF EJECUTAR("DBISTABLE",oDp:cDsnConfig,"DPLUNESBANCARIOS") .AND. COUNT("DPLUNESBANCARIOS","YEAR(LUN_FECHA)=2019")>0
      

      oTable:=OpenTable("SELECT * FROM DPLUNESBANCARIOS",.F.)
      oTable:lAuditar:=.F.
      
      AEVAL(aData,{|a,n,dFecha| dFecha:=a[1],;
                                oTable:AppendBlank(),;
                                oTable:Replace("LUN_FECHA" ,dFecha),;
                                oTable:Replace("LUN_DESCRI",a[2]  ),;
                                oTable:Commit()})

     oTable:End()
     
     
   ENDIF

 ENDIF

RETURN aData
// EOF

