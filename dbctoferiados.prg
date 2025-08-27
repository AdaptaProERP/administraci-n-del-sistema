// Programa   : DBCTOFERIADOS                
// Fecha/Hora : 27/08/2025 04:37:19
// Propósito  : Crear registro DBC DPHISMON Feriados y fines de semama 
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(nAno,cCodMon)
  LOCAL cSql:="",aData:={},I,dFecha,aFchBco:={},nAt,aDivisa:={},aNew:={},oTable,oDb:=OpenOdbc(oDp:cDsnData),cSql
 

  DEFAULT nAno   :=YEAR(oDp:dFecha)-1,;
          cCodMon:=oDp:cMonedaExt

  EJECUTAR("CALBANCARIO")

  AEVAL(oDp:aCalBancarios,{|a,n| IF(YEAR(a[1])=nAno,AADD(aFchBco,a[1]),NIL)})

  AEVAL(aFchBco,{|a,n| aFchBco[n]:=CTOO(a,"D")})

  cSql:=[ SELECT HMN_FECHA,HMN_VALOR FROM dphismon WHERE HMN_CODIGO]+GetWhere("=",cCodMon)+[ AND ]+;
        [ YEAR(HMN_FECHA)]+GetWhere("=",nAno)+[ OR YEAR(HMN_FECHA)]+GetWhere("=",nAno+1)+[ ORDER BY HMN_FECHA ]

  aDivisa:=ASQL(cSql)

  cSql   :=[ SELECT DIA_FECHA FROM dpdiario ]+;
           [ LEFT JOIN dphismon ON HMN_CODIGO]+GetWhere("=",cCodMon)+[ AND DIA_FECHA=HMN_FECHA]+;
           [ WHERE DIA_ANO]+GetWhere("=",nAno)+[ AND HMN_FECHA IS NULL ORDER BY DIA_FECHA]

  aData:=ATABLE(cSql) // Dias faltantes

  AEVAL(aData,{|a,n| aData[n]:=CTOO(a,"D")})

  FOR I=1 TO LEN(aData)
    
     // Si es Feriado
     nAt:=ASCAN(aFchBco,aData[I])

     IF nAt>0
        // Busca el dia siguiente valor de la Divisa         
        nAt:=ASCAN(aDivisa,{|a,n| a[1]>aData[I]})

        IF nAt>0
          AADD(aNew,{aData[I],aDivisa[nAt,2]})
        ENDIF

     ELSE

        // Sábado o Domingo
        IF DOW(aData[I])=1 .OR. DOW(aData[I])=7

           nAt:=ASCAN(aDivisa,{|a,n| a[1]>aData[I]})

           IF nAt>0
             AADD(aNew,{aData[I],aDivisa[nAt,2]})
           ENDIF

        ENDIF
	
     ENDIF

  NEXT I

  IF !Empty(aNew)

   oTable:=INSERTINTO("DPHISMON",oDb,100)
 
   FOR I=1 TO LEN(aNew)
     oTable:AppendBlank()
     oTable:Replace("HMN_CODIGO",cCodMon)
     oTable:Replace("HMN_FECHA" ,aNew[I,1])
     oTable:Replace("HMN_HORA"  ,"00:00:00")
     oTable:Replace("HMN_VALOR" ,aNew[I,2])
     oTable:Commit()
   NEXT I
        
   oTable:End()

   // EJECUTAR("UNIQUETABLAS","DPHISMON","HMN_CODIGO,HMN_FECHA,HMN_HORA")

  ENDIF

RETURN .T.
// EOF
