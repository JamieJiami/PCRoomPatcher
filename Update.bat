@echo off
title Updating...
echo ------------
echo Updating
echo ------------
echo.
rd old /s /q
md old
md "%cd%\old\bin"
copy "%cd%\*.*" "%cd%\old"
copy "%cd%\bin\*.*" "%cd%\old\bin"