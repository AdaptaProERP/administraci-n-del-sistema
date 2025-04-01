// Programa   : DPBARMSG
// Fecha/Hora : 24/06/2004 21:14:08
// Propósito  : Colocar Mensajes en la Barra de Botones
// Creado Por : Juan Navas
// Llamado por: Todas las Aplicaciones 
// Aplicación : Todas
// Tabla      : Todas

#INCLUDE "DPXBASE.CH"

PROCE MAIN(cText)
  LOCAL oFont,cFecha:="",cPeriodo,dDesde,dHasta,cDesde:="",cHasta:="",cAno:="",cUsuario
  LOCAL nLin:=0,lDown
  LOCAL aCoors:=GetCoors( GetDesktopWindow() )
  LOCAL nCol  :=38,nCol2:=38


  DEFAULT oDp:oBarSay:=NIL

  cFecha:=LEFT(ALLTRIM(CSEMANA(oDp:dFecha)),3)+;
          STRZERO(DAY(oDp:dFecha),2)+"/"+;
          LEFT(CMES(oDp:dFecha),3)+"/"+;
          RIGHT(STRZERO(YEAR(oDp:dFecha),4),2)

  dDesde:=oDp:dFchInicio
  dHasta:=oDp:dFchCierre

  // IF MONTH(dDesde)=01 // .AND. MONTH(dDesde)=01
  IF YEAR(dDesde)=YEAR(dHasta)
     cDesde:=LEFT(CMES(dDesde),3)
     cAno  :=STRZERO(YEAR(dDesde),4)
  ELSE
     cDesde:=LEFT(CMES(dDesde),3)+"/"+RIGHT(STRZERO(YEAR(dDesde),4),2)
  ENDIF

  cDesde  :=Left(CSEMANA(oDp:dFecha),3)
  cHasta  :=LEFT(DTOC(oDp:dFecha),3)+LEFT(CMES(oDp:dFecha),3)+"/"
  cAno    :=RIGHT(STRZERO(YEAR(oDp:dFecha),4),2)

  IF YEAR(dDesde)=YEAR(dHasta)
     // cPeriodo:=""+oDp:cUsuario+" "+PADR(oDp:cUsNombre,18)+"["+cDesde+"-"+cHasta+"/"+cAno+"]"
     cPeriodo:=" "+PADR(oDp:cUsNombre,18+3)+"["+cDesde+"-"+cHasta+"/"+cAno+"]"

  ELSE
     // cPeriodo:=""+oDp:cUsuario+" "+PADR(oDp:cUsNombre,15)+"["+cDesde+"-"+cHasta+"]"
     cPeriodo:=""+oDp:cUsuario+" "+PADR(oDp:cUsNombre,15+3)+"["+cDesde+"-"+cHasta+"]"
  ENDIF

  cPeriodo:=PADR(cPeriodo,57)

  DEFAULT cText:=" "+ALLTRIM(oDp:cAplica)

  oDp:cText   :=cText
  oDp:cPeriodo:=cPeriodo

  IF oDp:oBarSay=NIL 

    AEVAL(oDp:oFrameDp:oBar:aControls,{|o,n|nLin:=nLin+IF("TXB"$o:ClassName(),o:nWidth(),0) })

    lDown:=IF(nLin>(oDp:oFrameDp:oBar:nWidth()-450),.T.,.F.)

//? aCoors[4],"aCoors[4]"

    IF aCoors[4]>800
      lDown:=.T.
    ENDIF 

    IF(ValType(oDp:oBarSay)="O",oDp:oBarSay:End(),NIL)
    IF(ValType(oDp:oBarPer)="O",oDp:oBarPer:End(),NIL)


    DEFINE FONT oFont  NAME "Tahoma" SIZE 0, -12 BOLD

    IF !lDown

      @ 2,oDp:oBar:nWidth()-253 SAY oDp:oBarSay PROMPT " "+oDp:cText+" "  OF oDp:oBar;
                 COLOR oDp:nClrYellowText,oDp:nClrYellow SIZE 248,17 BORDER FONT oFont PIXEL CENTER

      DEFINE FONT oFont  NAME "Tahoma" SIZE 0, -12 BOLD

      @20,oDp:oBar:nWidth()-253 SAY oDp:oBarPer PROMPT " "+oDp:cPeriodo+" "  OF oDp:oBar;
                 COLOR oDp:nClrLabelText,oDp:nClrLabelPane SIZE 248,17 BORDER FONT oFont RIGHT PIXEL

     ELSE

       nCol  :=45.5 // 01/04/2024
       nCol2 :=nCol

       IF oDp:oBar:nHeight()>90
          nCol :=50+1
          nCol2:=68+1
       ENDIF
  
       @nCol,oDp:oBar:nWidth()-IF(nCol>=48,253,510) SAY oDp:oBarSay PROMPT " "+oDp:cText+" "  OF oDp:oBar;
                 COLOR oDp:nClrYellowText,oDp:nClrYellow SIZE 248,17 BORDER FONT oFont PIXEL CENTER


       DEFINE FONT oFont  NAME "Tahoma" SIZE 0, -12 BOLD

       @nCol2,oDp:oBar:nWidth()-253 SAY oDp:oBarPer PROMPT " "+oDp:cPeriodo+" "  OF oDp:oBar;
                 COLOR oDp:nClrLabelText,oDp:nClrLabelPane SIZE 248,17 BORDER FONT oFont RIGHT PIXEL



     ENDIF

      oFont:End()

  ENDIF

  IF ValType(oDp:oBarSay)="O"
    oDp:oBarSay:Refresh(.T.)
  ENDIF

  IF ValType(oDp:oBarPer)="O"
    oDp:oBarPer:Refresh(.T.)
  ENDIF

  oDp:oItemDB:SetText(oDp:cDsnData)
  oDp:oItemUs:SetText(oDp:cUsuario)

RETURN .T.
// EOF
