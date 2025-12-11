# setup_extension.ps1
# 1. Define paths on the SAUCE VM
$zipPath = "C:\Users\sauce\extension.zip"
$destPath = "C:\Users\sauce\my_extension"

# 2. Create the folder
New-Item -ItemType Directory -Force -Path "C:\sauce"

# 3. Download your zipped extension (Replace with YOUR zip link)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/oabgnol63/prer/refs/heads/main/test.zip" -OutFile $zipPath

# 4. Unzip it so Chrome can read the folder
Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
