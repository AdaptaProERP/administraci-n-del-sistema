// Programa   : BTNBARFINDVIEW
// Fecha/Hora : 15/11/2018 15:41:27
// Propósito  : Buscar desde la barra de Menú
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(aData,cTitle,cWhere_,lHistorico,lMenu)
   LOCAL oBrw,oCol
   LOCAL oFont,oFontB
   LOCAL aCoors:=GetCoors( GetDesktopWindow() )

   IF Empty(aData)
      RETURN .T.
   ENDIF

   DEFAULT lHistorico:=.F.,;
           lMenu     :=.F.

   IF Type("oMNUFIND")="O" .AND. oMNUFIND:oWnd:hWnd>0
      RETURN EJECUTAR("BRRUNNEW",oMNUFIND,GetScript())
   ENDIF

   DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -12 
   DEFINE FONT oFontB NAME "Tahoma"   SIZE 0, -12 BOLD

   DpMdi(cTitle,"oMNUFIND","BRMNUFIND3.EDT")

   oMNUFIND:Windows(0,0,aCoors[3]-160,MIN(840,aCoors[4]-10),.T.) // Maximizado

   oMNUFIND:lMsgBar   :=.F.
   oMNUFIND:cNombre   :=""
//  oMNUFIND:dDesde   :=dDesde
// oMNUFIND:cServer   :=cServer
   oMNUFIND:cWhereQry :=""
   oMNUFIND:cSql      :=oDp:cSql
   oMNUFIND:oWhere    :=TWHERE():New(oMNUFIND)
   oMNUFIND:lWhen     :=.T.
   oMNUFIND:lTmdi     :=.T.
   oMNUFIND:nRadio    :=1
   oMNUFIND:lActivate :=.F.
   oMNUFIND:oRadio    :=nil
   oMNUFIND:lRunValid :=.T.
   oMNUFIND:lHistorico:=lHistorico
   oMNUFIND:lMenu     :=lMenu

   oMNUFIND:oBrw:=TXBrowse():New( IF(oMNUFIND:lTmdi,oMNUFIND:oWnd,oMNUFIND:oDlg ))
   oMNUFIND:oBrw:SetArray( aData, .F. )
   oMNUFIND:oBrw:SetFont(oFont)

   oMNUFIND:oBrw:lFooter     := .T.
   oMNUFIND:oBrw:lHScroll    := .F.
   oMNUFIND:oBrw:nHeaderLines:= 1
   oMNUFIND:oBrw:nDataLines  := 1
   oMNUFIND:oBrw:nFooterLines:= 1

   oMNUFIND:oBrw:bClrHeader          := {|| { oDp:nLbxClrHeaderText, oDp:nLbxClrHeaderPane}}

   oMNUFIND:aData            :=ACLONE(aData)
   oMNUFIND:nClrText :=0
   oMNUFIND:nClrPane1:=oDp:nClrPane1
   oMNUFIND:nClrPane2:=oDp:nClrPane2

   oMNUFIND:nClrText1:=CLR_HBLUE
   oMNUFIND:nClrText2:=CLR_GREEN
   oMNUFIND:nClrText3:=21245
   oMNUFIND:nClrText4:=CLR_HRED
   oMNUFIND:nClrText5:=16711935
   oMNUFIND:nClrText6:=16744576


  oMNUFIND:cClrText1:="Browse"
  oMNUFIND:cClrText2:="Informes"
  oMNUFIND:cClrText3:="Menú"
  oMNUFIND:cClrText4:="Procesos"
  oMNUFIND:cClrText5:="PlugIn"


  AEVAL(oMNUFIND:oBrw:aCols,{|oCol|oCol:oHeaderFont:=oFontB})

  oCol:=oMNUFIND:oBrw:aCols[1]
  oCol:cHeader      :='Opción'
  oCol:bLClickHeader := {|r,c,f,o| SortArray( o, oMNUFIND:oBrw:aArrayData ) } 
  oCol:nWidth       := 480

  oCol:=oMNUFIND:oBrw:aCols[2]
  oCol:cHeader      :='Aplicación'
  oCol:bLClickHeader := {|r,c,f,o| SortArray( o, oMNUFIND:oBrw:aArrayData ) } 
  oCol:nWidth       := 100

  oCol:=oMNUFIND:oBrw:aCols[3]
  oCol:cHeader      :='Vertical'
  oCol:bLClickHeader := {|r,c,f,o| SortArray( o, oMNUFIND:oBrw:aArrayData ) } 
  oCol:nWidth       := 100

  oCol:=oMNUFIND:oBrw:aCols[4]
  oCol:cHeader      :='Ubicación'
  oCol:bLClickHeader := {|r,c,f,o| SortArray( o, oMNUFIND:oBrw:aArrayData ) } 
  oCol:nWidth       := 180

