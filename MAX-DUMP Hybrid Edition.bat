@echo off
chcp 1251 > nul

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo Admin rights required
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
call service.bat status_zapret
call service.bat load_game_filter
echo.

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%


start "MAX BYPASS ULTIMATE" /min "%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-tcp=80,443 --hostlist-domains=*.ru,*.рф,*.su,*.москва,*.рус --dpi-desync=fake --dpi-desync-repeats=1 --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-tcp=80,443 --hostlist="%LISTS%list-foreign.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fake-tls-mod=none --new ^
--filter-udp=443 --hostlist="%LISTS%list-foreign.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-universal.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-whatsapp.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-universal.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-whatsapp.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-google.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-google.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=3 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fake-tls-mod=none --new ^
--filter-tcp=80,443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fake-tls-mod=none --new ^
--filter-udp=443 --ipset="%LISTS%ipset-discord.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80,443,%GameFilter% --ipset="%LISTS%ipset-all.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-fake-tls-mod=none --new ^
--filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^

--filter-tcp=443 --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=3 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=443 --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2

echo.
echo ============================================
echo ZAPRET Eternal: MAX-DUMP Hybrid Edition
echo ============================================
echo  Universal Auto-Catch: ENABLED
echo ============================================
pause >nul