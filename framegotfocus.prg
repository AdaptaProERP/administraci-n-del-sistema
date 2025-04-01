// Programa   : FRAMEGOTFOCUS
// Fecha/Hora : 31/03/2025 14:37:17
// Propósito  : Refrescar los botones
// Creado Por :
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
   LOCAL I,oBar:=oDp:oBar,oFont,oBtn

   IF oDp:l800
   
      DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -10 BOLD

   ELSE

      DEFINE FONT oFont  NAME "Tahoma"   SIZE 0, -08 BOLD

   ENDIF

   FOR i=1 to len(oBar:aControls)

     oBtn:=oBar:aControls[I]

     IF "BTN"$oBar:aControls[I]:ClassName()
       oBtn:SetFont(oFont)
       oBtn:Refresh(.T.)
     ENDIF

   NEXT I

RETURN NIL
// EOF
