@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 > nul
:: FIX WINDOW SIZE
mode con: cols=110 lines=45
cd /d "%~dp0"

:: --- CONFIGURATION ---
set "APP_TITLE=ZAPRET TOOLKIT"
set "LOCAL_VERSION=1.1.0 (ArtworkPunk Edition)"
set "REPO_URL=https://github.com/ArtworkPunk/Zapret-Toolkit"
set "CHECKER_URL=https://hyperion-cs.github.io/dpi-checkers/ru/tcp-16-20/"

:: --- ANSI COLORS ---
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "c_rst=%ESC%[0m"
set "c_cyan=%ESC%[36m"
set "c_mag=%ESC%[35m"
set "c_grn=%ESC%[32m"
set "c_yel=%ESC%[33m"
set "c_red=%ESC%[31m"
set "c_wht=%ESC%[37m"
set "c_gry=%ESC%[90m"
set "c_bld=%ESC%[1m"

:: --- GET OS VERSION ---
set "OS_NAME=Windows 10/11"
for /f "tokens=2 delims==" %%I in ('wmic os get Caption /value 2^>nul') do set "OS_NAME=%%I"

:: --- EXTERNAL COMMANDS ---
if "%~1"=="status_zapret" (
    call :test_service art_bypass soft
    call :tcp_enable
    exit /b
)
if "%~1"=="check_updates" (
    call :service_check_updates soft
    exit /b
)
if "%~1"=="load_game_filter" (
    call :game_switch_status
    exit /b
)

:: --- ADMIN CHECK ---
if "%1"=="admin" (
    goto :menu
) else (
    cls
    echo.
    echo  %c_cyan%:: REQUESTING ADMIN PRIVILEGES...%c_rst%
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit
)

:: ============================================================================
:: MENU
:: ============================================================================
:menu
cls
call :ipset_calc_status
call :game_switch_status
call :check_active_service

:: HEADER
echo.
echo  %c_cyan%%c_bld%  ███████╗ █████╗ ██████╗ ██████╗ ███████╗████████╗%c_rst%
echo  %c_cyan%%c_bld%  ╚══███╔╝██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝%c_rst%
echo  %c_mag%%c_bld%    ███╔╝ ███████║██████╔╝██████╔╝█████╗     ██║   %c_rst%
echo  %c_mag%%c_bld%   ███╔╝  ██╔══██║██╔═══╝ ██╔══██╗██╔══╝     ██║   %c_rst%
echo  %c_cyan%%c_bld%  ███████╗██║  ██║██║     ██║  ██║███████╗   ██║   %c_rst%
echo  %c_cyan%%c_bld%  ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝   %c_rst%
echo.
echo  %c_gry%  /////////////////////////////////////////////////%c_rst%
echo  %c_cyan%  :: SYSTEM     : %c_wht%!LOCAL_VERSION!%c_rst%
echo  %c_cyan%  :: USER       : %c_grn%ADMINISTRATOR%c_rst%
echo  %c_cyan%  :: OS         : %c_wht%!OS_NAME!%c_rst%
echo  %c_cyan%  :: GITHUB     : %c_gry%!REPO_URL!%c_rst%
echo  %c_gry%  /////////////////////////////////////////////////%c_rst%
echo.

:: STATUS INDICATORS
set "st_srv=%c_red%STOPPED%c_rst%"
if "!SERVICE_ACTIVE!"=="1" set "st_srv=%c_grn%RUNNING (ALL PROFILE WORKING)%c_rst%"

set "st_gm=%c_gry%OFF%c_rst%"
if "%GameFilterStatus%"=="enabled" set "st_gm=%c_grn%ACTIVE (UDP 1024-65535)%c_rst%"

set "st_ip=%c_gry%DISABLED%c_rst%"
if "%IPsetStatus%"=="loaded" set "st_ip=%c_grn%FILTERED (USING LISTS)%c_rst%"
if "%IPsetStatus%"=="any" set "st_ip=%c_yel%ALL TRAFFIC (TUNNELING EVERYTHING)%c_rst%"
if "%IPsetStatus%"=="none" set "st_ip=%c_gry%DISABLED (DUMMY IP ONLY)%c_rst%"

echo  %c_cyan%[ SYSTEM STATUS ]%c_rst%
echo    %c_mag%+%c_rst% ENGINE      : !st_srv!
echo    %c_mag%+%c_rst% GAME MODE   : !st_gm!
echo    %c_mag%+%c_rst% IP FILTER   : !st_ip!
echo.

