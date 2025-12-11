# setup_extension.ps1
# 1. Define paths on the SAUCE VM
$zipPath = "C:\sauce\extension.zip"
$destPath = "C:\sauce\my_extension"

# 2. Create the folder
New-Item -ItemType Directory -Force -Path "C:\sauce"

# 3. Download your zipped extension (Replace with YOUR zip link)
Invoke-WebRequest -Uri "https://github.com/oabgnol63/prer/raw/refs/heads/main/edibdbjcniadpccecjdfdjjppcpchdlm.zip" -OutFile $zipPath

# 4. Unzip it so Chrome can read the folder
Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
