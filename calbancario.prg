// Programa   : CALBANCARIO
// Fecha/Hora : 05/01/2019 16:34:16
// Propósito  : Calendario Bancaria
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(dFecha)
  LOCAL nAno,aFechas:={},aData:={}

  DEFAULT dFecha:=oDp:dFecha

  nAno:=YEAR(dFecha)

  IF nAno=2019
     aData:=EJECUTAR("CALBANCARIO2019",.T.,dFecha)
  ENDIF

  oDp:aCalBancarios:={}

  oDp:aCalBancario2019:=EJECUTAR("CALBANCARIO2019",.F.)
  oDp:aCalBancario2024:=EJECUTAR("CALBANCARIO2024",.F.)

  AEVAL(oDp:aCalBancario2019,{|a,n|AADD(oDp:aCalBancarios,a)})
  AEVAL(oDp:aCalBancario2024,{|a,n|AADD(oDp:aCalBancarios,a)})

//  ViewArray(oDp:aCalBancarios)

  AEVAL(aData,{|a,n| aData[n]:=a[1]})

RETURN aData
// EOF
