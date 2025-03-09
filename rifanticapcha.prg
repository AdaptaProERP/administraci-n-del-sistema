// Programa   : RIFANTICAPCHA
// Fecha/Hora : 25/08/2020 20:34:44
// Propósito  : Activar el Servicio de AntiCapcha, requiere Iniciación
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(cRif,lDialog,lAuto,lHide,oGet)
   LOCAL pCapCha,oScript:=GetScript()

   DEFAULT lDialog:=.F.,;
           lAuto  :=.F.,;
           lHide  :=.F.

   // lAuto=AutoDetect

   DEFAULT cRif:=SPACE(013)

   cRif:=STRTRAN(cRif,"-","")
   cRif:=PADR(cRif,15)

// ? cRif,lDialog,lAuto,lHide,oGet,"cRif,lDialog,lAuto,lHide,oGet"
//? oScript:cProgram
//ClassName()

/*
   oDp:pCapCha:=NIL

   IF oDp:pCapCha=NIL

     MsgRun("Iniciando Servicio Anti-CaptCha")
     oDp:pCapCha:=BuscarRif_Create()

   ENDIF
*/


   DEFAULT oDp:lAnti_Captcha:=.F.

   FERASE("captcha.jpg")

   IF oDp:pCapCha=NIL

      MsgRun("Iniciando Servicio Anti-CaptCha")
      pCapCha :=BuscarRif_Create()
      lHide   :=.F.

   ELSE

      pCapCha:=oDp:pCapCha

      COPY FILE ("BITMAPS\sincaptcha.jpg") TO ("captcha.jpg")

   ENDIF

   DPEDIT():New("Iniciando Servicio de Anti-Captcha","RIFANTICAPCHA.edt","oFrmCap",.T.,lDialog)

   oFrmCap:cNombre   :=SPACE(100)
   oFrmCap:cRif      :=cRif // SPACE(013)
   oFrmCap:cRifIni   :=cRif
   oFrmCap:cCaptcha  :=SPACE(10)
   oFrmCap:cMsg      :=""
   oFrmCap:pCapCha   := pCapCha
   oFrmCap:aData     :={}
   oFrmCap:cEmpresa  :=""
   oFrmCap:cCondic   :=""
   oFrmCap:cPorCen   :=""
   oFrmCap:cRegVen   :=""
   oFrmCap:cActEco   :=""
   oFrmCap:cRifVal   :=""
   oFrmCap:lRif      :=Empty(cRif) // Si viene vacio lo vaciara
   oFrmCap:lHide     :=lHide
   oFrmCap:lFind     :=.F.
   oFrmCap:oScript   :=oScript
   oFrmCap:lValCapCha:=(!oDp:pCapCha=NIL)
   oFrmCap:oGet      :=oGet
   oFrmCap:lAuto     :=lAuto

   oFrmCap:CreateWindow() 

   @ 1,01 SAY "Rif: "     RIGHT
   @ 2,01 SAY "Captcha: " RIGHT

   @ 0,0 SAY "Para Iniciar el Servicio Anti-Captcha"+CRLF+;
             "introduzca una vez por sesión los datos que muestra la Imagen"+CRLF+;
             "Esta funcionalidad esta en evaluación provisional y requiere contratación por servicio de Validaciones."

   @ 4,1 SAY "Contribuyente :"  RIGHT
   @ 5,1 SAY "Condición:"       RIGHT
   @ 6,1 SAY "% Retención IVA:" RIGHT
   @ 7,1 SAY "Estado:"          RIGHT
   @ 8,1 SAY "Actividad:"       RIGHT
  
   @ 8,30 SAY  oFrmCap:oEmpresa PROMPT oFrmCap:cEmpresa
   @ 9,30 SAY  oFrmCap:oCondic  PROMPT oFrmCap:cCondic
   @10,30 SAY  oFrmCap:oPorCen  PROMPT oFrmCap:cPorCen
   @11,30 SAY  oFrmCap:oRegVen  PROMPT oFrmCap:cRegVen
   @12,30 SAY  oFrmCap:oActEco  PROMPT oFrmCap:cRegVen

   @09,01 SAY "RIF:" RIGHT
   @12,30 SAY oFrmCap:oRifVal  PROMPT oFrmCap:cRifVal

   @ 1,20 GET oFrmCap:oCaptcha VAR oFrmCap:cCaptcha;
          VALID oFrmCap:VALCAPTCHA();
          WHEN oDp:pCapCha=NIL

   @ 1,20 GET oFrmCap:oRif VAR oFrmCap:cRif;
          VALID oFrmCap:VALRIF(oFrmCap:cRif)

   oFrmCap:oRif:bKeyDown:={|n| oFrmCap:oBtnRun:ForWhen(.T.),;
                             IF(n=13,oFrmCap:VALRIF(oFrmCap:cRif),.T.)}

   @ 0, 0 IMAGE oFrmCap:oImage SIZE 100, 50 OF oFrmCap:oDlg  FILE "captcha.jpg" ADJUST

   @ 14.5,35 XBUTTON oFrmCap:oBtnOk;
           SIZE 50, 19;
           COLORS CLR_BLACK, { CLR_WHITE, oDp:nGris2, 1 }; 
           WHEN oFrmCap:lFind;   
           FILE "BITMAPS\XNEXT.BMP","BITMAPS\XNEXT.BMP","BITMAPS\XNEXTG.BMP";
           PROMPT "Aceptar" NOBORDER; 
           ACTION oFrmCap:Close() UPDATE

   oFrmCap:Activate({|| oFrmCap:FORMINICAP(),IF(!Empty(oFrmCap:cRif),oFrmCap:oRif:KeyBoard(13),NIL)} )