:: MENU OPTIONS
echo  %c_cyan%[ OPERATIONS ]%c_rst%
echo  %c_gry%  1.%c_rst% %c_wht%INSTALL SERVICE%c_rst%     %c_gry%:: Setup background bypass%c_rst%
echo  %c_gry%  2.%c_rst% %c_wht%REMOVE SERVICE%c_rst%      %c_gry%:: Uninstall ^& Cleanup%c_rst%
echo  %c_gry%  3.%c_rst% %c_wht%CHECK STATUS%c_rst%        %c_gry%:: View active config%c_rst%
echo  %c_gry%  4.%c_rst% %c_wht%DIAGNOSTICS%c_rst%         %c_gry%:: Scan for conflicts%c_rst%
echo.
echo  %c_cyan%[ FILTERS ^& NETWORK ]%c_rst%
echo  %c_gry%  5.%c_rst% %c_wht%GAME FILTER%c_rst%         %c_gry%:: Toggle UDP optimization%c_rst%
echo  %c_gry%  6.%c_rst% %c_wht%IP FILTER%c_rst%           %c_gry%:: Toggle IP blacklist%c_rst%
echo  %c_gry%  7.%c_rst% %c_wht%SET DNS%c_rst%             %c_gry%:: Cloudflare/Google + Flush%c_rst%
echo  %c_gry%  8.%c_rst% %c_wht%GLOBAL CHECK%c_rst%        %c_gry%:: Test DPI connectivity%c_rst%
echo.
echo  %c_cyan%[ SYSTEM ]%c_rst%
echo  %c_gry%  9.%c_rst% %c_wht%UPDATE LISTS%c_rst%        %c_gry%:: Sync from GitHub%c_rst%
echo  %c_gry% 10.%c_rst% %c_wht%CHECK UPDATES%c_rst%       %c_gry%:: Update Toolkit%c_rst%
echo.
echo  %c_gry%  0.%c_rst% %c_red%EXIT%c_rst%
echo.

set "menu_choice="
set /p menu_choice="%c_cyan%  INPUT > %c_rst%"

if "%menu_choice%"=="1" goto service_install
if "%menu_choice%"=="2" goto service_remove
if "%menu_choice%"=="3" goto service_status
if "%menu_choice%"=="4" goto service_diagnostics
if "%menu_choice%"=="5" goto game_switch
if "%menu_choice%"=="6" goto ipset_switch
if "%menu_choice%"=="7" goto dns_menu
if "%menu_choice%"=="8" goto global_check
if "%menu_choice%"=="9" goto update_lists_manual
if "%menu_choice%"=="10" goto service_check_updates
if "%menu_choice%"=="0" exit /b

goto menu

:: ============================================================================
:: INSTALL
:: ============================================================================
:service_install
cls
echo.
echo  %c_cyan%:: INSTALLATION%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
echo.

cd /d "%~dp0"
set "BIN_PATH=%~dp0bin\"
set "LISTS_PATH=%~dp0lists\"

set "count=0"
echo  Available Presets:
echo.
for %%f in (*.bat) do (
    set "filename=%%~nxf"
    if /i not "!filename:~0,7!"=="service" (
        set /a count+=1
        if !count! LSS 10 (
            echo   %c_gry%0!count!%c_rst% ^| %%f
        ) else (
            echo   %c_gry%!count!%c_rst% ^| %%f
        )
        set "file!count!=%%f"
    )
)
echo.
set "choice="
set /p "choice=%c_cyan%  SELECT NUMBER > %c_rst%"
if "!choice!"=="" goto menu

set "selectedFile=!file%choice%!"
if not defined selectedFile (
    echo  %c_red%Invalid selection.%c_rst%
    pause
    goto menu
)

:: ARGS PARSER
set "args_with_value=sni host altorder"
set "args="
set "capture=0"
set "mergeargs=0"
set QUOTE="

