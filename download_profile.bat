@echo off
setlocal

set "PROFILE_URL=https://drive.usercontent.google.com/download?id=1I5E5xBjHINx-91_luXaqPu23yH6x02cN&export=download&confirm=t&uuid=f8efb204-85e4-45cc-b170-e283e52f4d22"
set "ZIP_FILE=%TEMP%\profile_download.zip"
set "EXTRACT_DIR=%TEMP%\profile_extract"
set "SRC_PROFILE=%EXTRACT_DIR%\Profile 4"
set "CUSTOM_PROFILE=C:\Users\sauce\CustomChromeProfile\Default"

echo [Sauce Prerun] Downloading profile...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PROFILE_URL%', '%ZIP_FILE%')"

if not exist "%ZIP_FILE%" (
    echo [Sauce Prerun] ERROR: Download failed.
    exit /b 1
)

echo [Sauce Prerun] Extracting to %EXTRACT_DIR%...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force"

:: DEBUG: Show what was extracted
echo [Sauce Prerun] Contents of EXTRACT_DIR:
dir "%EXTRACT_DIR%" /s /b

:: Check if source Extensions folder exists
if not exist "%SRC_PROFILE%\Extensions" (
    echo [Sauce Prerun] ERROR: Extensions folder not found at %SRC_PROFILE%\Extensions
    echo [Sauce Prerun] Checking alternative paths...
    dir "%EXTRACT_DIR%" /s /b | findstr /i "Extensions"
    exit /b 1
)

:: Create destination folder
echo [Sauce Prerun] Creating %CUSTOM_PROFILE%\Extensions
mkdir "%CUSTOM_PROFILE%\Extensions"

:: Copy Extensions folder
echo [Sauce Prerun] Copying from %SRC_PROFILE%\Extensions to %CUSTOM_PROFILE%\Extensions
xcopy "%SRC_PROFILE%\Extensions" "%CUSTOM_PROFILE%\Extensions" /E /I /Y

:: DEBUG: Verify copy worked
echo [Sauce Prerun] Verifying destination:
dir "%CUSTOM_PROFILE%\Extensions" /s /b

echo [Sauce Prerun] Done.
exit /b 0
