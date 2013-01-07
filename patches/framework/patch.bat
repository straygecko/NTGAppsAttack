echo off
setlocal
set MYDIR=%~dp0
set MYDIR=%MYDIR:~0,-1%
copy framework\android\telephony\TelephonyManager.smali TelephonyManager.smali.orig
IF ERRORLEVEL 1 echo Unable to copy TelephonyManager.smali & exit /b 1
awk -f "%MYDIR:\=/%/patch.awk" -v pdir="%MYDIR:\=/%" TelephonyManager.smali.orig > framework\android\telephony\TelephonyManager.smali
IF ERRORLEVEL 1 echo Unable to patch TelephonyManager.smali & exit /b 1
exit /b 0
