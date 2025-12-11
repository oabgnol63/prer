@echo off
setlocal enabledelayedexpansion

:: --- CONFIGURATION ---
set "BASE_DIR=C:\Users\sauce"
set "ZIP_PATH=%BASE_DIR%\extension.zip"
set "DEST_PATH=%BASE_DIR%\my_extension"
set "FLAG_FILE=%BASE_DIR%\i_was_here.txt"
set "URL=https://raw.githubusercontent.com/oabgnol63/prer/refs/heads/main/test.zip"

echo --- STARTING EXTENSION SETUP (BAT) ---

:: 1. Create Directory (If it doesn't exist)
if not exist "%BASE_DIR%" (
    echo Creating directory %BASE_DIR%...
    mkdir "%BASE_DIR%"
)

:: 2. Create Flag File (Proof of execution)
echo I was here > "%FLAG_FILE%"

:: 3. Download File
:: We use a PowerShell one-liner here because it handles TLS 1.2 correctly and is reliable on Sauce Labs.
echo Downloading zip...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP_PATH%'"

if %errorlevel% neq 0 (
    echo FAILURE: Download command failed.
    exit /b 1
)

:: 4. Unzip
echo Unzipping...
:: Clean up old destination if it exists
if exist "%DEST_PATH%" rmdir /s /q "%DEST_PATH%"

:: Run Unzip
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%DEST_PATH%' -Force"

if %errorlevel% neq 0 (
    echo FAILURE: Unzip command failed.
    exit /b 1
)

:: 5. Verify manifest exists
if exist "%DEST_PATH%\manifest.json" (
    echo SUCCESS: Manifest found. Extension is ready.
) else (
    echo FAILURE: Unzip finished, but manifest.json is missing in %DEST_PATH%.
    exit /b 1
)

:: Exit cleanly
exit /b 0
