@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Set PowerShell Execution Policy to allow script execution
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force"

:: Run PowerShell Scripts
PowerShell -File "DisableUpdates.ps1"
PowerShell -File "HiddenfilesNExtensions.ps1"
PowerShell -File "FirewallNALSR.ps1"

:: Run Batch file to enable Group Policy Editor
call Enable_GPEDIT.bat

:: Apply Registry Edits for disabling Windows Defender
reg import DisableDefender.reg

:: Revert PowerShell Execution Policy to a safer level
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Restricted -Force"

echo All scripts executed successfully. Group Policy Editor has been enabled before script execution.
ENDLOCAL
