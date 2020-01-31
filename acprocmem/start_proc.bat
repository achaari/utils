::@echo off
SetLocal EnableExtensions EnableDelayedExpansion

call :actimer

:: Reaclc performance
(
	Start %*
	call acprocessmem %~n1 5 usedmem mem_%~n1
)
call :actimer optext usedmem

exit /b

:actimer 
if "%~1"=="" (
	call  actimestamp
) ELSE (
	call actimestamp timestimp	
	call echo %%%~1%% done in !timestimp! s ^(max memory %%%~2%% MO ^)
)

exit /b
