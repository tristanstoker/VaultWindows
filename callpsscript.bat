@ECHO OFF
SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%MyPowerShellScript.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\vaultagent\script2.ps1'";