//   oMNUFIND:oBrw:aCols[2]:lHide:=.F. // DelCol(2)

   oMNUFIND:oBrw:aCols[1]:cFooter:=" #"+LSTR(LEN(aData))

   oMNUFIND:oBrw:bClrStd               := {|oBrw,nClrText,aData|oBrw:=oMNUFIND:oBrw,aData:=oBrw:aArrayData[oBrw:nArrayAt],;
                                           nClrText:=oMNUFIND:nClrText,;
                                     nClrText:=IF(LEFT(aData[2],1)="B",oMNUFIND:nClrText1,nClrText),;
                                     nClrText:=IF(LEFT(aData[2],1)="I",oMNUFIND:nClrText2,nClrText),;
                                     nClrText:=IF(LEFT(aData[2],1)="M",oMNUFIND:nClrText3,nClrText),;
                                     nClrText:=IF(LEFT(aData[2],2)="Pr",oMNUFIND:nClrText4,nClrText),;
                                     nClrText:=IF(LEFT(aData[2],2)="Pl",oMNUFIND:nClrText5,nClrText),;
                                     nClrText:=IF(LEFT(aData[2],2)="Ej",oMNUFIND:nClrText6,nClrText),;
                                          {nClrText,iif( oBrw:nArrayAt%2=0, oMNUFIND:nClrPane1, oMNUFIND:nClrPane2 ) } }

//   oMNUFIND:oBrw:bClrHeader            := {|| { oDp:nLbxClrHeaderText, oDp:nLbxClrHeaderPane}}
//   oMNUFIND:oBrw:bClrFooter            := {|| { oDp:nLbxClrHeaderText, oDp:nLbxClrHeaderPane}}

   oMNUFIND:oBrw:bClrHeader          := {|| { oDp:nLbxClrHeaderText, oDp:nLbxClrHeaderPane}}
   oMNUFIND:oBrw:bClrFooter          := {|| { oDp:nLbxClrHeaderText, oDp:nLbxClrHeaderPane}}

   oMNUFIND:oBrw:bLDblClick:={|oBrw|oMNUFIND:RUNCLICK() }

   oMNUFIND:oBrw:bChange:={||oMNUFIND:BRWCHANGE()}
   oMNUFIND:oBrw:CreateFromCode()

   oMNUFIND:bValid   :={|| EJECUTAR("BRWSAVEPAR",oMNUFIND)}

//   oMNUFIND:oBrw:aCols[4]:lHide:=.T. // DelCol(2)
//   oMNUFIND:oBrw:aCols[5]:lHide:=.T. // DelCol(2)

   oMNUFIND:oWnd:oClient := oMNUFIND:oBrw

   oMNUFIND:oBrw:aData   :=ACLONE(oMNUFIND:oBrw:aArrayData)

   oMNUFIND:Activate({||oMNUFIND:ViewDatBar()})

   oMNUFIND:lActivate:=.T.


   oMNUFIND:BRWRESTOREPAR()
// ViewArray(aData)

RETURN .T.

