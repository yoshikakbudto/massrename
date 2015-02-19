::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Purpose:        Rename a bunch of files based on pattern rules 
:: Version:        0.1
:: Authors:        ed
:: History:        25/07/2012 - First release.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@SetLocal EnableExtensions EnableDelayedExpansion
@Call :_InitEnv

%_Set% SRCDIR           "C:\dnla\radio\Nostalgie - Best of 60s\"        chk
%_Set% PattConf         MassRenameRules.Conf    chk
Set FILEMASK=*.mp3

For %%j In (%SRCDIR%\%FILEMASK%) Do Call :Frename "%%j"



Exit






:: Renames a file based on pattern
::
:: %1 - filename
::
:Frename
 Set FNAME=%1
 For /F "eol=# delims=; tokens=1*" %%a In (%PattConf%) Do (
   Set FNAME=!FNAME:%%a=%%b! 
 )
 Set RES=!FNAME:%%a=%%b!
 If Not Exist !RES! move %1 !RES!
GoTo :Eof


 *_InitEnv                                                            _InitEnv
 * Initialize environment
 *
 */
:_InitEnv
  @Echo Off & Echo. 
  Cls
  Set _Set=Call :_Set 
  Set _Echo=Call :_Echo
  Set _RUNPATH=%~dp0
  Cd "%_RUNPATH%"
Goto :eof



/* _Set                                                                   _Set
 * Sets the variables with file remove or existance check features
 *
 * %1 - VarName
 * %2 - Value. Put it into quotes in case of spaces
 * %3 - [chk|rm] Check file existance or delete one, if exist
 *              By default, no check and dont delete
 */
:_Set
  Set %1=%2
  If /i %3.==chk. If Not Exist %2 Echo Error^^!: file %2 does not exist. Please check the %1 variable & Pause & Exit
  If /i %3.==rm. Del /f %2 >nul 2>nul
Goto :eof
