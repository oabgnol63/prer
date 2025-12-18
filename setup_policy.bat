@echo off
setlocal

:: 1. CHECK ADMIN RIGHTS
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please right-click and run as Administrator.
    pause
    exit
)

echo [INFO] Cleaning up old/incorrect keys...
:: Remove old attempts to prevent conflicts
reg delete "HKLM\SOFTWARE\Google\Chrome\ExtensionInstallForcelist" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul 2>&1

echo [INFO] Creating Policy Key...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul

echo [INFO] Installing uBlock Origin Lite...
:: EXTENSION ID: ddkjiahejlhfcafbddmgiahcphecmpfh (uBlock Origin Lite)
:: UPDATE URL:   https://clients2.google.com/service/update2/crx (STANDARD WEB STORE URL)

reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx" /f

echo [INFO] Applying Policy...
gpupdate /force

echo.
echo [SUCCESS] uBlock Origin Lite configured.
echo Please restart Chrome and check chrome://extensions.
pause