/*
// Barra de Botones
*/
FUNCTION ViewDatBar()
   LOCAL oCursor,oBar,oBtn,oFont,oCol
   LOCAL oDlg:=IF(oMNUFIND:lTmdi,oMNUFIND:oWnd,oMNUFIND:oDlg)
   LOCAL nLin:=0,nCol:=0
   LOCAL nWidth:=oMNUFIND:oBrw:nWidth()

   oMNUFIND:oBrw:GoBottom(.T.)
   oMNUFIND:oBrw:Refresh(.T.)

   DEFINE CURSOR oCursor HAND

   IF !oDp:lBtnText 
     DEFINE BUTTONBAR oBar SIZE 52-15,60-15 OF oDlg 3D CURSOR oCursor
   ELSE 
     DEFINE BUTTONBAR oBar SIZE oDp:nBtnWidth,oDp:nBarnHeight+6 OF oDlg 3D CURSOR oCursor 
   ENDIF 

   DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -10 BOLD

 // Emanager no Incluye consulta de Vinculos


  oMNUFIND:oFontBtn   :=oFont    
  oMNUFIND:nClrPaneBar:=oDp:nGris
  oMNUFIND:oBrw:oLbx  :=oMNUFIND

  DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\RUN.BMP",NIL,"BITMAPS\RUNG.BMP";
            TOP PROMPT "Ejecutar"; 
            ACTION oMNUFIND:RUNMENUBRW();
            WHEN oMNUFIND:lRunValid


   oBtn:cToolTip:="Ejecutar Opciones del Menú"

   oMNUFIND:oBtnRun:=oBtn

   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\XFIND.BMP";
          TOP PROMPT "Buscar"; 
          ACTION  EJECUTAR("BRWSETFIND",oMNUFIND:oBrw)

   oBtn:cToolTip:="Buscar"

   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\FILTRAR.BMP";
          TOP PROMPT "Filtrar"; 
          ACTION  EJECUTAR("BRWSETFILTER",oMNUFIND:oBrw)

   oBtn:cToolTip:="Filtrar Registros"

   IF !oMNUFIND:lHistorico .OR. oMNUFIND:lMenu

     DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\AUDITORIA.BMP";
            TOP PROMPT "Histórico"; 
            ACTION  (oMNUFIND:Close(),EJECUTAR("BTNBARFINDHIS",.F.))

     oBtn:cToolTip:="Funcionalidades Memorizadas"

   ELSE

     IF COUNT("dpauditamenu")>0

     DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\MENU.BMP";
            TOP PROMPT "Histórico"; 
            ACTION  (oMNUFIND:Close(),EJECUTAR("BTNBARFINDHIS",.T.))

     oBtn:cToolTip:="Funcionalidades Memorizadas desde menú de ejecución"

     ENDIF

   ENDIF


   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\OPTIONS.BMP",NIL,"BITMAPS\OPTIONSG.BMP";
          TOP PROMPT "Opciones"; 
          ACTION  EJECUTAR("BRWSETOPTIONS",oMNUFIND:oBrw);
          WHEN LEN(oMNUFIND:oBrw:aArrayData)>1

   oBtn:cToolTip:="Filtrar según Valores Comunes"



   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\xTOP.BMP";
          TOP PROMPT "Primero"; 
          ACTION  (oMNUFIND:oBrw:GoTop(),oMNUFIND:oBrw:Setfocus())


  DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\xFIN.BMP";
          TOP PROMPT "Ultimo"; 
          ACTION  (oMNUFIND:oBrw:GoBottom(),oMNUFIND:oBrw:Setfocus())


   DEFINE BUTTON oBtn;
          OF oBar;
          NOBORDER;
          FONT oFont;
          FILENAME "BITMAPS\XSALIR.BMP";
          TOP PROMPT "Cerrar"; 
          ACTION  oMNUFIND:Close()

  oMNUFIND:oBrw:SetColor(0,oMNUFIND:nClrPane1)

  EVAL(oMNUFIND:oBrw:bChange)
 
  oBar:SetColor(CLR_BLACK,oDp:nGris)

  AEVAL(oBar:aControls,{|o,n|o:SetColor(CLR_BLACK,oDp:nGris)})

  oMNUFIND:oBar:=oBar

  DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -10 BOLD
 

  @ 102,10  RADIO oMNUFIND:oRadio VAR oMNUFIND:nRadio;
            ITEMS "&Todos","&Transacciones", "&Ficheros","&Consultas","&Informes","&Browse","&PlugIn" SIZE 60, 13 ;
            PIXEL OF oBar ON CHANGE oMNUFIND:SETFILTRAR()

  nLin  :=05
  nWidth:=90
  nCol  :=400+55
  
  AEVAL(oMNUFIND:oRadio:aItems,{|o,n| nLin:=IF(n=4,25 ,nLin),;
                                      nCol:=IF(n=4,400+55,nCol),;
                                      nCol:=IF(n=7,400+55,nCol),;
                                      nLin:=IF(n=7,45 ,nLin),;
                                      o:SetFont(oFont),;
                                      o:Move(nLin,nCol),;
                                      o:SetSize(nWidth,20),;
                                      nCol:=nCol+nWidth})
         


