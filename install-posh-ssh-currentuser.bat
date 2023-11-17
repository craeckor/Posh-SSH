@echo off
setlocal enabledelayedexpansion
if not exist "%USERPROFILE%\Documents\WindowsPowerShell" (
    mkdir "%USERPROFILE%\Documents\WindowsPowerShell"
    mkdir "%USERPROFILE%\Documents\WindowsPowerShell\Modules"
)
if not exist "%USERPROFILE%\Documents\WindowsPowerShell\Modules" (
    mkdir "%USERPROFILE%\Documents\WindowsPowerShell\Modules"
)

if exist "%USERPROFILE%\Documents\WindowsPowerShell\Modules\Posh-SSH" (
    rmdir /S /Q "%USERPROFILE%\Documents\WindowsPowerShell\Modules\Posh-SSH"
)
for /f "tokens=7 delims=/" %%i in ('curl -s -I "https://github.com/craeckor/Posh-SSH/releases/latest" 2^>^&1 ^| findstr "Location:"') do (
    set posh_tag=%%i
)
mkdir "%USERPROFILE%\Documents\WindowsPowerShell\Modules\Posh-SSH"
mkdir "%USERPROFILE%\Documents\WindowsPowerShell\Modules\Cobalt\%posh_tag%"
curl -o "%Temp%\posh.zip" "https://github.com/craeckor/Posh-SSH/releases/download/%cobalt_tag%/Posh-SSH.zip" -L -s
Powershell Expand-Archive -Path "$ENV:TEMP\posh.zip" -DestinationPath "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\Posh-SSH\%posh_tag%"
del /F /S /Q "%Temp%\posh.zip"
endlocal