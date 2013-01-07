echo off
java -jar "%MYBIN%\smali.jar" -o "%1-bin\classes.dex" "%1"  || (echo jarclose unable to smali %1.jar & exit /b 1)
7z a -mx9 -tzip "%1-patched.jar" ".\%1-bin\*" > NUL  || (echo jarclose unable to create %1.jar & exit /b 1)
exit /b 0
