// Programa   : MYSQLDATAZIP
// Fecha/Hora : 03/08/2025 15:08:55
// Propósito  : Carpeta DATA MySQL para comprimir 
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN()
  LOCAL cRunBat:="mysqlstop.bat",i
  LOCAL cDir    :=CURDRIVE()+":\dpsgev60\mysql\MySQL Server 5.5\data\"
  LOCAL cFileOrg:=cDir+"respaldoini.zip"
  LOCAL aDir    :=DIRECTORY(cDir+"\*.*","D"),aFiles,cFileZip,cPass:=NIL

  // cierra todos los timer
  AEVAL(oDp:aTimers,{|a,n| DPKILLTIMER(a[1])})

  DEFAULT oDp:aMySqlBd:={},;
            oDp:aMySql  :={}

  AEVAL(oDp:aMySqlBd,{|a,n| a[3]:Close()})
  AEVAL(oDp:aMySql  ,{|a,n| a[2]:Close()})

//  CursorWait()
//  WaitRun(cRunBat,0)
//  SysRefresh(.T.)

  oDp:aMySqlBd:={}
  oDp:aMySql  :={}

  ADEPURA(aDir,{|a,n| ("."$a[1])})

  FOR I=1 TO LEN(aDir)

      aFiles  :=DIRECTORY(cDir+aDir[I,1]+"\*.*")
      cFileZip:=cDir+"mysql_"+aDir[I,1]+".zip"

      cFileZip:=CURDRIVE()+":\"+CURDIR()+"\respaldo\mysql_"+aDir[I,1]+".zip"

// ? cFileZip,"cFileZip"

      AEVAL(aFiles,{|a,n| aFiles[n]:=cDir+aDir[I,1]+"\"+a[1] })

      MsgRun("Comprimiento "+cFileZip,LSTR(I)+"/"+LSTR(LEN(aDir)),;
            {|| HB_ZipFile( cFileZip, aFiles, 9,,.T., cPass, .F., .F. ) })

//      IF I>10 .AND. ISPCPRG()
//        EXIT
//      ENDIF
     
  NEXT I

  aFiles  :=DIRECTORY(cDir+aDir[I,1]+"\*.*")
  cFileZip:=cDir+"mysql_ibdata.zip"

  AEVAL(aFiles,{|a,n| aFiles[n]:=cDir+aDir[I,1]+"\"+a[1] })

  MsgRun("Comprimiento "+cFileZip,cDir,;
        {|| HB_ZipFile( cFileZip, aFiles, 9,,.T., cPass, .F., .F. ) })

 
// FERASE(cFileOrg)
// ViewArray(aFiles)
// RETURN
/*
  oDp:oMySqlCon:Close()
  oDp:oMySqlCon:Destroy() 
  oDp:oMySqlCon:=NIL
*/

/*
  CursorWait()
  WaitRun(cRunBat,0)
  SysRefresh(.T.)
*/
// ? "debe esperar que cierre el servicio" 
//  MySqlConect()

  EJECUTAR("DPFIN",.T.)
  
RETURN .T.
// EOF

