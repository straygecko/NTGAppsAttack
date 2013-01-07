echo off

echo Building patched files for firmware 1.2.0 or 1.2.1 ...

rem services.jar  - 1.2.0 & 1.2.1 firmware are identical
rem framework.jar - 1.2.0 & 1.2.1 firmware differ only in the addition of the
rem                 SERIAL property to android/os/build.smali - won't break 1.2.0

rem get the firmware
wget -nv -nc -O "%MYZIPS%\nook_1_2_1_update.zip" "http://su.barnesandnoble.com/nook/nook2/1.2.1/US/QEM5Ljgt6sxsoUhs1ypATSufC9bS7WCNbMJmvnTq/nook_1_2_update.zip"
IF ERRORLEVEL 2 echo Unable retrieve 1.2.1 firmware & exit /b 1

mkdir "%MYWORK%\1.2" || (echo Unable to create working directory & exit /b 1)

mkdir "%MYOUT%\1.2" || (echo Unable to create output directory & exit /b 1)
mkdir "%MYOUT%\1.2\system" || (echo Unable to create output directory & exit /b 1)
mkdir "%MYOUT%\1.2\system\framework" || (echo Unable to create output directory & exit /b 1)

rem patch the 1.2 framework.jar
mkdir "%MYWORK%\1.2\framework" || (echo Unable to create framework directory & exit /b 1)
pushd "%MYWORK%\1.2\framework"
7z e -y "%MYZIPS%\nook_1_2_1_update.zip" system/framework/framework.jar > NUL
IF ERRORLEVEL 1 echo Unable extract framework.jar & exit /b 1
call "%MYDIR%\jaropen.bat" framework || (echo framework jaropen failed & exit /b 1)
call "%MYPATCHES%\framework\patch.bat" || (echo framework patch failed & exit /b 1)
call "%MYDIR%\jarclose.bat" framework || (echo framework jarclose failed & exit /b 1)
copy framework-patched.jar "%MYOUT%\1.2\system\framework\framework.jar"
IF ERRORLEVEL 1 echo Unable to copy patched framework.jar to output & exit /b 1
popd

rem patch the 1.2 services.jar
mkdir "%MYWORK%\1.2\services" || (echo Unable to create services directory & exit /b 1)
pushd "%MYWORK%\1.2\services"
7z e -y "%MYZIPS%\NookManager.img" files/system/framework/services.jar > NUL
IF ERRORLEVEL 1 echo Unable extract services.jar & exit /b 1
call "%MYDIR%\jaropen.bat" services || (echo services jaropen failed & exit /b 1)
call "%MYPATCHES%\services\patch.bat" || (echo services patch failed & exit /b 1)
call "%MYDIR%\jarclose.bat" services || (echo services jarclose failed & exit /b 1)
copy services-patched.jar "%MYOUT%\1.2\system\framework\services.jar"
IF ERRORLEVEL 1 echo Unable to copy patched services.jar to output & exit /b 1
popd

exit /b 0
