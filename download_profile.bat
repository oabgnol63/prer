@echo off
setlocal

set "PROFILE_URL=https://drive.usercontent.google.com/download?id=1I5E5xBjHINx-91_luXaqPu23yH6x02cN&export=download&confirm=t&uuid=f8efb204-85e4-45cc-b170-e283e52f4d22"
set "ZIP_FILE=%TEMP%\profile_download.zip"
set "EXTRACT_DIR=%TEMP%\profile_extract"
set "SRC_PROFILE=%EXTRACT_DIR%\Profile 4"

REM Use a CUSTOM folder, not Chrome's system folder
set "CUSTOM_PROFILE=C:\Users\sauce\CustomChromeProfile\Default"

echo [Sauce Prerun] Downloading profile...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PROFILE_URL%', '%ZIP_FILE%')"

if not exist "%ZIP_FILE%" (
    echo [Sauce Prerun] ERROR: Download failed.
    exit /b 1
)

echo [Sauce Prerun] Extracting...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force"

:: Create fresh custom profile folder
mkdir "%CUSTOM_PROFILE%"

:: Copy ONLY Extensions folder (no Preferences)
echo [Sauce Prerun] Copying Extensions...
xcopy "%SRC_PROFILE%\Extensions\*" "%CUSTOM_PROFILE%\Extensions\" /E /I /Y

echo [Sauce Prerun] Done.
exit /b 0
