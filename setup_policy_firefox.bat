@echo off
REM Force Windows to always show scrollbars (disable auto-hide / overlay).
REM Required for Firefox/Safari visual-diff in comparator2: aligns the
REM client-side clientWidth with the Surrogate Blink's clientWidth so that
REM page content lays out at the same width in both screenshots.
REM
REM Registry: HKCU\Control Panel\Accessibility\DynamicScrollbars (DWORD)
REM   0 = always show classic scrollbars
REM   1 = auto-hide overlay (Windows default)
REM
REM Firefox reads this on startup; relaunch Firefox after running this.
REM To revert: run with /restore as the first arg.

setlocal

if /I "%~1"=="/restore" (
    reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 1 /f >nul
    if errorlevel 1 (
        echo [force_classic_scrollbars] FAILED to restore registry value.
        exit /b 1
    )
    echo [force_classic_scrollbars] Restored DynamicScrollbars=1 ^(auto-hide^).
    exit /b 0
)

reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 0 /f >nul
if errorlevel 1 (
    echo [force_classic_scrollbars] FAILED to set registry value.
    exit /b 1
)

echo [force_classic_scrollbars] Set DynamicScrollbars=0 ^(always show scrollbars^).
echo [force_classic_scrollbars] Restart Firefox/Safari for the change to take effect.
exit /b 0
