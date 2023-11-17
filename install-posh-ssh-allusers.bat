@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
setlocal enabledelayedexpansion
if exist "%PROGRAMFILES%\WindowsPowerShell\Modules\Posh-SSH" (
    rmdir /S /Q "%PROGRAMFILES%\WindowsPowerShell\Modules\Posh-SSH\"
)
for /f "tokens=7 delims=/" %%i in ('curl -s -I "https://github.com/craeckor/Posh-SSH/releases/latest" 2^>^&1 ^| findstr "Location:"') do (
    set posh_tag=%%i
)
mkdir "%PROGRAMFILES%\WindowsPowerShell\Modules\Posh-SSH"
mkdir "%PROGRAMFILES%\WindowsPowerShell\Modules\Posh-SSH\%posh_tag%"
curl -o "%Temp%\posh.zip" "https://github.com/craeckor/Posh-SSH/releases/download/%posh_tag%/Posh-SSH.zip" -L -s
Powershell Expand-Archive -Path "$ENV:TEMP\posh.zip" -DestinationPath "$ENV:PROGRAMFILES\WindowsPowerShell\Modules\Posh-SSH\%posh_tag%"
del /F /S /Q "%Temp%\posh.zip"
endlocal