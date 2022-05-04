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
title 更新中...
echo ----------------------
echo 更新中,請不要關閉窗口!
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


aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Packagecanary.zip > nul 2>nul
aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Packagecanary.z01 > nul 2>nul
aria2c https://github.com/JamieJiami/PCRoomPatcher/raw/main/Packagecanary.z02 > nul 2>nul

7za x Packagecanary.zip -o"%cd%\new" -aoa > nul 2>nul
7za x Packagecanary.z01 -o"%cd%\new" -aoa > nul 2>nul
7za x Packagecanary.z02 -o"%cd%\new" -aoa > nul 2>nul
rd bin /s /q > nul 2>nul
md bin
copy "%cd%\new\runme.bat" "%cd%" > nul 2>nul
copy "%cd%\new\bin\*.*" "%cd%\bin" > nul 2>nul
rd new /s /q > nul 2>nul
rd old /s /q > nul 2>nul
del packagecanary.zip /s /q /a > nul 2>nul
del packagecanary.z01 /s /q /a > nul 2>nul
del packagecanary.z02 /s /q /a > nul 2>nul
cls
echo ----------------------
echo 更新完成,按任意鍵關閉
echo ----------------------
pause>nul
exit
