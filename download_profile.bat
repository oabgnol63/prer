@echo off
setlocal

:: --- CONFIGURATION ---
:: 1. The URL where your zipped profile is hosted.
::    (If using Sauce Storage, use the direct link or API link)
set "PROFILE_URL=https://drive.usercontent.google.com/download?id=1I5E5xBjHINx-91_luXaqPu23yH6x02cN&export=download&confirm=t&uuid=f8efb204-85e4-45cc-b170-e283e52f4d22"

:: 2. The destination on the Sauce VM.
::    We create a specific folder 'chrome-profile' inside 'sauce' to keep it clean.
set "DEST_DIR=C:\Users\sauce\AppData\Local\Google\Chrome\User Data"

:: 3. The temp path for the zip file download
set "ZIP_FILE=%TEMP%\profile_download.zip"

:: --- EXECUTION ---
echo [Sauce Prerun] Starting Chrome Profile Setup...

:: 1. Download the Zip file using PowerShell (works on all Sauce Windows VMs)
echo [Sauce Prerun] Downloading profile from %PROFILE_URL%...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PROFILE_URL%', '%ZIP_FILE%')"

:: Check if download succeeded
if not exist "%ZIP_FILE%" (
    echo [Sauce Prerun] ERROR: Download failed. Exiting.
    exit /b 1
)

:: 2. Unzip the file
echo [Sauce Prerun] Extracting to %DEST_DIR%...
:: -Force overwrites if it already exists
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%DEST_DIR%' -Force"

:: 3. Cleanup
del "%ZIP_FILE%"

echo [Sauce Prerun] Setup Complete.
echo [Sauce Prerun] Profile is located at: %DEST_DIR%
exit /b 0
