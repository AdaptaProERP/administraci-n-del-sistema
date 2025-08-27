// Programa   : DBCFROMTXT
// Fecha/Hora : 07/08/2025 09:11:26
// Propósito  : Importar el valor de la divisa desde el BCV
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
 LOCAL cFile:="DP\BCV.TXT"
 LOCAL cMemo:=STRTRAN(MEMOREAD(cFile),CRLF,CHR(10))
 LOCAL aData:=_VECTOR(cMemo,CHR(10))
 LOCAL oTable,oDb:=OpenOdbc(oDp:cDsnData)
 LOCAL dDesde,dHasta,aDBC:={},nAt,I

 IF Empty(aData)
    RETURN .F.
 ENDIF

 AEVAL(aData,{|a,n| aData[n]:=_VECTOR(a,";")})

 AEVAL(aData,{|a,n| aData[n,1]:=CTOO(a[1],"N"),;
                    aData[n,2]:=CTOO(a[2],"D") })

 dDesde:=aData[1,2]
 dHasta:=aData[LEN(aData),2]

 AEVAL(aData,{|a,n| dDesde:=MIN(dDesde,a[2]),;
                    dHasta:=MAX(dHasta,a[2])})

 aDBC:=ASQL([SELECT HMN_FECHA FROM DPHISMON WHERE HMN_CODIGO="DBC" AND ]+GetWhereAnd("HMN_FECHA",dDesde,dHasta)+[ ORDER BY HMN_FECHA ])

 oTable:=INSERTINTO("DPHISMON",oDb,100)
 
 FOR I=1 TO LEN(aData)

    nAt:=ASCAN(aDBC,{|a,n| a[1]==aData[I,2]})

    IF nAt=0
       oTable:AppendBlank()
       oTable:Replace("HMN_CODIGO","DBC")
       oTable:Replace("HMN_FECHA" ,aData[I,2])
       oTable:Replace("HMN_VALOR" ,aData[I,1])
       oTable:Commit()
    ENDIF

 NEXT I
                
 oTable:End()

//ViewArray(aData)

RETURN .T.
// EOF