for /f "tokens=*" %%a in ('type "!selectedFile!"') do (
    set "line=%%a"
    call set "line=%%line:^!=EXCL_MARK%%"
    echo !line! | findstr /i "%BIN%winws.exe" >nul
    if not errorlevel 1 set "capture=1"

    if !capture!==1 (
        if not defined args set "line=!line:*%BIN%winws.exe"=!"
        set "temp_args="
        for %%i in (!line!) do (
            set "arg=%%i"
            if not "!arg!"=="^" (
                if "!arg:~0,2!" EQU "--" if not !mergeargs!==0 set "mergeargs=0"
                if "!arg:~0,1!" EQU "!QUOTE!" (
                    set "arg=!arg:~1,-1!"
                    echo !arg! | findstr ":" >nul
                    if !errorlevel!==0 (
                        set "arg=\!QUOTE!!arg!\!QUOTE!"
                    ) else if "!arg:~0,1!"=="@" (
                        set "arg=\!QUOTE!@%~dp0!arg:~1!\!QUOTE!"
                    ) else if "!arg:~0,5!"=="%%BIN%%" (
                        set "arg=\!QUOTE!!BIN_PATH!!arg:~5!\!QUOTE!"
                    ) else if "!arg:~0,7!"=="%%LISTS%%" (
                        set "arg=\!QUOTE!!LISTS_PATH!!arg:~7!\!QUOTE!"
                    ) else (
                        set "arg=\!QUOTE!%~dp0!arg!\!QUOTE!"
                    )
                ) else if "!arg:~0,12!" EQU "%%GameFilter%%" set "arg=%GameFilter%"
                
                if !mergeargs!==1 (
                    set "temp_args=!temp_args!,!arg!"
                ) else if !mergeargs!==3 (
                    set "temp_args=!temp_args!=!arg!"
                    set "mergeargs=1"
                ) else (
                    set "temp_args=!temp_args! !arg!"
                )

                if "!arg:~0,2!" EQU "--" (
                    set "mergeargs=2"
                ) else if !mergeargs! GEQ 1 (
                    if !mergeargs!==2 set "mergeargs=1"
                    for %%x in (!args_with_value!) do (
                        if /i "%%x"=="!arg!" set "mergeargs=3"
                    )
                )
            )
        )
        if not "!temp_args!"=="" set "args=!args! !temp_args!"
    )
)

call :tcp_enable
set ARGS=%args%
call set "ARGS=%%ARGS:EXCL_MARK=^!%%"
set SRVCNAME=art_bypass

net stop %SRVCNAME% >nul 2>&1
sc delete %SRVCNAME% >nul 2>&1
sc create %SRVCNAME% binPath= "\"%BIN_PATH%winws.exe\" !ARGS!" DisplayName= "Artwork Bypass" start= auto >nul
sc description %SRVCNAME% "Artwork DPI bypass for games and streaming" >nul
sc start %SRVCNAME% >nul

for %%F in ("!file%choice%!") do set "filename=%%~nF"
reg add "HKLM\System\CurrentControlSet\Services\art_bypass" /v art_bypass-config /t REG_SZ /d "!filename!" /f >nul

echo.
echo  %c_grn%[OK] Service installed successfully.%c_rst%
echo  Config: !filename!
echo.
pause
goto menu

:: ============================================================================
:: REMOVE
:: ============================================================================
:service_remove
cls
echo.
echo  %c_cyan%:: UNINSTALL%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
echo.

set SRVCNAME=art_bypass
sc query "!SRVCNAME!" >nul 2>&1
if !errorlevel!==0 (
    net stop %SRVCNAME% >nul 2>&1
    sc delete %SRVCNAME% >nul 2>&1
    echo  %c_grn%[+] Service removed%c_rst%
) else (
    echo  %c_gry%[-] Service not found%c_rst%
)

tasklist /FI "IMAGENAME eq winws.exe" | find /I "winws.exe" > nul
if !errorlevel!==0 (
    taskkill /IM winws.exe /F > nul
    echo  %c_grn%[+] Process killed%c_rst%
)

sc query "WinDivert" >nul 2>&1
if !errorlevel!==0 (
    net stop "WinDivert" >nul 2>&1
    sc delete "WinDivert" >nul 2>&1
    echo  %c_grn%[+] Driver unloaded%c_rst%
)
net stop "WinDivert14" >nul 2>&1
sc delete "WinDivert14" >nul 2>&1

echo.
echo  %c_grn%Cleanup complete.%c_rst%
pause
goto menu

:: ============================================================================
:: STATUS (CRASH FIXED - NO BLOCKS)
:: ============================================================================
:service_status
cls
echo.
echo  %c_cyan%:: SERVICE STATUS%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
echo.

:: Show Config
set "CONFIG_NAME=Unknown"
sc query "art_bypass" >nul 2>&1
if !errorlevel!==0 (
    for /f "tokens=2*" %%A in ('reg query "HKLM\System\CurrentControlSet\Services\art_bypass" /v art_bypass-config 2^>nul') do set "CONFIG_NAME=%%B"
)

