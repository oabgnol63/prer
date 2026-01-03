@echo off
setlocal

:: 1. DEFINE VARIABLES
:: Chrome
set "EXT1_ID=ddkjiahejlhfcafbddmgiahcphecmpfh"
set "EXT2_ID=edibdbjcniadpccecjdfdjjppcpchdlm"
set "EXT3_ID=gidlfommnbibbmegmgajdbikelkdcmcl"
set "EXT4_ID=ohahllgiabjaoigichmmfljhkcfikeof"

:: Edge:
set "EXT1_EID=cimighlppcgcoapaliogpjjdehbnofhn"
set "EXT2_EID=kkacdgacpkediooahopgcbdahlpipheh"
set "EXT3_EID=pciakllldcajllepkbbihkmfkikheffb"

:: Standard Web Store Update URL
set "URL=https://clients2.google.com/service/update2/crx"
set "EDGE_URL=https://edge.microsoft.com/extensionwebstorebase/v1/crx"

:: 2. CLEANUP OLD KEYS (To avoid conflicts)
reg delete "HKCU\Software\Google\Chrome\Extensions" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul 2>&1

reg delete "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallForcelist" /f >nul 2>&1

:: 3. CREATE THE POLICY KEY (HKCU)
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /f >nul
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallForcelist" /f >nul

:: 4. ADD THE EXTENSION
:: Because this is a Web Store URL, Chrome allows this even on non-enterprise machines.
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "%EXT1_ID%;%URL%" /f >nul
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /v "2" /t REG_SZ /d "%EXT2_ID%;%URL%" /f >nul
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /v "3" /t REG_SZ /d "%EXT3_ID%;%URL%" /f >nul
:: reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallForcelist" /v "4" /t REG_SZ /d "%EXT4_ID%;%URL%" /f >nul

reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "%EXT1_EID%;%EDGE_URL%" /f >nul
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallForcelist" /v "2" /t REG_SZ /d "%EXT2_EID%;%EDGE_URL%" /f >nul
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallForcelist" /v "3" /t REG_SZ /d "%EXT3_EID%;%EDGE_URL%" /f >nul
exit /b 0
