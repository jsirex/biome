@echo off
"%~dp0powershell/pwsh.exe" -NoProfile -ExecutionPolicy bypass -NoLogo -Command ". '%~dp0bio-studio.ps1'" %*
