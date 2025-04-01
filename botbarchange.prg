// Programa   : BOTBARCHANGE
// Fecha/Hora : 26/06/2003 17:55:06
// PropÑsito  : Ejecutar los Cambios en Botones de Barra y Cambios de AplicaciÑn
// Creado Por : Juan Navas
// Llamado por: DPBOTBAR
// AplicaciÑn : Todas
// Tabla      : DPBOTBAR

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
   Local aBotBar :={}
   Local oFrameDp:=oDp:oFrameDp   // Ventana Princial
   Local oBar    :=oFrameDp:oBar  // Barra de Botones
   Local aBarSize:={}             // Parametros y Tamaªos de los Botones, VER DPINI
   Local oHand,i,oBtn,oFont
   LOCAL nHeight :=50,nWidth:=50+4,nCol:=15

   aBarSize:=VP("aBARSIZE")

   DEFAULT aBARSIZE:={40,40,.T.,"TOP"}

   IF oDp:l800
   
      DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -10 BOLD

   ELSE

      DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -08 BOLD

   ENDIF

   nHeight:=oDp:aBarSize[2]+3.5
   nWidth :=oDp:aBarSize[1]

   oDp:aMenuMac:={}

   // remueve todos los botones
   FOR i=1 to len(oBar:aControls)

     oBtn:=oBar:aControls[I]

     IF "BTN"$oBar:aControls[I]:ClassName()
       oBtn:Hide()   
       oBtn:aControls[I]:End()
       oBar:aControls[I]:=nil
     ENDIF

   NEXT I

   ADEPURA(oBar:aControls,{|o,n| o=NIL})

   aBotBar:=CARGABOTBAR()

   oBar:SetColor(NIL,oDp:nGris)
   oBar:Refresh(.T.)

   oBar:bGotFocus:={||EJECUTAR("FRAMEGOTFOCUS")}

   aBarSize[1]:=30
   aBarSize[2]:=30

   DPBOTBAR(oBar,oDp:cModulo,aBotBar,aBarSize[1],aBarSize[2])

   FOR i=1 to len(oBar:aControls)

     oBtn:=oBar:aControls[I]

     IF "BTN"$oBar:aControls[I]:ClassName()

       // oBtn:SetSize(nWidth,nHeight,.t.)
       oBtn:Move(2,nCol,nWidth,nHeight,.t.)
       oBtn:SetFont(oFont)
       nCol:=nCol+oBtn:nWidth()
     
     ENDIF

   NEXT I


   oDp:oBarSay:=NIL

   EJECUTAR("DPBARMSG")

   DPXGETPROCE(.F.) // Desactiva Traza Ejecución DpXbase

   EJECUTAR("BTNBARFIND") // Agrega el Botón de Búsqueda.

   IF Empty(oDp:cSucNombre)
     oDp:oFrameDp:SetText(oDp:cDpSys+" ["+oDp:cEmpresa+"]")
   ELSE
     oDp:oFrameDp:SetText(oDp:cDpSys+" ["+ALLTRIM(oDp:cEmpresa)+"] / "+ALLTRIM(oDp:cSucNombre))
     oDp:oItem2:SetText(oDp:cSucursal)
   ENDIF

//   EJECUTAR("SETBMPFRAME")

RETURN 
// EOF
