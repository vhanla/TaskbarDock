@echo off
setlocal enabledelayedexpansion
set N=
for /f %%i in ('git rev-list HEAD ^| find /c /v ""') do set "N=!N!%%i"
rem for /F "tokens=1,2,3 delims=/" %%a in ('date /t') do set "D=!D!.r%%c%%b%%a"
rem for /f "tokens=1,2" %%k in ('echo !D!') do set "E=!E!%%k%%l"
for /f %%v in ('git log -1 --format^="%%cd" --date="iso-local"') do set "G=!G!%%v"
for /F "tokens=1,2,3 delims=-" %%a in ('echo !G!') do set "D=!D!-r%%a%%b%%c"
echo CONST RELEASENUMBER='!N!!D!'; > RELEASENUMBER.inc
echo !N!!D! 

