@echo off
chcp 1251 > nul

:: [ADMIN RIGHTS CHECK]
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo Admin rights required...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
if exist service.bat (
    call service.bat status_zapret
    call service.bat load_game_filter
)

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "YT_DS_ULTIMATE" /min "%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443 --wf-udp=443,19294-19344,50000-65535 ^
--filter-tcp=443 --hostlist="%LISTS%list-discordyoutube.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-discordyoutube.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-universal.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-universal.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-google.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-google.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=19294-19344,50000-65535 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%quic_initial_www_google_com.bin" --dpi-desync-fake-stun="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fake-tls-mod=none --new ^
--filter-udp=50000-65535 --ipset="%LISTS%ipset-discord.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=1 --dpi-desync-cutoff=n1 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin"

echo.
pause >nul