RETURN .T.


FUNCTION SETFILTRAR()
  LOCAL cText:=oMNUFIND:oRadio:aItems[oMNUFIND:oRadio:nOption]:cCaption
  LOCAL aData,aLine:={}

  IF !oMNUFIND:lActivate
     RETURN .T.
  ENDIF

  IF oMNUFIND:oRadio:nOption=1

     aData:=ACLONE(oMNUFIND:oBrw:aData)

  ELSE

    IF Empty(oMNUFIND:oBrw:aData)
      oMNUFIND:oBrw:aData     :=ACLONE(oMNUFIND:oBrw:aArrayData)
      oMNUFIND:oBrw:lSetFilter:=.F.
    ENDIF

    cText:=UPPER(STRTRAN(cText,"&",""))

    // aData:=ACLONE(oMNUFIND:oBrw:aArrayData)
    aData:=ACLONE(oMNUFIND:oBrw:aData)


    ADEPURA(aData,{|a,n| !(cText$UPPER(ALLTRIM(a[3])) .OR. cText$UPPER(ALLTRIM(a[2]))) })

  ENDIF

  oMNUFIND:lRunValid:=.T.

  IF Empty(aData)
     aLine:=oMNUFIND:oBrw:aData[1]
     AEVAL(aLine,{|a,n| aLine[n]:=CTOEMPTY(a)})
     aLine[1]:="No encontrado"
     AADD(aData,aLine)
     oMNUFIND:lRunValid:=.F.

  ENDIF

  IF LEN(aData)>0
     oMNUFIND:oBrw:aArrayData:=ACLONE(aData)
     oMNUFIND:oBrw:nArrayAt  :=1
     oMNUFIND:oBrw:Gotop()
     oMNUFIND:oBrw:Refresh(.T.)
  ENDIF

  oMNUFIND:oBtnRun:ForWhen(.T.)

   
RETURN .T.
/*
// Evento para presionar CLICK
*/
FUNCTION RUNCLICK()
 
  oMNUFIND:RUNMENUBRW()

RETURN .T.



FUNCTION HACERWHERE(dDesde,dHasta,cWhere_,lRun)
   LOCAL cWhere:=""

   DEFAULT lRun:=.F.

   // Campo fecha no puede estar en la nueva clausula
   IF ""$cWhere
     RETURN ""
   ENDIF

   IF !Empty(dDesde)
       
   ELSE
     IF !Empty(dHasta)
       
     ENDIF
   ENDIF


   IF !Empty(cWhere_)
      cWhere:=cWhere + IIF( Empty(cWhere),""," AND ") +cWhere_
   ENDIF

   IF lRun

     IF !Empty(oMNUFIND:cWhereQry)
       cWhere:=cWhere + oMNUFIND:cWhereQry
     ENDIF

     oMNUFIND:LEERDATA(cWhere,oMNUFIND:oBrw,oMNUFIND:cServer)

   ENDIF


RETURN cWhere


/*
// Ejecución Cambio de Linea 
*/
FUNCTION BRWCHANGE()
RETURN NIL


FUNCTION RUNMENUBRW()
  LOCAL aLine:=oMNUFIND:oBrw:aArrayData[oMNUFIND:oBrw:nArrayAt]
  LOCAL oTable:=OpenTable("SELECT * FROM DPAUDITORIA",.F.)
  
  oTable:AppendBlank()
  oTable:Replace("AUD_USUARI",oDp:cUsuario)
  oTable:Replace("AUD_CLAVE" ,aLine[1])
  oTable:Replace("AUD_SCLAVE",aLine[2])
  oTable:Replace("AUD_TCLAVE",aLine[3])
  oTable:Replace("AUD_CCLAVE",aLine[4])
  oTable:Replace("AUD_ESTACI",oDp:cPcName)
  oTable:Replace("AUD_FECHAS",oDp:dFecha )
  oTable:Replace("AUD_HORA"  ,oDp:cHora  )
  oTable:Replace("AUD_TIPO"  ,"BUSB"     ) // Buscador de la Barra
  oTable:Commit("")
  oTable:End()

  oMNUFIND:Close()
  MacroEje(aLine[4])
     
RETURN .T.

FUNCTION BRWRESTOREPAR()
RETURN EJECUTAR("BRWRESTOREPAR",oMNUFIND)
// EOF
