echo off

echo Building gapps...

rem get firmware files, etc. needed
pushd "%MYZIPS%"
wget -nv -nc "http://goo.im/gapps/gapps-ds-ERE36B-signed.zip"
IF ERRORLEVEL 2 (echo Unable retrieve ERE36B & exit /b 1)
wget -nv -nc "http://goo.im/gapps/gapps-passion-EPF30-signed.zip"
IF ERRORLEVEL 2 echo Unable retrieve ERF30 & exit /b 1
wget -nv -nc "http://cyanogen-updater.googlecode.com/files/update-cm-5.0.8-N1-signed.zip"
IF ERRORLEVEL 2 echo Unable retrieve cm-5.0.8 & exit /b 1
popd

mkdir "%MYOUT%\gapps" || (echo unable to create gapps directory & exit /b 1)

rem extract the google apps
7z x -y -o"%MYOUT%\gapps" "%MYZIPS%\gapps-ds-ERE36B-signed.zip" @"%MYDIR%\gapps.files" > NUL
IF ERRORLEVEL 2 echo Unable to extract ERE36B files & exit /b 1
7z x -y -o"%MYOUT%\gapps" "%MYZIPS%\gapps-passion-EPF30-signed.zip" @"%MYDIR%\gapps-MarketUpdater.files" > NUL
IF ERRORLEVEL 2 echo Unable to extract EPF30 files & exit /b 1
7z x -y -o"%MYOUT%\gapps" "%MYZIPS%\update-cm-5.0.8-N1-signed.zip" @"%MYDIR%\gapps-extras.files" > NUL
IF ERRORLEVEL 2 echo Unable to extract cm-5.0.8 files & exit /b 1

exit /b 0