if "!CONFIG_NAME!"=="Unknown" goto :st_no_cfg
echo  %c_cyan%[i] Config:%c_rst% !CONFIG_NAME!
goto :st_check_srv

:st_no_cfg
echo  %c_red%[!] Service not installed%c_rst%

:st_check_srv
echo.
call :test_service art_bypass
call :test_service WinDivert
echo.

:: Check Process
tasklist /FI "IMAGENAME eq winws.exe" | find /I "winws.exe" > nul
if !errorlevel!==0 goto :st_proc_ok
echo  %c_red%[X] Bypass Engine (winws.exe) NOT FOUND%c_rst%
goto :st_end

:st_proc_ok
echo  %c_grn%[OK] Bypass Engine (winws.exe) is ACTIVE%c_rst%

:st_end
echo.
echo  %c_gry%Press any key to return...%c_rst%
pause >nul
goto menu

:: Test Service Helper (Linear Logic)
:test_service
set "SrvName=%~1"
set "SrvState="
for /f "tokens=3 delims=: " %%A in ('sc query "%SrvName%" ^| findstr /i "STATE"') do set "SrvState=%%A"
set "SrvState=%SrvState: =%"

if "%SrvState%"=="RUNNING" goto :ts_run
if "%SrvState%"=="STOP_PENDING" goto :ts_stop_pend
goto :ts_stopped

:ts_run
if "%~2"=="soft" (
    echo  %c_yel%Already running.%c_rst%
) else (
    echo  %c_grn%[+] Service "%SrvName%" is RUNNING%c_rst%
)
exit /b

:ts_stop_pend
echo  %c_yel%[?] "%SrvName%" is STOP_PENDING%c_rst%
exit /b

:ts_stopped
if not "%~2"=="soft" echo  %c_gry%[-] Service "%SrvName%" is NOT running%c_rst%
exit /b

:: ============================================================================
:: DIAGNOSTICS
:: ============================================================================
:service_diagnostics
cls
echo.
echo  %c_cyan%:: DIAGNOSTICS%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
echo.

:: BFE
sc query BFE | findstr /I "RUNNING" > nul
if !errorlevel!==0 ( call :PrintRes "Base Filtering Engine" 1 ) else ( call :PrintRes "Base Filtering Engine" 0 )

:: Proxy
set "pEnabled=0"
for /f "tokens=2*" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul ^| findstr /i "ProxyEnable"') do (
    if "%%B"=="0x1" set "pEnabled=1"
)
if !pEnabled!==1 ( call :PrintRes "System Proxy (Check settings)" 2 ) else ( call :PrintRes "Proxy Check" 1 )

:: TCP Timestamps
netsh interface tcp show global | findstr /i "timestamps" | findstr /i "enabled" > nul
if !errorlevel!==0 (
    call :PrintRes "TCP Timestamps" 1
) else (
    netsh interface tcp set global timestamps=enabled > nul 2>&1
    call :PrintRes "TCP Timestamps (Auto-fixed)" 1
)

:: Conflicts
tasklist /FI "IMAGENAME eq AdguardSvc.exe" | find /I "AdguardSvc.exe" > nul
if !errorlevel!==0 ( call :PrintRes "Adguard Conflict" 0 ) else ( call :PrintRes "Adguard Check" 1 )

sc query | findstr /I "Killer" > nul
if !errorlevel!==0 ( call :PrintRes "Killer Network Conflict" 0 ) else ( call :PrintRes "Killer Check" 1 )

sc query | findstr /I "TracSrvWrapper" > nul
if !errorlevel!==0 ( call :PrintRes "Check Point VPN Conflict" 0 ) else ( call :PrintRes "Check Point Check" 1 )

:: WinDivert Cleanup 
echo.
echo  %c_cyan%[ Driver Check ]%c_rst%
tasklist /FI "IMAGENAME eq winws.exe" | find /I "winws.exe" > nul
set "w_run=!errorlevel!"
sc query "WinDivert" | findstr /I "RUNNING STOP_PENDING" > nul
set "d_run=!errorlevel!"

:: Logic: WinWS is NOT running (1) AND WinDivert IS running (0) -> PROBLEM
if "!w_run!" neq "0" (
    if "!d_run!"=="0" goto :diag_cleanup
)
:: Else -> Everything is fine
goto :diag_ok

:diag_cleanup
echo  %c_yel%[!] Orphaned WinDivert found. Cleaning...%c_rst%
net stop "WinDivert" >nul 2>&1
sc delete "WinDivert" >nul 2>&1

