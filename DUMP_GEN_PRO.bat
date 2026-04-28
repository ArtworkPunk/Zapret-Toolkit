@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul

:: Код для цветов (ANSI)
for /F %%a in ('echo prompt $E ^| cmd') do set "E=%%a"

echo %E%[36m====================================================%E%[0m
echo %E%[36m     TLS CLIENT HELLO ULTIMATE GEN v1.3.3.7            %E%[0m
echo %E%[36m====================================================%E%[0m
echo.

:: Переходим в папку батника
cd /d "%~dp0"

set /p "USER_DOMAIN=Введите домен (например, github.com или нажмите enter): "
if "%USER_DOMAIN%"=="" set "USER_DOMAIN=github.com"

set "OUT_FILE=tls_clienthello_max_ru.bin"
set "PS_TEMP_SCRIPT=logic_v13.ps1"

:: Удаляем старые файлы
if exist "%OUT_FILE%" del /f /q "%OUT_FILE%" 2>nul
if exist "%PS_TEMP_SCRIPT%" del /f /q "%PS_TEMP_SCRIPT%" 2>nul

echo %E%[33m[1/3] Подготовка генератора...%E%[0m

:: Записываем логику. Используем сложение [byte[]] массивов вместо AddRange.
(
echo $domain = '%USER_DOMAIN%'
echo $path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('.\%OUT_FILE%'^)
echo $sni = [System.Text.Encoding]::UTF8.GetBytes($domain^)
echo $r = New-Object Byte[] 32; [System.Security.Cryptography.RandomNumberGenerator]::Create(^).GetBytes($r^)
echo $s = New-Object Byte[] 32; [System.Security.Cryptography.RandomNumberGenerator]::Create(^).GetBytes($s^)
echo $pk = New-Object Byte[] 32; [System.Security.Cryptography.RandomNumberGenerator]::Create(^).GetBytes($pk^)
echo.
echo # Главное тело
echo [byte[]]$body = @([byte]0x03, [byte]0x03^) + $r + @([byte]0x20^) + $s + @([byte]0x00, [byte]0x24, [byte]0x13, [byte]0x01, [byte]0x13, [byte]0x02, [byte]0x13, [byte]0x03, [byte]0xc0, [byte]0x2b, [byte]0xc0, [byte]0x2f, [byte]0xc0, [byte]0x2c, [byte]0xc0, [byte]0x30, [byte]0xcc, [byte]0xa9, [byte]0xcc, [byte]0xa8, [byte]0xc0, [byte]0x13, [byte]0xc0, [byte]0x14, [byte]0x00, [byte]0x9c, [byte]0x00, [byte]0x9d, [byte]0x00, [byte]0x2f, [byte]0x00, [byte]0x35, [byte]0x00, [byte]0x0a, [byte]0x4a, [byte]0x4a, [byte]0x00, [byte]0xff^) + @([byte]0x01, [byte]0x00^)
echo.
echo # Расширения
echo $sl = $sni.Length
echo [byte[]]$exts = @([byte]0x00, [byte]0x00, [byte][math]::Truncate(($sl+5^)/256^), [byte](($sl+5^) %% 256^), [byte][math]::Truncate(($sl+3^)/256^), [byte](($sl+3^) %% 256^), [byte]0x00, [byte][math]::Truncate($sl/256^), [byte]($sl %% 256^)^) + $sni
echo $exts += @([byte]0x00, [byte]0x0a, [byte]0x00, [byte]0x08, [byte]0x00, [byte]0x06, [byte]0x00, [byte]0x1d, [byte]0x00, [byte]0x17, [byte]0x00, [byte]0x18^)
echo $exts += @([byte]0x00, [byte]0x0d, [byte]0x00, [byte]0x14, [byte]0x00, [byte]0x12, [byte]0x04, [byte]0x03, [byte]0x08, [byte]0x04, [byte]0x04, [byte]0x01, [byte]0x05, [byte]0x03, [byte]0x08, [byte]0x05, [byte]0x05, [byte]0x01, [byte]0x08, [byte]0x06, [byte]0x06, [byte]0x01^)
echo $exts += @([byte]0x00, [byte]0x10, [byte]0x00, [byte]0x0e, [byte]0x00, [byte]0x0c, [byte]0x02, [byte]0x68, [byte]0x32, [byte]0x08, [byte]0x68, [byte]0x74, [byte]0x74, [byte]0x70, [byte]0x2f, [byte]0x31, [byte]0x2e, [byte]0x31^)
echo $exts += @([byte]0x00, [byte]0x2b, [byte]0x00, [byte]0x03, [byte]0x02, [byte]0x03, [byte]0x04^)
echo $exts += @([byte]0x00, [byte]0x33, [byte]0x00, [byte]0x26, [byte]0x00, [byte]0x24, [byte]0x00, [byte]0x1d, [byte]0x00, [byte]0x20^) + $pk
echo $exts += @([byte]0x00, [byte]0x15, [byte]0x00, [byte]0x80^) + (New-Object Byte[] 128^)
echo.
echo # Сборка итогового пакета
echo [byte[]]$full_body = $body + @([byte][math]::Truncate($exts.Length/256^), [byte]($exts.Length %% 256^)^) + $exts
echo [byte[]]$handshake = @([byte]0x01, [byte]0x00, [byte][math]::Truncate($full_body.Length/256^), [byte]($full_body.Length %% 256^)^) + $full_body
echo [byte[]]$tls_packet = @([byte]0x16, [byte]0x03, [byte]0x01, [byte][math]::Truncate($handshake.Length/256^), [byte]($handshake.Length %% 256^)^) + $handshake
echo [System.IO.File]::WriteAllBytes($path, $tls_packet^)
) > "%PS_TEMP_SCRIPT%"

echo %E%[33m[2/3] Выполнение команд PowerShell...%E%[0m
powershell -NoProfile -ExecutionPolicy Bypass -File ".\%PS_TEMP_SCRIPT%"

echo %E%[33m[3/3] Проверка результата...%E%[0m
if exist "%OUT_FILE%" (
    for %%I in ("%OUT_FILE%") do set "fsize=%%~zI"
    echo.
    echo %E%[32m[УСПЕХ] Файл %OUT_FILE% успешно создан!%E%[0m
    echo %E%[36m[i] Домен внутри: %USER_DOMAIN%%E%[0m
    echo %E%[36m[i] Размер файла: !fsize! байт.%E%[0m
    echo %E%[36m[i] Файл лежит в папке под именем tls_clienthello_max_ru.bin%E%[0m
    echo %E%[36m[i] Его нужно закинуть в \bin c заменой, если есть старый файл%E%[0m
    echo %E%[36m[i] Можете использовать другие сайты главное найти нормальный%E%[0m
) else (
    echo.
    echo %E%[31m[ОШИБКА] Файл не был создан.%E%[0m
    echo %E%[31mПопробуйте запустить батник от имени администратора.%E%[0m
)

:: Чистим временный скрипт
if exist "%PS_TEMP_SCRIPT%" del /f /q "%PS_TEMP_SCRIPT%"

echo.
pause