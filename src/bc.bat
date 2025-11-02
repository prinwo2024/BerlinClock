:: ==============================================================================
:: 2025: sample script for Greyhound.
:: Read current time from system and convert it to berlin clock's representation.
:: Output on screen and in textfile.
:: First line of file output is the represented time in common readable form.
:: Following lines represent the states of the lamps of the berlin clock.
:: Characters used are:
::     0 ... not set (lamp is not lit)
::     1 ... yellow
::     2 ... red
:: The script runs indefinitely until [Ctrl]-[C] is pressed.
:: ==============================================================================
@echo off

setlocal
set "outputFilename=berlinclock.dat"

:loop
set "currentTime=%TIME%"
set "timeFormat=%currentTime:~0,8%"

:: Standardize time format
if "%timeFormat:~6,2%" == "AM" (
    set "timeHours=%currentTime:~0,2%"
    set "timeMinutes=%currentTime:~3,2%"
    set "timeSeconds=%currentTime:~6,2%"
) else if "%timeFormat:~6,2%" == "PM" (
    set "timeHours=%currentTime:~0,2%"
    set "timeMinutes=%currentTime:~3,2%"
    set "timeSeconds=%currentTime:~6,2%"
    if "%timeHours%" == "12" (
        set /a timeHours=0
    ) else (
        set /a timeHours+=12
    )
) else (
    :: Assume 24-hour format
    set "timeHours=%currentTime:~0,2%"
    set "timeMinutes=%currentTime:~3,2%"
    set "timeSeconds=%currentTime:~6,2%"
)

:: Format with leading zeros
set "timeHours=%timeHours:~0,2%"
set "timeMinutes=%timeMinutes:~0,2%"
set "timeSeconds=%timeSeconds:~0,2%"

:: Calculate result and remainder of timeHours divided by 5
set /a resultHoursDiv5=result=timeHours / 5
set /a remainderHoursDiv5=remainder=timeHours %% 5

:: Alternate representation of result of timeHours divided by 5
if %resultHoursDiv5% == 0 (set "berlinHoursResult=0000") else ^
if %resultHoursDiv5% == 1 (set "berlinHoursResult=2000") else ^
if %resultHoursDiv5% == 2 (set "berlinHoursResult=2200") else ^
if %resultHoursDiv5% == 3 (set "berlinHoursResult=2220") else ^
if %resultHoursDiv5% == 4 (set "berlinHoursResult=2222")

:: Alternate representation of remainder of timeHours divided by 5
if %remainderHoursDiv5% == 0 (set "berlinHoursRemainder=0000") else ^
if %remainderHoursDiv5% == 2 (set "berlinHoursRemainder=2000") else ^
if %remainderHoursDiv5% == 2 (set "berlinHoursRemainder=2200") else ^
if %remainderHoursDiv5% == 3 (set "berlinHoursRemainder=2220") else ^
if %remainderHoursDiv5% == 4 (set "berlinHoursRemainder=2222")

:: Calculate result and remainder of timeMinutes divided by 5
set /a resultMinutesDiv5=result=timeMinutes / 5
set /a remainderMinutesDiv5=remainder=timeMinutes %% 5

:: Alternate representation of result of timeMinutes divided by 5
if %resultMinutesDiv5% ==  0 (set "berlinMinutesResult=00000000000") else ^
if %resultMinutesDiv5% ==  1 (set "berlinMinutesResult=10000000000") else ^
if %resultMinutesDiv5% ==  2 (set "berlinMinutesResult=11000000000") else ^
if %resultMinutesDiv5% ==  3 (set "berlinMinutesResult=11200000000") else ^
if %resultMinutesDiv5% ==  4 (set "berlinMinutesResult=11210000000") else ^
if %resultMinutesDiv5% ==  5 (set "berlinMinutesResult=11211000000") else ^
if %resultMinutesDiv5% ==  6 (set "berlinMinutesResult=11211200000") else ^
if %resultMinutesDiv5% ==  7 (set "berlinMinutesResult=11211210000") else ^
if %resultMinutesDiv5% ==  8 (set "berlinMinutesResult=11211211000") else ^
if %resultMinutesDiv5% ==  9 (set "berlinMinutesResult=11211211200") else ^
if %resultMinutesDiv5% == 10 (set "berlinMinutesResult=11211211210") else ^
if %resultMinutesDiv5% == 11 (set "berlinMinutesResult=11211211211")

:: Alternate representation of remainder of timeMinutes divided by 5
if %remainderMinutesDiv5% == 0 (set "berlinMinutesRemainder=0000") else ^
if %remainderMinutesDiv5% == 1 (set "berlinMinutesRemainder=1000") else ^
if %remainderMinutesDiv5% == 2 (set "berlinMinutesRemainder=1100") else ^
if %remainderMinutesDiv5% == 3 (set "berlinMinutesRemainder=1110") else ^
if %remainderMinutesDiv5% == 4 (set "berlinMinutesRemainder=1111")

:: Determine if timeSeconds are odd or even
set /a berlinSecondsStatus=remainder=timeSeconds %% 2

:: Echo to screen
cls
echo timeHours  : %timeHours%
echo timeMinutes: %timeMinutes%
echo timeSeconds: %timeSeconds%
echo.
echo timeHours divided by 5               : %resultHoursDiv5%
echo Remainder of timeHours divided by 5  : %remainderHoursDiv5%
echo.
echo timeMinutes divided by 5             : %resultMinutesDiv5%
echo Remainder of timeMinutes divided by 5: %remainderMinutesDiv5%
echo.
echo ===== Berlin Clock Layout: =====
echo %berlinSecondsStatus%
echo %berlinHoursResult%
echo %berlinHoursRemainder%
echo %berlinMinutesResult%
echo %berlinMinutesRemainder%
echo.


:: Clear and write current time to file
> "%outputFilename%" echo %timeHours%:%timeMinutes%:%timeSeconds%
:: Write berlin representation to file
>> "%outputFilename%" echo %berlinSecondsStatus%
>> "%outputFilename%" echo %berlinHoursResult%
>> "%outputFilename%" echo %berlinHoursRemainder%
>> "%outputFilename%" echo %berlinMinutesResult%
>> "%outputFilename%" echo %berlinMinutesRemainder%

timeout /t 1 >nul
goto loop

endlocal
