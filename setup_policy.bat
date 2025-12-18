@echo off
setlocal

:: 1. DEFINE VARIABLES
set "EXT_ID=ddkjiahejlhfcafbddmgiahcphecmpfh"
set "URL=https://clients2.google.com/service/update2/crx"

:: 2. INSTALL TO CURRENT USER (HKCU)
:: This works even without Admin rights.
:: Chrome checks this location for the specific user running the browser.

:: Create the key path
reg add "HKCU\Software\Google\Chrome\Extensions\%EXT_ID%" /f >nul

:: Add the update_url
reg add "HKCU\Software\Google\Chrome\Extensions\%EXT_ID%" /v "update_url" /t REG_SZ /d "%URL%" /f >nul

:: 3. VERIFY (Optional: Print success for logs)
echo [INFO] Extension configured for Current User (HKCU).

exit /b 0