RETURN oFrmCap:lFind

FUNCTION FORMINICAP()
   LOCAL oCursor,oBar,oBtn,oFont,oCol
   LOCAL oDlg:=oFrmCap:oDlg
   LOCAL nLin:=0

   DEFINE CURSOR oCursor HAND
   DEFINE BUTTONBAR oBar SIZE 52-15,60-15 OF oDlg 3D CURSOR oCursor
   DEFINE FONT oFont  NAME "Arial"   SIZE 0, -14 BOLD

   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\RUN.BMP",NIL,"BITMAPS\RUNG.BMP";
          WHEN !Empty(oFrmCap:cRif);
          ACTION oFrmCap:oRif:KeyBoard(13)

   oBtn:cToolTip:="Validar"

   oFrmCap:oBtnRun:=oBtn

   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\REFRESH.BMP";
          ACTION oFrmCap:RESETCAPTCHA() CANCEL


   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\XSALIR.BMP";
          ACTION (oFrmCap:Close()) CANCEL

   oBar:SetColor(CLR_BLACK,oDp:nGris)

   AEVAL(oBar:aControls,{|o,n| o:SetColor(CLR_BLACK,oDp:nGris) })

//   IF !Empty(oFrmCap:cRif)
//      oFrmCap:oRif:KeyBoard(13)
//   ENDIF
//   IF(!Empty(oFrmCap:cRif),oFrmCap:oRif:KeyBoard(13),NIL)
//   oFrmCap:oDlg:Hide()

   IF ValType(oFrmCap:oGet)="O"
     EJECUTAR("FRMMOVE",oFrmCap,oFrmCap:oGet)
   ENDIF

RETURN .T.

FUNCTION VALRIF(cRif)
   LOCAL cFile:="TEMP\RIF_"+ALLTRIM(cRif)+".HTML",cMemo,aData:={} 
   LOCAL cRif2:="",nContar:=0
   LOCAL nLenO:=LEN(cRif)
   LOCAL nLen :=LEN(ALLTRIM(cRif))
   LOCAL lOk  :=.F.,lFind:=.F.,cVal,nAt
   LOCAL cNombreR:=""

   CursorWait()
  
   IF Empty(cRif)
     RETURN .F.
   ENDIF

   cRif :=ALLTRIM(UPPER(cRif))
   cRif :=STRTRAN(cRif,".","")
   cRif :=STRTRAN(cRif,".","")

   IF ISALLDIGIT(cRif) .AND. nLen<8

      IF LEN(cRif)=8 .AND. LEFT(cRif,1)="8"
        cRif:=PADR("E"+STRZERO(VAL(cRif),8),nLenO)
      ELSE
        cRif:=PADR("V"+STRZERO(VAL(cRif),8),nLenO)
      ENDIF

   ENDIF

   IF ISALLDIGIT(cRif) .AND. nLen=8

      IF LEN(cRif)=8 .AND. LEFT(cRif,1)="8"
        cRif:=PADR("E"+STRZERO(VAL(cRif),8),nLenO)
      ELSE
        cRif:=PADR("V"+STRZERO(VAL(cRif),8),nLenO)
      ENDIF

   ENDIF
   
   //MsgRun("Leyendo "+cRif)

   cMemo:= BuscarRif_Buscar(oFrmCap:pCapCha,cRif)

   nAt:=AT(ALLTRIM(cRif)+"&nbsp",cMemo)

   IF nAt>0

      cNombreR:=SUBS(cMemo,nAt,LEN(cMemo))
      nAt     :=AT("</b>",cNombreR)
      cNombreR:=LEFT(cNombreR,nAt)
      cNombreR:=STRTRAN(cNombreR,cRif,"")
      cNombreR:=STRTRAN(cNombreR,"&nbsp","")
      cNombreR:=STRTRAN(cNombreR,";"    ,"")
      cNombreR:=STRTRAN(cNombreR,".<"   ,"")
   ENDIF

//? nAt,cRif,cNombreR

   DPWRITE(cFile,cMemo)

   aData:=EJECUTAR("LEERIFTXT",cFile,cRif)
   oDp:cDataRif:=cRif

   IF Empty(aData[1])
      aData[1]:=cNombreR
   ENDIF


