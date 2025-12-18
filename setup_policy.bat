@echo off
setlocal

:: 1. Check for Admin rights (Exit silently if not Admin)
net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

:: 2. Cleanup old keys silently
reg delete "HKLM\SOFTWARE\Google\Chrome\ExtensionInstallForcelist" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul 2>&1

:: 3. Create Policy Key
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul

:: 4. Add uBlock Origin Lite (Silent)
:: ID: ddkjiahejlhfcafbddmgiahcphecmpfh
:: URL: https://clients2.google.com/service/update2/crx
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx" /f >nul

:: 5. Exit immediately
exit /b 0
