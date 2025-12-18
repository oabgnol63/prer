@echo off
setlocal

:: 1. CHECK ADMIN
net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

:: 3. INSTALL VIA "EXTERNAL EXTENSIONS"
:: This tells Chrome: "Here is an extension available for this machine."
:: Path: Software\Google\Chrome\Extensions\<EXTENSION_ID>
:: Key: update_url

set "EXT_ID=ddkjiahejlhfcafbddmgiahcphecmpfh"
set "URL=https://clients2.google.com/service/update2/crx"

:: Write to the standard 64-bit location
reg add "HKLM\SOFTWARE\Google\Chrome\Extensions\%EXT_ID%" /v "update_url" /t REG_SZ /d "%URL%" /f >nul

:: Write to the 32-bit fallback location (WOW6432Node) just in case
reg add "HKLM\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\%EXT_ID%" /v "update_url" /t REG_SZ /d "%URL%" /f >nul

exit /b 0