// ViewArray(aData)

   IF Empty(aData[1]) .AND. LEN(ALLTRIM(cRif))=9 .AND. (LEFT(cRif,1)="V" .OR. LEFT(cRif,1)="E") 
//.AND. !oDp:pCapCha=NIL

      cMemo  :=""
      nContar:=0

      WHILE nContar<10 .AND. oFrmCap:lValCapCha

         cRif2:=ALLTRIM(cRif)+LSTR(nContar)
         cMemo:=BuscarRif_Buscar(oFrmCap:pCapCha,cRif2)

         IF "No existe el contribuyente solicitado"$cMemo .OR. Empty(cMemo)
            nContar++
            LOOP
         ENDIF

         cRif   :=cRif2
         oFrmCap:oRif:VarPut(cRif,.T.)

         DPWRITE(cFile,cMemo)
         aData:=EJECUTAR("LEERIFTXT",cFile,cRif)

         oFrmCap:oRifVal:VarPut(cRif,.T.)

         oDp:cDataRif:=cRif
         lFind:=.T.

         EXIT

      ENDDO

       IF !lFind
         oFrmCap:oRif:VarPut(oFrmCap:cRifIni,.T.)
       ENDIF

   ENDIF

 
   oFrmCap:lFind:=lFind
   oFrmCap:oEmpresa:SetText(aData[1])
   oFrmCap:oCondic :SetText(aData[2])
   oFrmCap:oPorCen :SetText(aData[3])
   oFrmCap:oRegVen :SetText(aData[4])
   oFrmCap:oActEco :SetText(aData[5])
   oFrmCap:oRifVal :SetText(cRif)

   oFrmCap:aData :=ACLONE(aData)

   oDp:aDataRif:=ACLONE(aData)
   oDp:cDataRif:=cRif

/*
   oDp:aRif:={aData[1],aData[1],aData[3],aData[4],aData[5]}
oCLIENTES:nRetIva :=oDp:aRif[2]
        oCLIENTES:cPersona:=oDp:aRif[3]
        oCLIENTES:cMemoRif:=oDp:aRif[4]
        // Actividad Económica según RIF
        oCLIENTES:CLI_ACTECO:=oDp:aRif[5]
*/

   IF "imagen"$aData[2]

      oFrmCap:RESETCAPTCHA()
     

/*
      MsgRun("Iniciando Servicio Anti-CaptCha")

      oDp:pCapCha:=NIL
      oFrmCap:pCapCha:=BuscarRif_Create()
      oFrmCap:oImage:LoadImage(NIL,"captcha.jpg")

      DPFOCUS(oFrmCap:oCaptcha)
*/    
      RETURN .T.
     
   ENDIF

   IF !Empty(aData[1])

      oDp:pCapCha:=oFrmCap:pCapCha
      oFrmCap:oCaptcha:ForWhen(.T.)
      oFrmCap:oImage:LoadImage(NIL,"BITMAPS\sincaptcha.jpg")
      oFrmCap:oImage:Refresh(.T.)

      IF oFrmCap:lRif 
        oFrmCap:oRif:VarPut(oFrmCap:cRifIni,.T.)
      ENDIF

      oFrmCap:oCaptcha:VarPut(CTOEMPTY(oFrmCap:cCaptcha),.T.)
      DPFOCUS(oFrmCap:oRif)

      oDp:lAnti_Captcha:=.T.

      oFrmCap:lFind:=.T.
   ENDIF

   // Si no lo encuentra restaura RIF Inicial
   IF !oFrmCap:lFind
     oFrmCap:oRif:VarPut(oFrmCap:cRifIni,.T.)
   ENDIF

   oFrmCap:oBtnOk:ForWhen(.T.)

   IF oFrmCap:lFind .AND. oFrmCap:lAuto
     EVAL(oFrmCap:oBtnOk:bAction)
   ENDIF

RETURN .T.

FUNCTION VALCAPTCHA()

   BuscarRif_SetCaptcha(oFrmCap:pCapCha, ALLTRIM(oFrmCap:cCaptcha))

   oFrmCap:lValCapCha:=.T.

RETURN .T.

FUNCTION RESETCAPTCHA()

//   oFrmCap:oImage:LoadImage(NIL,"BITMAPS\sincaptcha.jpg")
//   oFrmCap:oImage:Refresh(.T.)

   MsgRun("Iniciando Servicio Anti-CaptCha")

   oDp:pCapCha:=NIL
   oFrmCap:pCapCha:=BuscarRif_Create()
   oFrmCap:oImage:LoadImage(NIL,"captcha.jpg")
   oFrmCap:oImage:Refresh(.T.)

   oFrmCap:oCaptcha:VarPut(CTOEMPTY(oFrmCap:cCaptcha),.T.)
   oFrmCap:oCaptcha:ForWhen(.T.)
   DPFOCUS(oFrmCap:oCaptcha)

RETURN .T.
    




