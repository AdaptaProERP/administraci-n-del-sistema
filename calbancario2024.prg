// Programa   : CALBANCARIO2024 
// Fecha/Hora : 26/10/2024 11:34:08
// Prop�sito  : Calendario Bancario 2019
// Creado Por :
// Llamado por:
// Aplicaci�n :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(lSave)
 LOCAL aData:={},oTable

 DEFAULT lSave:=.T.

 AADD(aData,{"01/01/2024","A�o Nuevo "})
 AADD(aData,{"06/01/2024","D�a de Reyes"})
 AADD(aData,{"12/02/2024","Carnaval "})
 AADD(aData,{"14/01/2024","D�a de la Divina Pastora"})
 AADD(aData,{"13/02/2024","Carnaval"})
 AADD(aData,{"19/03/2024","D�a de San Jos�"})
 AADD(aData,{"28/03/2024","Semana Santa"})
 AADD(aData,{"13/05/2024","Ascensi�n del Se�or"})
 AADD(aData,{"29/03/2024","Semana Santa "})
 AADD(aData,{"19/04/2024","Declaraci�n de la Independencia "})
 AADD(aData,{"03/06/2024","Corpus Christi"})
 AADD(aData,{"01/05/2024","D�a del Trabajador "})
 AADD(aData,{"24/06/2024","Batalla de Carabobo "})
 AADD(aData,{"17/06/2024","D�a de San Antonio "})
 AADD(aData,{"05/07/2024","D�a de la Independencia  "})
 AADD(aData,{"24/07/2024","Natalicio del Libertador "})
 AADD(aData,{"29/06/2024","D�a de San Pedro y San Pablo"})
 AADD(aData,{"12/10/2024","D�a de la Resistencia Ind�gena "})
 AADD(aData,{"19/08/2024","Asunci�n de Nuestra Se�ora"})
 AADD(aData,{"16/09/2024","D�a de la Virgen de Coromoto"})
 AADD(aData,{"31/12/2024","Feriado Nacional "})
 AADD(aData,{"26/10/2024","D�a de Jos� Gregorio Hern�ndez"})
 AADD(aData,{"04/11/2024","D�a de todos los Santos "})
 AADD(aData,{"18/11/2024","D�a de la Virgen del Rosario de Chiquinquir�"})
 AADD(aData,{"08/12/2024","D�a de la Inmaculada Concepci�n"})
 AADD(aData,{"24/12/2024","Feriado Nacional "})
 AADD(aData,{"25/12/2024","Natividad de Nuestro Se�or "})

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


