// Programa   : BTNBARFINDHIS          
// Fecha/Hora : 21/02/2022 06:48:09
// Propósito  : Presentar Opciones Según Historial en DPAUDITORIA
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(lMenu)
   LOCAL aData,cSql,cTitle:="Opciones de Ejecución Registradas",cWhere_:=NIL
   LOCAL lHistorico:=.T.

   DEFAULT lMenu:=.F.

   IF lMenu

      cSql   :=[ SELECT MNU_TITULO,APL_TITULO,MNU_VERTIC,MNU_ACCION,COUNT(*) AS CUANTOS FROM dpauditamenu ]+;
               [ INNER JOIN dpmenu ON ADM_CODIGO=MNU_CODIGO  ]+;
               [ INNER JOIN view_dpmenuapl  ON MNU_MODULO=APL_CODIGO ]+;
               [ WHERE RIGHT(ADM_CODIGO,2)<>"00" ]+;
               [ GROUP BY ADM_CODIGO ]+;
               [ HAVING CUANTOS>1 ]+;
               [ ORDER BY CUANTOS DESC ]

     aData:=ASQL(cSql)

     AEVAL(aData,{|a,n| aData[n,1]:=GetFromVar(a[1]),;
                        aData[n,3]:=SAYOPTIONS("DPMENU","MNU_VERTIC",a[3]),;
                        aData[n,5]:=.T. })


   ELSE

     cSql :=[SELECT  AUD_CLAVE, AUD_SCLAVE,AUD_TCLAVE,AUD_CCLAVE,1 AS LOGICO FROM  dpauditoria WHERE AUD_USUARI]+GetWhere("=",oDp:cUsuario)+[ AND AUD_TIPO="BUSB" GROUP BY AUD_CLAVE,AUD_SCLAVE,AUD_TCLAVE,AUD_CCLAVE ORDER BY COUNT(*) DESC ]
     aData:=ASQL(cSql)

   ENDIF

   IF Empty(aData)
      RETURN EJECUTAR("BTNBARFINDRUN")
      lHistorico:=.F.
   ENDIF

   EJECUTAR("BTNBARFINDVIEW",aData,cTitle,cWhere_,lHistorico,lMenu)

RETURN .T.
// EOF
