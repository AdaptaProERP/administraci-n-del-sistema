// Programa   : DPUSUARIOS
// Fecha/Hora : 03/03/2004 15:48:45
// Propósito  : Incluir/Modificar DPUSUARIOS
// Creado Por : DpXbase
// Llamado por: DPUSUARIOS.LBX
// Aplicación : Definiciones y Mantenimiento            
// Tabla      : DPUSUARIOS

#INCLUDE "DPXBASE.CH"

FUNCTION DPUSUARIOS(nOption,cCodigo)
  LOCAL oBtn,oTable,oGet,oFont,oFontB,oFontG
  LOCAL cTitle,cSql,cFile,cExcluye:=""
  LOCAL nClrText
  LOCAL cTitle:="Usuarios del Sistema"
  LOCAL cNumero

  

  cExcluye:=""

  DEFAULT cCodigo:=SQLGET("DPUSUARIOS","OPE_NUMERO"),nOption:=1

  EJECUTAR("DPFMTUSUARIOSG")

  DEFINE FONT oFont  NAME "Tahoma" SIZE 0, -10 BOLD
  DEFINE FONT oFontB NAME "Tahoma" SIZE 0, -12 BOLD ITALIC
  DEFINE FONT oFontG NAME "Tahoma" SIZE 0, -11

  nClrText:=10485760 // Color del texto
  cSql    :=[SELECT * FROM DPUSUARIOS WHERE OPE_NUMERO]+GetWhere("=",cCodigo)

  IF nOption=1 // Incluir
    cTitle   :=" Incluir {oDp:DPUSUARIOS}"
  ELSE // Modificar o Consultar
    cTitle   :=IIF(nOption=2,"Consultar","Modificar")+" {oDp:DPUSUARIOS}"
  ENDIF

  oTable   :=OpenTable(cSql,"WHERE"$cSql) // nOption!=1)

  IF nOption=1 .AND. oTable:RecCount()=0 // Genera Cursor Vacio
     oTable:End()
     cSql     :=[SELECT * FROM DPUSUARIOS]
     oTable   :=OpenTable(cSql,.F.) // nOption!=1)
  ENDIF

  oTable:cPrimary:="OPE_NUMERO" // Clave de Validación de Registro

  oUSUARIOS:=DPEDIT():New(cTitle,"DPUSUARIOS.edt","oUSUARIOS" , .F. )

  oUSUARIOS:cUser    :=cCodigo
  oUSUARIOS:nOption  :=nOption
  oUSUARIOS:SetTable( oTable , .F. ) // Asocia la tabla <cTabla> con el formulario oUSUARIOS
  oUSUARIOS:SetScript("DPUSUARIOS")        // Asigna Funciones DpXbase como Metodos de oUSUARIOS
  oUSUARIOS:SetDefault()       // Asume valores standar por Defecto, CANCEL,PRESAVE,POSTSAVE,ORDERBY
  oUSUARIOS:cClave:=""
  oUSUARIOS:OPE_CODSAS:=""


  oUSUARIOS:cNumero:=oUSUARIOS:OPE_NUMERO

  IF oUSUARIOS:nOption=1 // Incluir en caso de ser Incremental

    oUSUARIOS:RepeatGet() // Repite todos los Campos
     
    oUSUARIOS:OPE_NUMERO:=oUSUARIOS:Incremental("OPE_NUMERO",.T.)
    oUSUARIOS:cNumero   :=""

    oUSUARIOS:OPE_LUNAIN:="00:00"
    oUSUARIOS:OPE_LUNAFI:="12:59"
    oUSUARIOS:OPE_LUNPIN:="01:00"
    oUSUARIOS:OPE_LUNPFI:="12:59"

    oUSUARIOS:OPE_MARAIN:="00:00"
    oUSUARIOS:OPE_MARAFI:="12:59"
    oUSUARIOS:OPE_MARPIN:="01:00"
    oUSUARIOS:OPE_MARPFI:="12:59"

    oUSUARIOS:OPE_MIEAIN:="00:00"
    oUSUARIOS:OPE_MIEAFI:="12:59"
    oUSUARIOS:OPE_MIEPIN:="01:00"
    oUSUARIOS:OPE_MIEPFI:="12:59"

    oUSUARIOS:OPE_JUEAIN:="00:00"
    oUSUARIOS:OPE_JUEAFI:="12:59"
    oUSUARIOS:OPE_JUEPIN:="01:00"
    oUSUARIOS:OPE_JUEPFI:="12:59"

    oUSUARIOS:OPE_VIEAIN:="00:00"
    oUSUARIOS:OPE_VIEAFI:="12:59"
    oUSUARIOS:OPE_VIEPIN:="01:00"
    oUSUARIOS:OPE_VIEPFI:="12:59"

    oUSUARIOS:OPE_SABAIN:="00:00"
    oUSUARIOS:OPE_SABAFI:="12:59"
    oUSUARIOS:OPE_SABPIN:="01:00"
    oUSUARIOS:OPE_SABPFI:="12:59"

    oUSUARIOS:OPE_DOMAIN:="00:00"
    oUSUARIOS:OPE_DOMAFI:="12:59"
    oUSUARIOS:OPE_DOMPIN:="01:00"
    oUSUARIOS:OPE_DOMPFI:="12:59"

    oUSUARIOS:OPE_LUNES :=.T.
    oUSUARIOS:OPE_MARTES:=.T.
    oUSUARIOS:OPE_MIERCO:=.T.
    oUSUARIOS:OPE_JUEVES:=.T.
    oUSUARIOS:OPE_VIERNE:=.T.
    oUSUARIOS:OPE_SABADO:=.T.
    oUSUARIOS:OPE_DOMING:=.T.
    oUSUARIOS:OPE_ACTIVO:=.T.
    oUSUARIOS:OPE_AUDAPP:=.F. // Auditoria de Aplicaciones
    oUSUARIOS:OPE_ALLPC :=.T.

    oUSUARIOS:OPE_NOMBRE:=CTOEMPTY(oUSUARIOS:OPE_NOMBRE)
    oUSUARIOS:OPE_CLAVE :=CTOEMPTY(oUSUARIOS:OPE_CLAVE )
    oUSUARIOS:OPE_CARGO :=CTOEMPTY(oUSUARIOS:OPE_CARGO )

  ELSE

    oUSUARIOS:OPE_NOMBRE:=OPE_NOMBRE(oUSUARIOS:OPE_NUMERO)
    oUSUARIOS:OPE_CARGO :=OPE_CARGO(oUSUARIOS:OPE_NUMERO)
    oUSUARIOS:OPE_CLAVE :=OPE_CLAVE(oUSUARIOS:OPE_NUMERO)

    oUSUARIOS:cClave:=oUSUARIOS:OPE_CLAVE

  ENDIF


  //Tablas Relacionadas con los Controles del Formulario

  oUSUARIOS:CreateWindow()       // Presenta la Ventana

  @  2,1 GROUP oGrp TO 08, 21.5 PROMPT "Usuario"
  @  9,1 GROUP oGrp TO 13, 21.5 PROMPT "Mapas"
  @ 14,1 GROUP oGrp TO 17, 21.5 PROMPT "Horario"
  @ 22,1 GROUP oGrp TO 23, 21.5 PROMPT "Datos para Correo"

  oUSUARIOS:ViewTable("DPMAPAMNU","MMN_DESCRI","MMN_CODIGO","OPE_MAPMNU")
  oUSUARIOS:ViewTable("DPMAPATAB","MAT_DESCRI","MAT_CODIGO","OPE_MAPTAB")
  oUSUARIOS:ViewTable("DPMAPACAM","MAC_DESCRI","MAC_CODIGO","OPE_MAPCAM")
  oUSUARIOS:ViewTable("DPMAPBAR" ,"MBB_DESCRI","MBB_CODIGO","OPE_MAPBAR")
  oUSUARIOS:ViewTable("DPMAPAPRC","MPA_DESCRI","MPA_CODIGO","OPE_MAPPRC")
  
  //
  // Campo : OPE_NUMERO
  // Uso   : Número                                  
  //
  @ 1.0, 1.0 GET oUSUARIOS:oOPE_NUMERO  VAR oUSUARIOS:OPE_NUMERO;
                    VALID CERO(oUSUARIOS:OPE_NUMERO) .AND. oUSUARIOS:ValUnique(oUSUARIOS:OPE_NUMERO);
                    WHEN (AccessField("DPUSUARIOS","OPE_NUMERO",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFontG

    oUSUARIOS:oOPE_NUMERO:cMsg    :=oUSUARIOS:LEVEL("OPE_NUMERO")
    oUSUARIOS:oOPE_NUMERO:cToolTip:=oUSUARIOS:oOPE_NUMERO:cMsg

  @ oUSUARIOS:oOPE_NUMERO:nTop-08,oUSUARIOS:oOPE_NUMERO:nLeft SAY oUSUARIOS:oOPE_NUMERO:cMsg PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL 


  //
  // Campo : OPE_NOMBRE
  // Uso   : Nombre o Login                          
  //
  @ 2.8, 1.0 GET oUSUARIOS:oOPE_NOMBRE  VAR oUSUARIOS:OPE_NOMBRE ;
                    WHEN (AccessField("DPUSUARIOS","OPE_NOMBRE",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFontG

    oUSUARIOS:oOPE_NOMBRE:cMsg    :=oUSUARIOS:LEVEL("OPE_NOMBRE")+", Formato ["+ALLTRIM(oDp:cFmtNombre)+"], Longitud ["+LSTR(oDp:nLenNombre)+"]"
    oUSUARIOS:oOPE_NOMBRE:cToolTip:=oUSUARIOS:oOPE_NOMBRE:cMsg

  @ oUSUARIOS:oOPE_NOMBRE:nTop-08,oUSUARIOS:oOPE_NOMBRE:nLeft SAY oUSUARIOS:LEVEL("OPE_NOMBRE");
                           PIXEL;
                           SIZE NIL,7 FONT oFont COLOR nClrText,NIL 


  //
  // Campo : OPE_CARGO 
  // Uso   : Cargo                                   
  //
  @ 4.6, 1.0 GET oUSUARIOS:oOPE_CARGO   VAR oUSUARIOS:OPE_CARGO  ;
                    WHEN (AccessField("DPUSUARIOS","OPE_CARGO",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFontG

    oUSUARIOS:oOPE_CARGO :cMsg    :="Cargo"
    oUSUARIOS:oOPE_CARGO :cToolTip:="Cargo"

  @ oUSUARIOS:oOPE_CARGO :nTop-08,oUSUARIOS:oOPE_CARGO :nLeft SAY "Cargo" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL 


  //
  // Campo : OPE_CLAVE 
  // Uso   : Clave                                   
  //
  @ 6.4, 1.0 GET oUSUARIOS:oOPE_CLAVE   VAR oUSUARIOS:OPE_CLAVE  ;
                    VALID oUSUARIOS:ValUnique(oUSUARIOS:OPE_NOMBRE+oUSUARIOS:OPE_CLAVE,"OPE_NOMBRE+OPE_CLAVE");
                          .AND. oUSUARIOS:VALUSUARIO();
                    WHEN (AccessField("DPUSUARIOS","OPE_CLAVE",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFontG

    oUSUARIOS:oOPE_CLAVE :cMsg    :="Clave, Formato: ["+ALLTRIM(oDp:cFmtClave)+"], Longitud ["+LSTR(oDp:nLenClave)+"]"
    oUSUARIOS:oOPE_CLAVE :cToolTip:=oUSUARIOS:oOPE_CLAVE :cMsg

  @ oUSUARIOS:oOPE_CLAVE :nTop-08,oUSUARIOS:oOPE_CLAVE :nLeft SAY "Clave" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL 


  //
  // Campo : OPE_ACCWEB
  // Uso   : Acceso Web                              
  //
  @ 8.2, 1.0 CHECKBOX oUSUARIOS:oOPE_ACCWEB  VAR oUSUARIOS:OPE_ACCWEB  PROMPT ANSITOOEM("Acceso Web");
                    WHEN (AccessField("DPUSUARIOS","OPE_ACCWEB",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_ACCWEB:cMsg    :="Acceso Web"
    oUSUARIOS:oOPE_ACCWEB:cToolTip:="Acceso Web"


  //
  // Campo : OPE_MAPMNU
  // Uso   : Mapa de Menú                            
  //
  @ 10.0, 1.0 BMPGET oUSUARIOS:oOPE_MAPMNU  VAR oUSUARIOS:OPE_MAPMNU ;
                   VALID oUSUARIOS:oDPMAPAMNU:SeekTable("MMN_CODIGO",oUSUARIOS:oOPE_MAPMNU,NIL,oUSUARIOS:oMMN_DESCRI);
                   NAME "BITMAPS\FIND.BMP"; 
                   ACTION (oDpLbx:=DpLbx("DPMAPAMNU",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPMNU),;
                           oDpLbx:GetValue("MMN_CODIGO",oUSUARIOS:oOPE_MAPMNU)); 
                   WHEN (AccessField("DPUSUARIOS","OPE_MAPMNU",oUSUARIOS:nOption);
                   .AND. oUSUARIOS:nOption!=0);
                   FONT oFont COLOR nClrText,NIL SIZE NIL,10

// oDpLbx:=DpLbx("DPVENDEDOR",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPMNU)

    oUSUARIOS:oOPE_MAPMNU:cMsg    :="Mapa de Menú"
    oUSUARIOS:oOPE_MAPMNU:cToolTip:="Mapa de Menú"

  @ oUSUARIOS:oOPE_MAPMNU:nTop-08,oUSUARIOS:oOPE_MAPMNU:nLeft SAY "Menú" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT

//oUSUARIOS:oDPMAPAMNU:cSingular
  @ oUSUARIOS:oOPE_MAPMNU:nTop,oUSUARIOS:oOPE_MAPMNU:nRight+5 SAY oUSUARIOS:oMMN_DESCRI;
                            PROMPT oUSUARIOS:oDPMAPAMNU:MMN_DESCRI PIXEL;
                            SIZE NIL,12 FONT oFont COLOR 16777215,16711680  


  //
  // Campo : OPE_MAPTAB
  // Uso   : Mapa de Tablas                          
  //
  @ 1.0,15.0 BMPGET oUSUARIOS:oOPE_MAPTAB  VAR oUSUARIOS:OPE_MAPTAB ;
                    VALID oUSUARIOS:oDPMAPATAB:SeekTable("MAT_CODIGO",oUSUARIOS:oOPE_MAPTAB,NIL,oUSUARIOS:oMAT_DESCRI);
                    NAME "BITMAPS\FIND.BMP"; 
                    ACTION (oDpLbx:=DpLbx("DPMAPATAB",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPTAB),; 
                            oDpLbx:GetValue("MAT_CODIGO",oUSUARIOS:oOPE_MAPTAB)); 
                    WHEN (AccessField("DPUSUARIOS","OPE_MAPTAB",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MAPTAB:cMsg    :="Mapa de Tablas"
    oUSUARIOS:oOPE_MAPTAB:cToolTip:="Mapa de Tablas"

  @ oUSUARIOS:oOPE_MAPTAB:nTop-08,oUSUARIOS:oOPE_MAPTAB:nLeft SAY "Tabla" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT	

  @ oUSUARIOS:oOPE_MAPTAB:nTop,oUSUARIOS:oOPE_MAPTAB:nRight+5 SAY oUSUARIOS:oMAT_DESCRI;
                            PROMPT oUSUARIOS:oDPMAPATAB:MAT_DESCRI PIXEL;
                            SIZE NIL,12 FONT oFont COLOR 16777215,16711680  



  //
  // Campo : OPE_MAPCAM
  // Uso   : Mapa de Campos
  //
  @ 1.0,15.0 BMPGET oUSUARIOS:oOPE_MAPCAM  VAR oUSUARIOS:OPE_MAPCAM ;
                    VALID oUSUARIOS:oDPMAPACAM:SeekTable("MAC_CODIGO",oUSUARIOS:oOPE_MAPCAM,NIL,oUSUARIOS:oMAC_DESCRI);
                    NAME "BITMAPS\FIND.BMP"; 
                    ACTION (oDpLbx:=DpLbx("DPMAPACAM",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPCAM),;
                            oDpLbx:GetValue("MAC_CODIGO",oUSUARIOS:oOPE_MAPCAM)); 
                    WHEN (AccessField("DPUSUARIOS","OPE_MAPCAM",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MAPCAM:cMsg    :="Mapa de Tablas"
    oUSUARIOS:oOPE_MAPCAM:cToolTip:="Mapa de Tablas"


  //
  // Campo : OPE_MAPBAR
  // Uso   : Mapa de Barra de Botones
  //
  @ 1.0,15.0 BMPGET oUSUARIOS:oOPE_MAPBAR  VAR oUSUARIOS:OPE_MAPBAR ;
                    VALID oUSUARIOS:oDPMAPBAR:SeekTable("MBB_CODIGO",oUSUARIOS:oOPE_MAPBAR,NIL,oUSUARIOS:oMBB_DESCRI);
                    NAME "BITMAPS\FIND.BMP"; 
                    ACTION (oDpLbx:=DpLbx("DPMAPBAR",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPBAR),;
                            oDpLbx:GetValue("MBB_CODIGO",oUSUARIOS:oOPE_MAPBAR)); 
                    WHEN (AccessField("DPUSUARIOS","OPE_MAPBAR",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MAPBAR:cMsg    :="Mapa de Barra de Botones"
    oUSUARIOS:oOPE_MAPBAR:cToolTip:="Mapa de Barra de Botones"



  // 
  // Campo : OPE_MAPPRC
  // Uso   : Mapa de Procesos
  //
  @ 1.0,15.0 BMPGET oUSUARIOS:oOPE_MAPPRC  VAR oUSUARIOS:OPE_MAPPRC ;
                    VALID oUSUARIOS:oDPMAPAPRC:SeekTable("MPA_CODIGO",oUSUARIOS:oOPE_MAPPRC,NIL,oUSUARIOS:oMPA_DESCRI);
                    NAME "BITMAPS\FIND.BMP"; 
                    ACTION (oDpLbx:=DpLbx("DPMAPAPRC",NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,oUSUARIOS:oOPE_MAPPRC),;
                            oDpLbx:GetValue("MPA_CODIGO",oUSUARIOS:oOPE_MAPPRC)); 
                    WHEN (AccessField("DPUSUARIOS","OPE_MAPPRC",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MAPPRC:cMsg    :="Mapa de Procesos Automáticos"
    oUSUARIOS:oOPE_MAPPRC:cToolTip:="Mapa de Procesos Automáticos"

  //
  // Campo : OPE_LUNES 
  // Uso   : Lunes                                   
  //
  @ 2.8,15.0 CHECKBOX oUSUARIOS:oOPE_LUNES   VAR oUSUARIOS:OPE_LUNES   PROMPT ANSITOOEM("Lunes");
                    WHEN (AccessField("DPUSUARIOS","OPE_LUNES",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_LUNES :cMsg    :="Lunes"
    oUSUARIOS:oOPE_LUNES :cToolTip:="Lunes"


  //
  // Campo : OPE_LUNAIN
  // Uso   : Lunes Inicio Am                         
  //
  @ 4.6,15.0 GET oUSUARIOS:oOPE_LUNAIN  VAR oUSUARIOS:OPE_LUNAIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_LUNAIN",oUSUARIOS:nOption);
                          .AND. oUSUARIOS:OPE_LUNES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_LUNAIN:cMsg    :="Lunes Inicio Am"
    oUSUARIOS:oOPE_LUNAIN:cToolTip:="Lunes Inicio Am"


  //
  // Campo : OPE_LUNAFI
  // Uso   : Lunes Fin Am                            
  //
  @ 6.4,15.0 GET oUSUARIOS:oOPE_LUNAFI  VAR oUSUARIOS:OPE_LUNAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_LUNAFI",oUSUARIOS:nOption);
                          .AND. oUSUARIOS:OPE_LUNES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_LUNAFI:cMsg    :="Lunes Fin Am"
    oUSUARIOS:oOPE_LUNAFI:cToolTip:="Lunes Fin Am"


  //
  // Campo : OPE_LUNPIN
  // Uso   : Lunes Inicio Pm                         
  //
  @ 8.2,15.0 GET oUSUARIOS:oOPE_LUNPIN  VAR oUSUARIOS:OPE_LUNPIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_LUNPIN",oUSUARIOS:nOption);
                          .AND. oUSUARIOS:OPE_LUNES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_LUNPIN:cMsg    :="Lunes Inicio Pm"
    oUSUARIOS:oOPE_LUNPIN:cToolTip:="Lunes Inicio Pm"


  //
  // Campo : OPE_LUNPFI
  // Uso   : Lunes Fin Pm                            
  //
  @ 10.0,15.0 GET oUSUARIOS:oOPE_LUNPFI  VAR oUSUARIOS:OPE_LUNPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_LUNPFI",oUSUARIOS:nOption);
                         .AND. oUSUARIOS:OPE_LUNES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_LUNPFI:cMsg    :="Lunes Fin Pm"
    oUSUARIOS:oOPE_LUNPFI:cToolTip:="Lunes Fin Pm"


  //
  // Campo : OPE_MARTES
  // Uso   : Martes                                  
  //
  @ 11.8,15.0 CHECKBOX oUSUARIOS:oOPE_MARTES  VAR oUSUARIOS:OPE_MARTES  PROMPT ANSITOOEM("Martes");
                    WHEN (AccessField("DPUSUARIOS","OPE_MARTES",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MARTES:cMsg    :="Martes"
    oUSUARIOS:oOPE_MARTES:cToolTip:="Martes"


  //
  // Campo : OPE_MARAIN
  // Uso   : Martes Inicio Am                        
  //
  @ 1.0,29.0 GET oUSUARIOS:oOPE_MARAIN  VAR oUSUARIOS:OPE_MARAIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_MARAIN",oUSUARIOS:nOption);
                         .AND. oUSUARIOS:OPE_MARTES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MARAIN:cMsg    :="Martes Inicio Am"
    oUSUARIOS:oOPE_MARAIN:cToolTip:="Martes Inicio Am"


  //
  // Campo : OPE_MARAFI
  // Uso   : Martes Fin Am                           
  //
  @ 2.8,29.0 GET oUSUARIOS:oOPE_MARAFI  VAR oUSUARIOS:OPE_MARAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_MARAFI",oUSUARIOS:nOption);
                        .AND. oUSUARIOS:OPE_MARTES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MARAFI:cMsg    :="Martes Fin Am"
    oUSUARIOS:oOPE_MARAFI:cToolTip:="Martes Fin Am"


  //
  // Campo : OPE_MARPIN
  // Uso   : Martes Inicio Pm                        
  //
  @ 4.6,29.0 GET oUSUARIOS:oOPE_MARPIN  VAR oUSUARIOS:OPE_MARPIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_MARPIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_MARTES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MARPIN:cMsg    :="Martes Inicio Pm"
    oUSUARIOS:oOPE_MARPIN:cToolTip:="Martes Inicio Pm"


  //
  // Campo : OPE_MARPFI
  // Uso   : Martes Fin Pm                           
  //
  @ 6.4,29.0 GET oUSUARIOS:oOPE_MARPFI  VAR oUSUARIOS:OPE_MARPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_MARPFI",oUSUARIOS:nOption);
                         .AND. oUSUARIOS:OPE_MARTES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MARPFI:cMsg    :="Martes Fin Pm"
    oUSUARIOS:oOPE_MARPFI:cToolTip:="Martes Fin Pm"


  //
  // Campo : OPE_MIERCO
  // Uso   : Miercoles                               
  //
  @ 8.2,29.0 CHECKBOX oUSUARIOS:oOPE_MIERCO  VAR oUSUARIOS:OPE_MIERCO  PROMPT ANSITOOEM("Miercoles");
                    WHEN (AccessField("DPUSUARIOS","OPE_MIERCO",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MIERCO:cMsg    :="Miercoles"
    oUSUARIOS:oOPE_MIERCO:cToolTip:="Miercoles"


  //
  // Campo : OPE_MIEAIN
  // Uso   : Miercoles Inicio Am                     
  //
  @ 10.0,29.0 GET oUSUARIOS:oOPE_MIEAIN  VAR oUSUARIOS:OPE_MIEAIN ;
                  PICTURE "99:99";
                  WHEN (AccessField("DPUSUARIOS","OPE_MIEAIN",oUSUARIOS:nOption);
                        .AND. oUSUARIOS:OPE_MIERCO;
                  .AND. oUSUARIOS:nOption!=0);
                  FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MIEAIN:cMsg    :="Miercoles Inicio Am"
    oUSUARIOS:oOPE_MIEAIN:cToolTip:="Miercoles Inicio Am"


  //
  // Campo : OPE_MIEAFI
  // Uso   : Miercoles Fin Am                        
  //
  @ 11.8,29.0 GET oUSUARIOS:oOPE_MIEAFI  VAR oUSUARIOS:OPE_MIEAFI ;
                  PICTURE "99:99";
                  WHEN (AccessField("DPUSUARIOS","OPE_MIEAFI",oUSUARIOS:nOption);
                       .AND. oUSUARIOS:OPE_MIERCO;
                  .AND. oUSUARIOS:nOption!=0);
                   FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MIEAFI:cMsg    :="Miercoles Fin Am"
    oUSUARIOS:oOPE_MIEAFI:cToolTip:="Miercoles Fin Am"


  //
  // Campo : OPE_MIEPIN
  // Uso   : MIercoles Inicio Pm                     
  //
  @ 1.0,43.0 GET oUSUARIOS:oOPE_MIEPIN  VAR oUSUARIOS:OPE_MIEPIN ;
                 PICTURE "99:99";
                 WHEN (AccessField("DPUSUARIOS","OPE_MIEPIN",oUSUARIOS:nOption);
                       .AND. oUSUARIOS:OPE_MIERCO;
                 .AND. oUSUARIOS:nOption!=0);
                 FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MIEPIN:cMsg    :="MIercoles Inicio Pm"
    oUSUARIOS:oOPE_MIEPIN:cToolTip:="MIercoles Inicio Pm"


  //
  // Campo : OPE_MIEPFI
  // Uso   : Miercoles Fin Pm                        
  //
  @ 2.8,43.0 GET oUSUARIOS:oOPE_MIEPFI  VAR oUSUARIOS:OPE_MIEPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_MIEPFI",oUSUARIOS:nOption);
                         .AND. oUSUARIOS:OPE_MIERCO;
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_MIEPFI:cMsg    :="Miercoles Fin Pm"
    oUSUARIOS:oOPE_MIEPFI:cToolTip:="Miercoles Fin Pm"


  //
  // Campo : OPE_JUEVES
  // Uso   : Jueves                                  
  //
  @ 4.6,43.0 CHECKBOX oUSUARIOS:oOPE_JUEVES  VAR oUSUARIOS:OPE_JUEVES  PROMPT ANSITOOEM("Jueves");
                    WHEN (AccessField("DPUSUARIOS","OPE_JUEVES",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_JUEVES:cMsg    :="Jueves"
    oUSUARIOS:oOPE_JUEVES:cToolTip:="Jueves"


  //
  // Campo : OPE_JUEAIN
  // Uso   : Jueves Inicio Am                        
  //
  @ 6.4,43.0 GET oUSUARIOS:oOPE_JUEAIN  VAR oUSUARIOS:OPE_JUEAIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_JUEAIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_JUEVES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_JUEAIN:cMsg    :="Jueves Inicio Am"
    oUSUARIOS:oOPE_JUEAIN:cToolTip:="Jueves Inicio Am"


  //
  // Campo : OPE_JUEAFI
  // Uso   : Jueves Fin Am                           
  //
  @ 8.2,43.0 GET oUSUARIOS:oOPE_JUEAFI  VAR oUSUARIOS:OPE_JUEAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_JUEAFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_JUEVES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_JUEAFI:cMsg    :="Jueves Fin Am"
    oUSUARIOS:oOPE_JUEAFI:cToolTip:="Jueves Fin Am"


  //
  // Campo : OPE_JUEPIN
  // Uso   : Jueves Inicio Pm                        
  //
  @ 10.0,43.0 GET oUSUARIOS:oOPE_JUEPIN  VAR oUSUARIOS:OPE_JUEPIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_JUEPIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_JUEVES;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_JUEPIN:cMsg    :="Jueves Inicio Pm"
    oUSUARIOS:oOPE_JUEPIN:cToolTip:="Jueves Inicio Pm"


  //
  // Campo : OPE_JUEPFI
  // Uso   : Jueves Fin Pm                           
  //
  @ 11.8,43.0 GET oUSUARIOS:oOPE_JUEPFI  VAR oUSUARIOS:OPE_JUEPFI ;
                  PICTURE "99:99";
                  WHEN (AccessField("DPUSUARIOS","OPE_JUEPFI",oUSUARIOS:nOption);
                  .AND. oUSUARIOS:OPE_JUEVES;
                  .AND. oUSUARIOS:nOption!=0);
                  FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_JUEPFI:cMsg    :="Jueves Fin Pm"
    oUSUARIOS:oOPE_JUEPFI:cToolTip:="Jueves Fin Pm"


  //
  // Campo : OPE_VIERNE
  // Uso   : Viernes                                 
  //
  @ 1.0,57.0 CHECKBOX oUSUARIOS:oOPE_VIERNE  VAR oUSUARIOS:OPE_VIERNE  PROMPT ANSITOOEM("Viernes");
                    WHEN (AccessField("DPUSUARIOS","OPE_VIERNE",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_VIERNE:cMsg    :="Viernes"
    oUSUARIOS:oOPE_VIERNE:cToolTip:="Viernes"


  //
  // Campo : OPE_VIEAIN
  // Uso   : Viernes Inicio Am                       
  //
  @ 2.8,57.0 GET oUSUARIOS:oOPE_VIEAIN  VAR oUSUARIOS:OPE_VIEAIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_VIEAIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_VIERNE;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_VIEAIN:cMsg    :="Viernes Inicio Am"
    oUSUARIOS:oOPE_VIEAIN:cToolTip:="Viernes Inicio Am"


  //
  // Campo : OPE_VIEAFI
  // Uso   : Viernes Fin Am                          
  //
  @ 4.6,57.0 GET oUSUARIOS:oOPE_VIEAFI  VAR oUSUARIOS:OPE_VIEAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_VIEAFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_VIERNE;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_VIEAFI:cMsg    :="Viernes Fin Am"
    oUSUARIOS:oOPE_VIEAFI:cToolTip:="Viernes Fin Am"


  //
  // Campo : OPE_VIEPIN
  // Uso   : Viernes Inicio Pm                       
  //
  @ 6.4,57.0 GET oUSUARIOS:oOPE_VIEPIN  VAR oUSUARIOS:OPE_VIEPIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_VIEPIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_VIERNE;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_VIEPIN:cMsg    :="Viernes Inicio Pm"
  oUSUARIOS:oOPE_VIEPIN:cToolTip:="Viernes Inicio Pm"


  //
  // Campo : OPE_VIEPFI
  // Uso   : Viernes Fin Pm                          
  //
  @ 8.2,57.0 GET oUSUARIOS:oOPE_VIEPFI  VAR oUSUARIOS:OPE_VIEPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_VIEPFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_VIERNE;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_VIEPFI:cMsg    :="Viernes Fin Pm"
  oUSUARIOS:oOPE_VIEPFI:cToolTip:="Viernes Fin Pm"


  //
  // Campo : OPE_SABADO
  // Uso   : Sábado                                  
  //
  @ 10.0,57.0 CHECKBOX oUSUARIOS:oOPE_SABADO  VAR oUSUARIOS:OPE_SABADO  PROMPT ANSITOOEM("Sábado");
                    WHEN (AccessField("DPUSUARIOS","OPE_SABADO",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_SABADO:cMsg    :="Sábado"
  oUSUARIOS:oOPE_SABADO:cToolTip:="Sábado"


  //
  // Campo : OPE_SABAIN
  // Uso   : Sabado Inicio Am                        
  //
  @ 11.8,57.0 GET oUSUARIOS:oOPE_SABAIN  VAR oUSUARIOS:OPE_SABAIN ;
                   PICTURE "99:99";
                   WHEN (AccessField("DPUSUARIOS","OPE_SABAIN",oUSUARIOS:nOption);
                   .AND. oUSUARIOS:OPE_SABADO;
                   .AND. oUSUARIOS:nOption!=0);
                    FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_SABAIN:cMsg    :="Sabado Inicio Am"
  oUSUARIOS:oOPE_SABAIN:cToolTip:="Sabado Inicio Am"


  //
  // Campo : OPE_SABAFI
  // Uso   : Sabado Fin Am                           
  //
  @ 1.0,71.0 GET oUSUARIOS:oOPE_SABAFI  VAR oUSUARIOS:OPE_SABAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_SABAFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_SABADO;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_SABAFI:cMsg    :="Sabado Fin Am"
  oUSUARIOS:oOPE_SABAFI:cToolTip:="Sabado Fin Am"

  //
  // Campo : OPE_SABPIN
  // Uso   : Sabado Inicio Pm                        
  //
  @ 2.8,71.0 GET oUSUARIOS:oOPE_SABPIN  VAR oUSUARIOS:OPE_SABPIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_SABPIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_SABADO;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_SABPIN:cMsg    :="Sabado Inicio Pm"
    oUSUARIOS:oOPE_SABPIN:cToolTip:="Sabado Inicio Pm"


  //
  // Campo : OPE_SABPFI
  // Uso   : Sabado Fin Pm                           
  //
  @ 4.6,71.0 GET oUSUARIOS:oOPE_SABPFI  VAR oUSUARIOS:OPE_SABPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_SABPFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_SABADO;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_SABPFI:cMsg    :="Sabado Fin Pm"
    oUSUARIOS:oOPE_SABPFI:cToolTip:="Sabado Fin Pm"


  //
  // Campo : OPE_DOMING
  // Uso   : Domingo                                 
  //
  @ 6.4,71.0 CHECKBOX oUSUARIOS:oOPE_DOMING  VAR oUSUARIOS:OPE_DOMING  PROMPT ANSITOOEM("Domingo");
                    WHEN (AccessField("DPUSUARIOS","OPE_DOMING",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_DOMING:cMsg    :="Domingo"
    oUSUARIOS:oOPE_DOMING:cToolTip:="Domingo"


  //
  // Campo : OPE_DOMAIN
  // Uso   : Domingo Inicio Am                       
  //
  @ 8.2,71.0 GET oUSUARIOS:oOPE_DOMAIN  VAR oUSUARIOS:OPE_DOMAIN ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_DOMAIN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_DOMING;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_DOMAIN:cMsg    :="Domingo Inicio Am"
    oUSUARIOS:oOPE_DOMAIN:cToolTip:="Domingo Inicio Am"


  //
  // Campo : OPE_DOMAFI
  // Uso   : Domingo Fin Am                          
  //
  @ 10.0,71.0 GET oUSUARIOS:oOPE_DOMAFI  VAR oUSUARIOS:OPE_DOMAFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_DOMAFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_DOMING;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_DOMAFI:cMsg    :="Domingo Fin Am"
    oUSUARIOS:oOPE_DOMAFI:cToolTip:="Domingo Fin Am"


  //
  // Campo : OPE_DOMPIN
  // Uso   : Domingo Inicio Pm                       
  //
  @ 11.8,71.0 GET oUSUARIOS:oOPE_DOMPIN  VAR oUSUARIOS:OPE_DOMPIN ;
                   PICTURE "99:99";
                   WHEN (AccessField("DPUSUARIOS","OPE_DOMPIN",oUSUARIOS:nOption);
                   .AND. oUSUARIOS:OPE_DOMING;
                   .AND. oUSUARIOS:nOption!=0);
                   FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_DOMPIN:cMsg    :="Domingo Inicio Pm"
    oUSUARIOS:oOPE_DOMPIN:cToolTip:="Domingo Inicio Pm"


  //
  // Campo : OPE_DOMPFI
  // Uso   : Domingo Fin Pm                          
  //
  @ 1.0,85.0 GET oUSUARIOS:oOPE_DOMPFI  VAR oUSUARIOS:OPE_DOMPFI ;
                    PICTURE "99:99";
                    WHEN (AccessField("DPUSUARIOS","OPE_DOMPFI",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:OPE_DOMING;
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_DOMPFI:cMsg    :="Domingo Fin Pm"
    oUSUARIOS:oOPE_DOMPFI:cToolTip:="Domingo Fin Pm"


  @ 10,10 SAY "Am:" RIGHT
  @ 11,10 SAY "Pm:" RIGHT

  //
  // Campo : OPE_ERPEMN
  // Uso   : Grabar para eManager                           
  //

  @ 2.2, 1.0 CHECKBOX oUSUARIOS:oOPE_ERPEMN  VAR oUSUARIOS:OPE_ERPEMN  PROMPT ANSITOOEM("Grabar para eManager");
                    WHEN (AccessField("DPUSUARIOS","OPE_ERPEMN",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

    oUSUARIOS:oOPE_ERPEMN:cMsg    :="Grabar para eManager"
    oUSUARIOS:oOPE_ERPEMN:cToolTip:="Grabar para eManager"


  //
  // Campo : OPE_ACTIVO
  // Uso   : Activo                                 
  //
  @ 11.8,15.0 CHECKBOX oUSUARIOS:oOPE_ACTIVO  VAR oUSUARIOS:OPE_ACTIVO  PROMPT ANSITOOEM("Activo");
                       WHEN (AccessField("DPUSUARIOS","OPE_ACTIVO",oUSUARIOS:nOption));
                       FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_ACTIVO:cMsg    :="Usuario Activo"
  oUSUARIOS:oOPE_ACTIVO:cToolTip:="Usuario Activo"

  //
  // Campo : OPE_AUDAPP
  // Uso   : Auditoria de Aplicaciones                             
  //
  @ 12,15.0 CHECKBOX oUSUARIOS:oOPE_AUDAPP  VAR oUSUARIOS:OPE_AUDAPP  PROMPT ANSITOOEM("Auditoria de Aplicaciones");
                    WHEN (AccessField("DPUSUARIOS","OPE_AUDAPP",oUSUARIOS:nOption));
                     FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_AUDAPP:cMsg    :="Auditoria de Aplicaciones"
  oUSUARIOS:oOPE_AUDAPP:cToolTip:="Auditoria de Aplicaciones"

  // Campo : OPE_ALLPC
  // Uso   : Accede desde todos los PC                         
  //
  @ 12,15.0 CHECKBOX oUSUARIOS:oOPE_ALLPC  VAR oUSUARIOS:OPE_ALLPC  PROMPT ANSITOOEM("Accede desde Todos los PC");
            WHEN (AccessField("DPUSUARIOS","OPE_ALLPC",oUSUARIOS:nOption));
                  FONT oFont COLOR nClrText,NIL SIZE NIL,10

  oUSUARIOS:oOPE_ALLPC:cMsg    :="Accede desde todos los PC"
  oUSUARIOS:oOPE_ALLPC:cToolTip:="Accede desde todos los PC"

  //
  // Campo : OPE_CEDULA
  // Uso   : cédula                               
  //
  @ 12, 1.0 GET oUSUARIOS:oOPE_CEDULA  VAR oUSUARIOS:OPE_CEDULA;
                    VALID oUSUARIOS:ValUnique(oUSUARIOS:OPE_CEDULA);
                    WHEN (AccessField("DPUSUARIOS","OPE_CEDULA",oUSUARIOS:nOption);
                    .AND. oUSUARIOS:nOption!=0);
                    FONT oFontG

  oUSUARIOS:oOPE_CEDULA:cMsg    :="Cédula"
  oUSUARIOS:oOPE_CEDULA:cToolTip:="Cédula"

  @ oUSUARIOS:oOPE_CEDULA:nTop-08,oUSUARIOS:oOPE_CEDULA:nLeft SAY "Cédula:" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT

  //
  // Campo : OPE_MINOFF
  // Uso   : Tiempo sin Uso
  //
  @ 12, 1.0 GET oUSUARIOS:oOPE_MINOFF  VAR oUSUARIOS:OPE_MINOFF PICTURE "999" SPINNER RIGHT;
                WHEN (AccessField("DPUSUARIOS","OPE_MINOFF",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0;
                     .AND. oDp:nVersion>=6);
                FONT oFontG

  oUSUARIOS:oOPE_MINOFF:cMsg    :="Auditar Minutos sin Uso"
  oUSUARIOS:oOPE_MINOFF:cToolTip:="Auditar Minutos sin uso"


  @ oUSUARIOS:oOPE_MINOFF:nTop-08,oUSUARIOS:oOPE_MINOFF:nLeft SAY "Auditar Minutos"+CRLF+"sin Uso:" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL  RIGHT

  //
  // Campo : OPE_DIACLA
  // Uso   : Vigencia de Tiempo sin Uso
  //
  @ 12, 10 GET oUSUARIOS:oOPE_DIACLA  VAR oUSUARIOS:OPE_DIACLA PICTURE "999" SPINNER RIGHT;
               WHEN (AccessField("DPUSUARIOS","OPE_DIACLA",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0;
                    .AND. oDp:lVenceClave);
               FONT oFontG

  oUSUARIOS:oOPE_DIACLA:cMsg    :="Días para la Vigencia de la Clave"
  oUSUARIOS:oOPE_DIACLA:cToolTip:=oUSUARIOS:oOPE_DIACLA:cMsg


  @ oUSUARIOS:oOPE_DIACLA:nTop-08,oUSUARIOS:oOPE_DIACLA:nLeft SAY "Vigencia de"+CRLF+"Clave en Días:" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT


  //
  // Campo : OPE_FCHFIN 
  // Uso   : Cargo                                   
  //
  @ 12, 10 BMPGET oUSUARIOS:oOPE_FCHFIN   VAR oUSUARIOS:OPE_FCHFIN  ;
                  PICTURE oDp:cFormatoFecha;
                  NAME "BITMAPS\Calendar.bmp";
                  ACTION LbxDate(oUSUARIOS:oOPE_FCHFIN,oUSUARIOS:OPE_FCHFIN);
                  WHEN (AccessField("DPUSUARIOS","OPE_FCHFIN",oUSUARIOS:nOption);
                        .AND. oUSUARIOS:nOption!=0 .AND. oDp:lVenceClave);
                  FONT oFontG

    oUSUARIOS:oOPE_FCHFIN :cMsg    :="Fecha Máxima de Uso"
    oUSUARIOS:oOPE_FCHFIN :cToolTip:="Fecha Máxima de Uso"

  @ oUSUARIOS:oOPE_FCHFIN :nTop-08,oUSUARIOS:oOPE_FCHFIN :nLeft SAY "Fecha Máxima"+CRLF+"de Uso:" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT


  @ oUSUARIOS:oOPE_MAPCAM:nTop,oUSUARIOS:oOPE_MAPCAM:nRight+5 SAY oUSUARIOS:oMAC_DESCRI;
                            PROMPT oUSUARIOS:oDPMAPACAM:MAC_DESCRI PIXEL;
                            SIZE NIL,12 FONT oFont COLOR 16777215,16711680  

  @ oUSUARIOS:oOPE_MAPCAM:nTop-08,oUSUARIOS:oOPE_MAPCAM:nLeft SAY "Campos" PIXEL;
                            SIZE NIL,7 FONT oFont COLOR nClrText,NIL RIGHT

  @ 15,01 SAY "Correo:" RIGHT
  @ 16,01 SAY "Firma :" RIGHT
  @ 15,10 SAY "Tel. :"  RIGHT
  @ 16,10 SAY "Ext. :"  RIGHT

  @ 16,10 SAY "Botones"  RIGHT


  @ 10,10 SAY oUSUARIOS:oMBB_DESCRI;
          PROMPT oUSUARIOS:oDPMAPBAR:MBB_DESCRI PIXEL;
          SIZE NIL,12 FONT oFont COLOR 16777215,16711680  

  //
  // Campo : OPE_EMAIL
  // Uso   : Correo Electrónico
  //

  @ 15, 10 GET oUSUARIOS:oOPE_EMAIL  VAR oUSUARIOS:OPE_EMAIL; 
               WHEN (AccessField("DPUSUARIOS","OPE_EMAIL",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0);
               FONT oFontG

  oUSUARIOS:oOPE_EMAIL:cMsg    :="Correo Electrónico"
  oUSUARIOS:oOPE_EMAIL:cToolTip:=oUSUARIOS:oOPE_EMAIL:cMsg

  //
  // Campo : OPE_FIRMA
  // Uso   : Firma Correo Electrónico
  //

  @ 15, 10 GET oUSUARIOS:oOPE_FIRMA  VAR oUSUARIOS:OPE_FIRMA; 
               WHEN (AccessField("DPUSUARIOS","OPE_FIRMA",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0);
               FONT oFontG

  oUSUARIOS:oOPE_FIRMA:cMsg    :="Firma para Correo Electrónico"
  oUSUARIOS:oOPE_FIRMA:cToolTip:=oUSUARIOS:oOPE_FIRMA:cMsg


  //
  // Campo : OPE_TELEFO
  // Uso   : Telefono
  //

  @ 15, 20 GET oUSUARIOS:oOPE_TELEFO  VAR oUSUARIOS:OPE_TELEFO; 
               WHEN (AccessField("DPUSUARIOS","OPE_TELEFO",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0);
               FONT oFontG

  oUSUARIOS:oOPE_TELEFO:cMsg    :="TELEFO para Correo Electrónico"
  oUSUARIOS:oOPE_TELEFO:cToolTip:=oUSUARIOS:oOPE_TELEFO:cMsg

  //
  // Campo : OPE_EXT
  // Uso   : Extensión
  //

  @ 15, 10 GET oUSUARIOS:oOPE_EXT  VAR oUSUARIOS:OPE_EXT; 
               WHEN (AccessField("DPUSUARIOS","OPE_EXT",oUSUARIOS:nOption) .AND. oUSUARIOS:nOption!=0);
               FONT oFontG

  oUSUARIOS:oOPE_EXT:cMsg    :="Extensión "
  oUSUARIOS:oOPE_EXT:cToolTip:=oUSUARIOS:oOPE_EXT:cMsg

  @ 5,1 SAY "Proceso" RIGHT

  @ oUSUARIOS:oOPE_MAPPRC:nTop,oUSUARIOS:oOPE_MAPPRC:nRight+5 SAY oUSUARIOS:oMPA_DESCRI;
                            PROMPT oUSUARIOS:oDPMAPAPRC:MPA_DESCRI PIXEL;
                            SIZE NIL,12 FONT oFont COLOR 16777215,16711680  

  oUSUARIOS:Activate({||oUSUARIOS:ViewDatBar()})

  STORE NIL TO oTable,oGet,oFont,oGetB,oFontG

RETURN oUSUARIOS

/*
// Barra de Botones
*/
FUNCTION ViewDatBar(oUSFACE)
   LOCAL oCursor,oBar,oBtn,oFont,oCol
   LOCAL oDlg:=oUSUARIOS:oDlg

   DEFINE CURSOR oCursor HAND
   DEFINE BUTTONBAR oBar SIZE 52-15,60-15 OF oDlg 3D CURSOR oCursor
   DEFINE FONT oFont  NAME "TAHOMA"   SIZE 0, -12 BOLD

   IF oUSUARIOS:nOption!=2

     DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\XSAVE.BMP";
            ACTION oUSUARIOS:Save()

     oBtn:cToolTip:="Guardar"

     DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\XCANCEL.BMP";
            ACTION oUSUARIOS:CANCEL()

     oBtn:cToolTip:="Cancelar"


   ELSE

     DEFINE BUTTON oBtn;
            OF oBar;
            NOBORDER;
            FONT oFont;
            FILENAME "BITMAPS\XSALIR.BMP";
            ACTION (oUSUARIOS:Cancel()) CANCEL

     oBtn:cToolTip:="Cancelar y Cerrar"

   ENDIF

   oBar:SetColor(0,oDp:nGris)
   AEVAL(oBar:aControls,{|o,n| o:SetColor(0,oDp:nGris)})

RETURN .T.


/*
// Carga de Datos, para Incluir
*/
FUNCTION LOAD()

  IF oUSUARIOS:nOption=1 // Incluir en caso de ser Incremental
     oUSUARIOS:OPE_NUMERO:=oUSUARIOS:Incremental("OPE_NUMERO",.F.)
  ENDIF

RETURN .T.
/*
// Ejecuta Cancelar
*/
FUNCTION CANCEL()
RETURN .T.

/*
// Ejecución PreGrabar
*/
FUNCTION PRESAVE()
  LOCAL lResp:=.T.

  IF !oDp:lVenceClave
     oUSUARIOS:OPE_FCHFIN:=CTOD("")
  ENDIF

  IF !oUSUARIOS:VALUSUARIO()
     RETURN .F.
  ENDIF

  IF EMPTY(oUSUARIOS:OPE_NUMERO)
     MensajeErr("Numero no Puede estar Vacio")
     RETURN .F.
  ENDIF

  IF Empty(oDp:cCodSas)
     oDp:cCodSas:=STRZERO(0,4)
  ENDIF

  IF !ISSQLFIND("DPAFILIASAS","SAS_ID"+GetWhere("=",oDp:cCodSas))
     EJECUTAR("DPAFILIASAS_CREA")
  ENDIF


  IF Empty(oUSUARIOS:OPE_CODSAS)
    oUSUARIOS:OPE_CODSAS:=oDp:cCodSas
  ENDIF


  IF !EJECUTAR("VALCLAVE",oUSUARIOS:oOPE_NOMBRE,oUSUARIOS:oOPE_CLAVE)
     RETURN .F.
  ENDIF

  IF !EJECUTAR("EMAILVALID",oUSUARIOS:OPE_EMAIL)
     oUSUARIOS:oOPE_EMAIL:MsgErr("Correo Inválido","Campo Requerido")
     RETURN .F.
  ENDIF

  IF Empty(oUSUARIOS:OPE_EMAIL)
     oUSUARIOS:oOPE_EMAIL:MsgErr("Necesario para la Oficina Virtual","Corre Requerido")
     RETURN .F.
  ENDIF

  oUSUARIOS:OPE_FCHING:=IIF(Empty(oUSUARIOS:OPE_FCHING),oDp:dFecha,oUSUARIOS:OPE_FCHING)
  oUSUARIOS:OPE_FCHACT:=oDp:dFecha

RETURN lResp

/*
// Ejecución despues de Grabar
*/
FUNCTION POSTSAVE()
  LOCAL aCodEmp:={},I,oTable
  LOCAL cNombre:=ENCRIPT(oUSUARIOS:OPE_NOMBRE,.T.)
  LOCAL cClave :=ENCRIPT(oUSUARIOS:OPE_CLAVE ,.T.)
  LOCAL cCargo :=ENCRIPT(oUSUARIOS:OPE_CARGO ,.T.)
  LOCAL dFchCla:=DPFECHA()+oUSUARIOS:OPE_DIACLA

  SQLUPDATE("DPUSUARIOS",{"OPE_NOMBRE","OPE_CLAVE","OPE_CARGO","OPE_FCHCLA","OPE_ENCRIP"},;
                         {cNombre     ,cClave     ,cCargo     ,dFchCla     ,.T.         },;
                         "OPE_NUMERO"+GetWhere("=",oUSUARIOS:OPE_NUMERO))

  EJECUTAR("DPUSUARIOS_MD5",oUSUARIOS:OPE_NUMERO)

  // Si la Clave Cambio o fue creada la clave
  IF oUSUARIOS:nOption=1 .OR. !(ALLTRIM(oUSUARIOS:cClave)=ALLTRIM(oUSUARIOS:OPE_CLAVE))
    EJECUTAR("AUDITORIA","CCLA",.T.,"DPUSUARIOS",oUSUARIOS:OPE_CLAVE,NIL,NIL,NIL,NIL)
  ENDIF

  IF oUSUARIOS:nOption=3 .AND. !oUSUARIOS:OPE_ACTIVO
     EJECUTAR("AUDITORIA","INAC",.T.,"DPUSUARIOS",oUSUARIOS:OPE_NUMERO,NIL,NIL,NIL,NIL)
  ENDIF

  IF oUSUARIOS:nOption=3 .AND. oUSUARIOS:cUser<>oUSUARIOS:OPE_NUMERO

    MsgRun("Actualizando Registro de Usuarios","por favor espere...",;
           {|| EJECUTAR("DPUSUARIOSET", oUSUARIOS:cUser,oUSUARIOS:OPE_NUMERO) })

    /*
    // Creas las Tareas de reemplazo por Cada Empresa
    */

    aCodEmp:=ASQL("SELECT EMP_CODIGO FROM DPEMPRESA")

    oTable:=OpenTable("SELECT * FROM DPEMPSETUSUARIOS",.F.)

    FOR I=1 TO LEN(aCodEmp)

      oTable:AppendBlank()
      oTable:Replace("EXU_CODEMP",aCodEmp[I,1]                )
      oTable:Replace("EXU_CODACT",oUSUARIOS:OPE_NUMERO)
      oTable:Replace("EXU_CODANT",oUSUARIOS:cUser     )
      oTable:Replace("EXU_EJECUT",.F.                 )
      oTable:Commit()

    NEXT I

    oTable:End()   

  ENDIF

  // Usuario Inactivado
  IF !oUSUARIOS:OPE_ACTIVO .OR. oUSUARIOS:nOption=3
     AUDITAR(oDp:cUsuario,.F. ,NIL , "Inactivación del Usuario",oDp:cDpAudita)
  ENDIF

  IF oUSUARIOS:OPE_ACTIVO .OR. oUSUARIOS:nOption=3
     SQLDELETE("DPAUDITORIA","AUD_TIPO"+GetWhere("=","INAC")+" AND AUD_CLAVE"+GetWhere("=",oDp:cUsuario))
  ENDIF

  IF !oUSUARIOS:OPE_ALLPC
     EJECUTAR("DPEMPXUSU",oUSUARIOS:OPE_NUMERO,oUSUARIOS:OPE_NOMBRE,"DPPCLOG","PC Autorizadas del Usuario","PC_NOMBRE","PC_IP")
  ENDIF

  EJECUTAR("DPPRIVILEGIO",oUSUARIOS:OPE_NUMERO,oUSUARIOS:OPE_NOMBRE)

  oUSUARIOS:Close()

  EJECUTAR("DPLOADCNF") // Ahora activa la traza de registro de aplicaciones

RETURN .T.

/*
// Valida Nombre y Clave del Usuario
*/
FUNCTION VALUSUARIO()
   LOCAL lResp:=.T.
   LOCAL cUsuario:=""

   cUsuario:=EJECUTAR("GETUSERNCRIP",oUSUARIOS:OPE_NOMBRE,oUSUARIOS:OPE_CLAVE)

   IF oUSUARIOS:nOption=3 .AND. cUsuario<>oUSUARIOS:cNumero .AND. !Empty(cUsuario)
      oUSUARIOS:oOPE_NUMERO:MsgErr("Este Usuario ya está Registrado con el Numero "+cUsuario)
      lResp:=.F.
   ENDIF 

   IF oUSUARIOS:nOption=1 .AND. !Empty(cUsuario)
      oUSUARIOS:oOPE_NUMERO:MsgErr("Este Usuario ya está Registrado con el Numero "+cUsuario)
      lResp:=.F.
   ENDIF

  
RETURN lResp

/*
<LISTA:OPE_NUMERO:Y:GET:Y:N:Y:Número de Usuario,OPE_NOMBRE:N:GET:N:N:Y:Nombre o Login,OPE_CARGO:N:GET:N:N:Y:Cargo,OPE_CLAVE:N:GET:N:N:Y:Clave
,OPE_ACCWEB:N:CHECKBOX:N:N:Y:Acceso Web,OPE_MAPMNU:N:BMPGETL:N:N:Y:Mapa de Menú,OPE_MAPTAB:N:BMPGETL:N:N:Y:Mapa de Tablas,OPE_LUNES:N:CHECKBOX:N:N:Y:Lunes
,OPE_LUNAIN:N:GET:N:N:Y:,OPE_LUNAFI:N:GET:N:N:Y:,OPE_LUNPIN:N:GET:N:N:Y:,OPE_LUNPFI:N:GET:N:N:Y:
,OPE_MARTES:N:CHECKBOX:N:N:Y:Martes,OPE_MARAIN:N:GET:N:N:Y:,OPE_MARAFI:N:GET:N:N:Y:,OPE_MARPIN:N:GET:N:N:Y:
,OPE_MARPFI:N:GET:N:N:Y:,OPE_MIERCO:N:CHECKBOX:N:N:Y:Miercoles,OPE_MIEAIN:N:GET:N:N:Y:,OPE_MIEAFI:N:GET:N:N:Y:
,OPE_MIEPIN:N:GET:N:N:Y:,OPE_MIEPFI:N:GET:N:N:Y:,OPE_JUEVES:N:CHECKBOX:N:N:Y:Jueves,OPE_JUEAIN:N:GET:N:N:Y:
,OPE_JUEAFI:N:GET:N:N:Y:,OPE_JUEPIN:N:GET:N:N:Y:,OPE_JUEPFI:N:GET:N:N:Y:,OPE_VIERNE:N:CHECKBOX:N:N:Y:Viernes
,OPE_VIEAIN:N:GET:N:N:Y:,OPE_VIEAFI:N:GET:N:N:Y:,OPE_VIEPIN:N:GET:N:N:Y:,OPE_VIEPFI:N:GET:N:N:Y:
,OPE_SABADO:N:CHECKBOX:N:N:Y:Sábado,OPE_SABAIN:N:GET:N:N:Y:,OPE_SABAFI:N:GET:N:N:Y:,OPE_SABPIN:N:GET:N:N:Y:
,OPE_SABPFI:N:GET:N:N:Y:,OPE_DOMING:N:CHECKBOX:N:N:Y:Domingo,OPE_DOMAIN:N:GET:N:N:Y:,OPE_DOMAFI:N:GET:N:N:Y:
,OPE_DOMPIN:N:GET:N:N:Y:,OPE_DOMPFI:N:GET:
*/
// EOF

