@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
title ��s��...
echo ----------------------
echo ��s��,�Ф��n�������f!
echo ----------------------
echo.
echo.
echo.
rd new /s /q > nul 2>nul
rd old /s /q > nul 2>nul
md old
md "%cd%\old\bin"
md new
copy "%cd%\runme.bat" "%cd%\old" > nul 2>nul
copy "%cd%\bin\*.*" "%cd%\old\bin" > nul 2>nul


aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Package.zip > nul 2>nul
aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Package.z01 > nul 2>nul
aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Package.z02 > nul 2>nul

7za x Package.zip -o"%cd%\new" -aoa > nul 2>nul
7za x Package.z01 -o"%cd%\new" -aoa > nul 2>nul
7za x Package.z02 -o"%cd%\new" -aoa > nul 2>nul
rd bin /s /q > nul 2>nul
md bin
copy "%cd%\new\runme.bat" "%cd%" > nul 2>nul
copy "%cd%\new\bin\*.*" "%cd%\bin" > nul 2>nul
rd new /s /q > nul 2>nul
rd old /s /q > nul 2>nul
del package.zip /s /q /a > nul 2>nul
del package.z01 /s /q /a > nul 2>nul
del package.z02 /s /q /a > nul 2>nul
cls
echo ----------------------
echo ��s����,�����N������
echo ----------------------
pause>nul
exit
