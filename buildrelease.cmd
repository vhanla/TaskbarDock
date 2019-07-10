@echo off
setlocal enabledelayedexpansion
cls
rem call setrelease.cmd

call :SETRELEASE

set BINARY=TaskbarDock.exe
set RELEASE=Win32\Release
set TMP=Win32\Release\Dist
set PROJECT=TaskbarDock.dproj
set DIST=Dist
set USER=vhanla
set REPO=taskbardock


for /F %%i in (TOKEN.KEY) do set "TOKEN=%%i"
for /F %%i in (TAG) do set "TAG=%%i"
set ZIPFILE=TaskbarDock%TAG%.zip

:OPTIONS
set options=1 2 3 4
echo.
echo BuildRelease: %BINARY% %TAG%
echo Choose the tasks to do:
echo.
echo 1. Build ^& Pack Release
echo 2. Create Release Tag
echo 3. Edit Release Tag
echo 4. Upload Release Binary
echo 5. Delete Release
echo 6. Exit
echo.
echo Enter valid options [ %options% ]:
set /P res=">
if "%res%"=="1" goto buildrelease
if "%res%"=="2" goto newrelease
if "%res%"=="3" goto editrelease
if "%res%"=="4" goto upload
if "%res%"=="5" goto delete

goto END

:SETRELEASE
for /f "tokens=1,2 delims='" %%i in (VERSION.inc) do set "VERSION=%%j" 
set N=
for /f %%i in ('git rev-list HEAD ^| find /c /v ""') do set "N=!N!%%i"
set /a "N=%N%+1"
rem for /F "tokens=1,2,3 delims=/" %%a in ('date /t') do set "D=!D!.r%%c%%b%%a"
rem for /f "tokens=1,2" %%k in ('echo !D!') do set "E=!E!%%k%%l"
for /f %%v in ('git log -1 --format^="%%cd" --date="iso-local"') do set "G=!G!%%v"
for /F "tokens=1,2,3 delims=-" %%a in ('echo !G!') do set "D=!D!-r%%a%%b%%c"
echo CONST RELEASENUMBER='!N!!D!'; > RELEASENUMBER.inc
echo v!VERSION!!N!!D! > TAG
rem goto OPTIONS
goto :eof

:buildrelease
SET MSBUILD="C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
SET RSVARS="C:\Program Files (x86)\Embarcadero\Studio\20.0\bin\rsvars.bat"

call %RSVARS%

for /F %%i in (TAG) do set "TAG=%%i"

%MSBUILD% %PROJECT% "/t:Clean,Make" "/p:config=Release" "/verbosity:minimal"

rem if %ERRORLEVEL% EQU 0 GOTO END

echo "Built Successfully"

rmdir /q /s %TMP% && mkdir %TMP% && copy %RELEASE%\TaskbarDock.exe %TMP%\TaskbarDock.exe && copy TAG %TMP%\RELEASEVERSION.txt
del %DIST%\TaskbarDock%TAG%.zip
powershell.exe -nologo -noprofile -command "& {Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%TMP%','%DIST%\TaskbarDock%TAG%.zip'); }"
echo "Generated distributable zip file"
echo =================================================
goto OPTIONS

:newrelease
echo.
echo BuildRelease: %BINARY% %TAG% %USER% %REPO% %TOKEN%
echo Details:
echo.
echo Release Title:
set /P NRNAME=">
echo Release Description:
set /P NRDESC=">
set /P res=Set as Pre-Release [y/n]?
if "%res%"=="n" (
github-release release -u %USER% -r %REPO% -t %TAG% -n "%NRNAME%" -d "%NRDESC%" -s %TOKEN%
) else (
github-release release -u %USER% -r %REPO% -t %TAG% -n "%NRNAME%" -d "%NRDESC%" --pre-release -s %TOKEN%
)

:upload
echo.
set /P res=Upload File: %ZIPFILE% to releases [y/n]?

if "%res%"=="y" (
github-release upload -u %USER% -r %REPO% -t %TAG% -n "%ZIPFILE%" -f "%DIST%\%ZIPFILE%" -s %TOKEN% 
echo Uploaded to GitHub
)
echo =================================================
goto OPTIONS

:editrelease
echo.
echo BuildRelease: %BINARY% %TAG% %USER% %REPO% %TOKEN%
echo Details:
echo.
echo Release Title:
set /P NRNAME=">
echo Release Description:
set /P NRDESC=">
set /P res=Set as Pre-Release [y/n]?
if "%res%"=="n" (
github-release edit -u %USER% -r %REPO% -t %TAG% -n "%NRNAME%" -d "%NRDESC%" -s %TOKEN%
) else (
github-release edit -u %USER% -r %REPO% -t %TAG% -n "%NRNAME%" -d "%NRDESC%" --pre-release -s %TOKEN%
)
echo =================================================
goto OPTIONS

:delete
echo.
echo BuildRelease: %BINARY% %TAG% %USER% %REPO% %TOKEN%
echo WARNING, this procedure is irreversible!
echo.
set /P res=PROCEED TO DELETE [y/n]?
if "%res%"=="y" (
github-release delete -u %USER% -r %REPO% -t %TAG% -s %TOKEN%
echo RELEASE HAS BEEN DELETED!
) 
echo =================================================
goto OPTIONS

:END
echo.
echo All operation have been done
rem pause
rem exit 0
