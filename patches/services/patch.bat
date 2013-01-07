echo off
setlocal
set MYDIR=%~dp0
set MYDIR=%MYDIR:~0,-1%
copy services\com\android\server\ServerThread.smali ServerThread.smali.orig
IF ERRORLEVEL 1 echo Unable to copy ServerThread.smali & exit /b 1
awk -f "%MYDIR:\=/%/patch.awk" -v pdir="%MYDIR:\=/%" ServerThread.smali.orig > services\com\android\server\ServerThread.smali
IF ERRORLEVEL 1 echo Unable to patch ServerThread.smali & exit /b 1
exit /b 0
