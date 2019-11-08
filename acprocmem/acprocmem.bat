
@echo off

set /a "%~3=0"

SetLocal EnableExtensions EnableDelayedExpansion

set /a maxmem=0
set /a curmem=0
set /a counti=0
set prognam=%~1

if not "%~4"=="" (
	echo index ^(%~2 s^);curent mem;max mem > %~4.csv
)

:: enough time to start the process
timeout /t %~2 >nul 2>&1

:procssnext

set next=0

set /a curmem=0
set /a counti=%counti% + 1

for /f %%a in ('wmic process where "name='%prognam%.exe'" get WorkingSetSize ^| findstr /r "^[1-9][0-9]*"') do (
	set exemem=%%a
	set /a curmem = !curmem! + !exemem:~0,-6!
	::echo %%a - !curmem!
	set next=1
)

:: Check if process still running
if "%next%"=="0" (
	goto :endproc
)	

:: Set max used memory 
if %curmem% GTR %maxmem% (
	set /a maxmem=%curmem%
)

::echo max memory %maxmem% MO
if not "%~4"=="" (
	echo %counti%;%curmem%;%maxmem% >> %~4.csv
)

:: Sleep few second and recheck memory 
timeout /t %~2 >nul 2>&1
goto procssnext

:endproc
Endlocal & set /a %~3=%maxmem% 

