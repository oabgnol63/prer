@echo off
setlocal

set "PROFILE_URL=https://drive.usercontent.google.com/download?id=1I5E5xBjHINx-91_luXaqPu23yH6x02cN&export=download&confirm=t&uuid=f8efb204-85e4-45cc-b170-e283e52f4d22"
set "ZIP_FILE=%TEMP%\profile_download.zip"
set "EXTRACT_DIR=%TEMP%\profile_extract"
set "CHROME_USER_DATA=%LOCALAPPDATA%\Google\Chrome\User Data"
set "SRC_PROFILE=%EXTRACT_DIR%\Profile 1"
set "DST_PROFILE=%CHROME_USER_DATA%\Default"

echo [Sauce Prerun] Downloading profile...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%PROFILE_URL%', '%ZIP_FILE%')"

if not exist "%ZIP_FILE%" (
    echo [Sauce Prerun] ERROR: Download failed.
    exit /b 1
)

echo [Sauce Prerun] Extracting...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force"

:: Create Default folder if it doesn't exist
if not exist "%DST_PROFILE%" mkdir "%DST_PROFILE%"

:: Copy Extensions folder
echo [Sauce Prerun] Copying Extensions...
xcopy "%SRC_PROFILE%\Extensions\*" "%DST_PROFILE%\Extensions\" /E /I /Y

:: Copy Preferences files (required for Chrome to recognize extensions)
echo [Sauce Prerun] Copying Preferences...
if exist "%SRC_PROFILE%\Preferences" copy /Y "%SRC_PROFILE%\Preferences" "%DST_PROFILE%\Preferences"
if exist "%SRC_PROFILE%\Secure Preferences" copy /Y "%SRC_PROFILE%\Secure Preferences" "%DST_PROFILE%\Secure Preferences"

:: Cleanup

echo [Sauce Prerun] Done.
exit /b 0
