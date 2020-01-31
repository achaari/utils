@echo off

setlocal enableextensions enabledelayedexpansion

set _t=%time%
set _t=%_t::0=: %
set _t=%_t:,0=, %
set _t=%_t:.0=. %
set _t=%_t:~0,2% * 360000 + %_t:~3,2% * 6000 + %_t:~6,2% * 100 + %_t:~9,2%
set /a _t=%_t%

:: if we call the function without parameters is defined initial time
set _r=%~1
if not defined _r (
	endlocal & set timer_start_time=%_t% & goto :eof
)

set /a _t=%_t% - %timer_start_time%
set /a "_t=%_t% / 100"

endlocal & set %~1=%_t%
