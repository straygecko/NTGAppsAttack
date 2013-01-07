echo off
if "%JAVA_HOME%" == "" (
  rem JAVA_HOME not set, lets try to find Java
  FOR /F "skip=2 tokens=2*" %%A IN ('REG QUERY "HKLM\Software\JavaSoft\Java Runtime Environment" /v CurrentVersion') DO set CurVer=%%B

  FOR /F "skip=2 tokens=2*" %%A IN ('REG QUERY "HKLM\Software\JavaSoft\Java Runtime Environment\%CurVer%" /v JavaHome') DO set JAVA_HOME=%%B
)

if "%JAVA_HOME%" == "" (
  echo Java not installed, unable to build NTGAppsAttack
  pause
  exit 1
)

set PATH=%PATH%;%~dp0\bin;%JAVA_HOME%\bin

set MYDIR=%~dp0
set MYDIR=%MYDIR:~0,-1%
set MYBIN=%MYDIR%\bin
set MYCUSTOM=%MYDIR%\custom
set MYPATCHES=%MYDIR%\patches
set MYWORK=%MYDIR%\patchwork
set MYZIPS=%MYDIR%\zips
set MYOUT=%MYCUSTOM%\files\NTGAppsAttack

set /p BUILDVER=<"%MYDIR%\VERSION"

IF NOT EXIST "%MYZIPS%" mkdir "%MYZIPS%"

echo Retrieving needed tools ...

rem get some tools we'll need
wget -nv -nc -O "%MYBIN%\baksmali.jar" "http://smali.googlecode.com/files/baksmali-1.4.1.jar"
IF ERRORLEVEL 2 call :error "Unable to retrieve baksmali"
wget -nv -nc -O "%MYBIN%\smali.jar" "http://smali.googlecode.com/files/smali-1.4.1.jar"
IF ERRORLEVEL 2 call :error "Unable to retrieve smali"
if not exist "%MYBIN%\awk.exe" (
  wget -nv -nc -O "%MYZIPS%\gawk.zip" "http://sourceforge.net/projects/gnuwin32/files/gawk/3.1.6-1/gawk-3.1.6-1-bin.zip/download"
  IF ERRORLEVEL 2 call :error "Unable to retrieve gawk"
  7z e -y -o"%MYBIN%" "%MYZIPS%\gawk.zip" "bin/awk.exe" > NUL
  IF ERRORLEVEL 1 call :error "Unable to extract awk.exe"
)

echo Retrieving NookManager ...

rem get NookManager image
if not exist "%MYZIPS%\NookManager.img" (
  wget -nv -nc -P "%MYZIPS%" "http://download.doozan.com/nook/NookManager-0.5.0.zip"
  IF ERRORLEVEL 2 call :error "Unable to download NookManager"
  7z e -y -o"%MYZIPS%" "%MYZIPS%\NookManager-0.5.0.zip" NookManager.img > NUL
  IF ERRORLEVEL 1 call :error "Unable to extract NookManager.img"
)
popd

echo Preparing directories ...

rem clear the working directory
rmdir /s /q "%MYWORK%"
mkdir "%MYWORK%"
IF ERRORLEVEL 1 call :error "Unable to create working directory"

rem prepare the output directory
rmdir /s /q "%MYOUT%"
mkdir "%MYOUT%"

rem build the common gapps files
call "%MYDIR%\build-gapps.bat" || call :error "build-gapps failed"

rem build firmware specific files
for %%f in ("%MYDIR%\build-fw-*.bat") do (
  call "%%f"  || call :error "%%f failed"
)


echo Building the distribution package ...

copy "%MYDIR%\CREDITS" "%MYCUSTOM%\NTGAppsAttack.CREDITS"
copy "%MYDIR%\VERSION" "%MYCUSTOM%\menu\NTGAppsAttack.VERSION"

rem zip up the distribution package
del /q "%MYDIR%\NTGAppsAttack-%BUILDVER%.zip"
7z a -mx9 -tzip "%MYDIR%\NTGAppsAttack-%BUILDVER%.zip" "%MYDIR%\custom" > NUL
IF ERRORLEVEL 1 call :error "Unable to create NTGAppsAttack-%BUILDVER%.zip"

echo Build completed successfully
pause

exit 0

:error
echo %1
echo Build terminated
pause
exit 1