set "conflicts=GoodbyeDPI discordfix_zapret"
for %%s in (!conflicts!) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel!==0 (
        echo  %c_red%[!] Removed conflict: %%s%c_rst%
        net stop "%%s" >nul 2>&1
        sc delete "%%s" >nul 2>&1
    )
)
echo  %c_grn%[OK] Driver cleanup done.%c_rst%
goto :diag_cache

:diag_ok
echo  %c_grn%[OK] No driver conflicts.%c_rst%
goto :diag_cache

:diag_cache
echo.
echo  %c_cyan%[ Cache ]%c_rst%
set "ch="
set /p "ch=  Clear Discord cache? (Y/N) [Y]: "
if "!ch!"=="" set "ch=Y"
if /i "!ch!"=="Y" (
    tasklist /FI "IMAGENAME eq Discord.exe" | findstr /I "Discord.exe" > nul
    if !errorlevel!==0 taskkill /IM Discord.exe /F > nul
    
    set "dDir=%appdata%\discord"
    for %%d in ("Cache" "Code Cache" "GPUCache") do (
        if exist "!dDir!\%%~d" (
            rd /s /q "!dDir!\%%~d"
            echo  %c_grn%[+] Deleted %%~d%c_rst%
        )
    )
)

echo.
echo  %c_grn%DONE.%c_rst%
pause
goto menu

:: ============================================================================
:: GAME FILTER
:: ============================================================================
:game_switch_status
set "gameFlagFile=%~dp0bin\game_filter.enabled"
if exist "%gameFlagFile%" (
    set "GameFilterStatus=enabled"
    set "GameFilter=1024-65535"
) else (
    set "GameFilterStatus=disabled"
    set "GameFilter=12"
)
exit /b

:game_switch
call :game_switch_status
if "%GameFilterStatus%"=="disabled" (
    echo ENABLED > "%gameFlagFile%"
    echo  %c_grn%Game Filter ENABLED.%c_rst%
) else (
    del /f /q "%gameFlagFile%"
    echo  %c_yel%Game Filter DISABLED.%c_rst%
)
timeout /t 1 >nul
goto menu

:: ============================================================================
:: IP FILTER (CRASH FIXED - NO NESTED BLOCKS)
:: ============================================================================
:ipset_calc_status
set "listFile=%~dp0lists\ipset-all.txt"
set "IPsetStatus=unknown"
set "IP_COUNT=0"

if exist "%listFile%" (
    for /f %%i in ('type "%listFile%" 2^>nul ^| find /c /v ""') do set "IP_COUNT=%%i"
    
    if !IP_COUNT! EQU 0 (
        set "IPsetStatus=any"
    ) else (
        findstr /R "^203\.0\.113\.113/32$" "%listFile%" >nul
        if !errorlevel!==0 (
            set "IPsetStatus=none"
        ) else (
            set "IPsetStatus=loaded"
        )
    )
) else (
    :: Missing file = Filter everything (Safe default)
    set "IPsetStatus=any"
)
exit /b

:ipset_switch
call :ipset_calc_status
set "listFile=%~dp0lists\ipset-all.txt"
set "backupFile=%listFile%.backup"

echo.
if "!IPsetStatus!"=="any" goto :sw_to_disabled
if "!IPsetStatus!"=="none" goto :sw_to_all
if "!IPsetStatus!"=="loaded" goto :sw_to_disabled
goto :sw_to_all

:sw_to_disabled
echo  %c_yel%[MODE] Switching to DISABLED (Block dummy only)%c_rst%
if exist "%listFile%" (
    del /f /q "%backupFile%" 2>nul
    ren "%listFile%" "ipset-all.txt.backup"
)
>"%listFile%" (
    echo 203.0.113.113/32
)
goto :sw_end

:sw_to_all
echo  %c_grn%[MODE] Switching to ALL TRAFFIC (Filter everything)%c_rst%
if exist "%backupFile%" (
    del /f /q "%listFile%" 2>nul
    ren "%backupFile%" "ipset-all.txt"
)
:: Create empty file if backup restore failed or didn't exist
type nul > "%listFile%"
goto :sw_end

:sw_end
timeout /t 1 >nul
goto menu

