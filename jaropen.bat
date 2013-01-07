echo off
7z x -y -o"%1-bin" "%1.jar" > NUL || (echo jaropen unable to extract %1.jar & exit /b 1)
java -jar "%MYBIN%\baksmali.jar" -o "%1" "%1.jar" || (echo jaropen unable to baksmali %1.jar & exit /b 1)
exit /b 0
