@echo off
setlocal

:: --- CONFIGURATION ---
set "PROFILE_URL=https://drive.usercontent.google.com/download?id=1I5E5xBjHINx-91_luXaqPu23yH6x02cN&export=download&confirm=t&uuid=f8efb204-85e4-45cc-b170-e283e52f4d22"
set "CHROME_DEFAULT_PROFILE=C:\Users\sauce\AppData\Local\Google\Chrome\User Data\Default"
set "ZIP_FILE=%TEMP%\profile_download.zip"
set "EXTRACT_DIR=%TEMP%\profile_extract"

:: --- EXECUTION ---
echo [Sauce Prerun] Downloading profile...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PROFILE_URL%', '%ZIP_FILE%')"

if not exist "%ZIP_FILE%" (
    echo [Sauce Prerun] ERROR: Download failed.
    exit /b 1
)

echo [Sauce Prerun] Extracting...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force"

echo [Sauce Prerun] Copying Extensions folder...
xcopy "%EXTRACT_DIR%\Default\Extensions" "%CHROME_DEFAULT_PROFILE%\Extensions" /E /I /Y

:: Cleanup
del "%ZIP_FILE%"
rmdir /S /Q "%EXTRACT_DIR%"

echo [Sauce Prerun] Done.
exit /b 0