:: ============================================================================
:: DNS CHANGER
:: ============================================================================
:dns_menu
cls
echo.
echo  %c_cyan%:: DNS CONFIGURATION%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
echo  Current settings will be overwritten for Ethernet/Wi-Fi.
echo.
echo  1. Cloudflare (1.1.1.1)
echo  2. Google     (8.8.8.8)
echo  3. Yandex     (77.88.8.8)
echo  4. Auto / Reset (DHCP)
echo  0. Back
echo.
set "dns_c="
set /p "dns_c=%c_cyan%  SELECT > %c_rst%"

if "%dns_c%"=="1" (
    set "DNS1=1.1.1.1" && set "DNS2=1.0.0.1" && set "DNSName=Cloudflare"
    goto apply_dns
)
if "%dns_c%"=="2" (
    set "DNS1=8.8.8.8" && set "DNS2=8.8.4.4" && set "DNSName=Google"
    goto apply_dns
)
if "%dns_c%"=="3" (
    set "DNS1=77.88.8.8" && set "DNS2=77.88.8.1" && set "DNSName=Yandex"
    goto apply_dns
)
if "%dns_c%"=="4" goto reset_dns
if "%dns_c%"=="0" goto menu
goto dns_menu

:apply_dns
echo.
echo  %c_yel%Setting %DNSName% DNS...%c_rst%
netsh interface ip set dns "Ethernet" static %DNS1% >nul 2>&1
netsh interface ip add dns "Ethernet" %DNS2% index=2 >nul 2>&1
netsh interface ip set dns "Wi-Fi" static %DNS1% >nul 2>&1
netsh interface ip add dns "Wi-Fi" %DNS2% index=2 >nul 2>&1
echo  %c_grn%[OK] DNS Applied.%c_rst%
goto flush_dns

:reset_dns
echo.
echo  %c_yel%Resetting to DHCP...%c_rst%
netsh interface ip set dns "Ethernet" dhcp >nul 2>&1
netsh interface ip set dns "Wi-Fi" dhcp >nul 2>&1
echo  %c_grn%[OK] DNS Reset.%c_rst%

:flush_dns
echo  Flushing DNS Cache...
ipconfig /flushdns >nul
echo  %c_grn%[OK] Cache Flushed.%c_rst%
pause
goto menu

:: ============================================================================
:: GLOBAL CHECKER
:: ============================================================================
:global_check
echo.
echo  %c_cyan%[ GLOBAL CONNECTIVITY CHECK ]%c_rst%
echo  Opening browser to check connectivity...
echo  Please click "START" on the website.
start "" "%CHECKER_URL%"
goto menu

:: ============================================================================
:: UPDATES
:: ============================================================================
:update_lists_manual
cls
echo.
echo  %c_cyan%:: LIST UPDATER%c_rst%
echo  %c_gry%--------------------------------------------------%c_rst%
set "LIST_FILES=list-exclude.txt list-universal.txt list-foreign.txt list-google.txt list-whatsapp.txt list-general.txt ipset-all.txt ipset-discord.txt ipset-exclude.txt"

for %%F in (%LIST_FILES%) do (
    set "l_file=%~dp0lists\%%F"
    set "r_url=%REPO_URL%/raw/main/lists/%%F"
    
    echo  Checking %%F...
    powershell -command "Invoke-WebRequest -Uri '!r_url!' -OutFile '!l_file!' -UseBasicParsing" >nul 2>&1
    if exist "!l_file!" ( echo   %c_grn%[OK] Synced%c_rst% ) else ( echo   %c_red%[FAIL] Not found%c_rst% )
)
echo.
echo  %c_grn%Update finished.%c_rst%
pause
goto menu

:service_check_updates
echo.
echo  %c_cyan%:: CHECK UPDATES%c_rst%
echo  Opening GitHub releases page...
start "" "%REPO_URL%"
goto menu

:: ============================================================================
:: HELPERS
:: ============================================================================
:tcp_enable
netsh interface tcp show global | findstr /i "timestamps" | findstr /i "enabled" > nul || netsh interface tcp set global timestamps=enabled > nul 2>&1
exit /b

:check_active_service
tasklist /FI "IMAGENAME eq winws.exe" | find /I "winws.exe" > nul
if !errorlevel!==0 ( set "SERVICE_ACTIVE=1" ) else ( set "SERVICE_ACTIVE=0" )
exit /b

:PrintRes
if "%2"=="1" ( echo  %c_grn%[+] %~1%c_rst% ) else if "%2"=="2" ( echo  %c_yel%[?] %~1%c_rst% ) else ( echo  %c_red%[X] %~1%c_rst% )
exit /b