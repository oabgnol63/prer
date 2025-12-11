# setup_extension.ps1
# Stop strictly on error so we catch failures immediately
$ErrorActionPreference = "Stop"
New-Item -ItemType File -Force -Path "C:\Users\sauce\i_was_here.txt"
$zipPath = "C:/Users/sauce/extension.zip"
$destPath = "C:/Users/sauce/my_extension"

try {
    Write-Output "--- STARTING EXTENSION SETUP ---"

    # 1. Create directory
    if (-not (Test-Path -Path "C:\sauce")) {
        New-Item -ItemType Directory -Force -Path "C:\sauce" | Out-Null
    }

    # 2. Download (Replace URL with your raw GitHub link)
    Write-Output "Downloading zip..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/oabgnol63/prer/refs/heads/main/test.zip" -OutFile $zipPath

    # 3. Unzip
    Write-Output "Unzipping..."
    Expand-Archive -Path $zipPath -DestinationPath $destPath -Force

    # 4. Verify manifest exists
    if (Test-Path "$destPath\manifest.json") {
        Write-Output "SUCCESS: Manifest found. Extension is ready."
    } else {
        throw "FAILURE: Unzip finished, but manifest.json is missing in $destPath."
    }

} catch {
    Write-Output "FAILURE: Script crashed."
    Write-Output $_.Exception.Message
    exit 1
}
