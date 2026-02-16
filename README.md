# 🛡️ ZAPRET Advanced Bypass Toolkit

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/ArtworkPunk/Zapret-Toolkit?style=for-the-badge&color=yellow)
![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-informational?style=for-the-badge)
![Status](https://img.shields.io/badge/DPI_Bypass-Active-success?style=for-the-badge)

**Инженерное решение для обхода ТСПУ, DPI-фильтрации и восстановления доступа к заблокированным ресурсам**

[🔍 Web Checker (DPI/TCP Analyzer)](https://artworkpunk.github.io/Zapret-Toolkit-Checker/) | [📦 Latest Release](https://github.com/ArtworkPunk/Zapret-Toolkit/releases)

---

[🇷🇺 Русская версия](#-русская-версия) | [🇺🇸 English Version](#-english-version)

</div>

---

# 🇷🇺 Русская версия

## 🛠 Описание работы
**Zapret Toolkit** — это мощная надстройка над ядром `winws.exe`, разработанная специально для обхода продвинутых методов цензуры (ТСПУ). Программа перехватывает сетевые пакеты на уровне драйвера и модифицирует их таким образом, чтобы системы глубокого анализа трафика (DPI) не могли распознать целевой домен.

### 🚀 Ключевые технологии обхода
*   **Binary Handshake Spoofing**: Использование уникальных слепков `tls_clienthello_max_ru.bin`, которые имитируют обращение к легитимным российским ресурсам (Госуслуги, Ростелеком).
*   **IP-ID Zeroing**: Обнуление идентификаторов пакетов для предотвращения отслеживания сессии системами фильтрации.
*   **Multi-Strategy Filtering**: Разделение трафика на потоки (YouTube, Discord, Games) с применением индивидуальных параметров десинхронизации для каждого.
*   **UDP QUIC Bypass**: Маскировка протокола HTTP/3 для мгновенной прогрузки видео в 4K и 8K.

---

## 🎯 Поддержка сервисов

| Ресурс | Статус | Технология |
|:---:|:---|:---:|
| 📺 | **YouTube / Music** | Full 4K/8K Bypass via Max-Dump |
| 💬 | **Discord (Full)** | Voice RTC Fix + Screenshare + Avatar Load |
| 🎮 | **Gaming Online** | Apex Legends, Warzone, Arena Breakout (Low Ping) |
| 🌐 | **Global Web** | Instagram, Facebook, Twitter, Telegram |

---

## 📂 Структура и профили

*   **`service.bat`** — Центральный менеджер. Позволяет устанавливать обход как системную службу, менять DNS и обходить блокировки по IP через HOSTS.
*   **`MaxFuckYouDolbaeb.bat`** — Основной «боевой» скрипт. Содержит 16 уровней фильтрации для максимальной проходимости.
*   **`DUMP_GEN_PRO.bat`** — Генератор ваших собственных уникальных дампов. Если стандартные методы «палятся» провайдером, создайте свой личный бинарник за 1 секунду.
*   **`lists/`** — Папка со списками. 
    *   `list-universal.txt` — добавьте сюда домен, если он не открывается.
    *   `list-exclude.txt` — добавьте сюда сайт/домен, если он тормозит (Сайт/Домен не заблокирован в рф).

---

## 🚀 Инструкция по запуску

1.  **Скачивание**: Распакуйте архив в папку без пробелов в пути.
2.  **Исключения**: Добавьте папку в **исключения Антивируса** и Защитника Windows. (Если mL (Machine learning) начнет ругатся, в других случаях можно ничего не делать)
3.  **Установка**: Запустите `service.bat` от админа и установите через [ 1 ] MaxFuckYouDolbaeb.bat.
4.  **Проверка**: Откройте наш [Web Checker](https://artworkpunk.github.io/Zapret-Toolkit-Checker/) для подтверждения статуса "Not detected".

---

---

## ❓ ЧАСТО задаваемые вопросы

**Вопрос: Почему мой антивирус помечает toolkit?**

**Ответ: Это Ложный срабатывающий сигнал. toolkit использует драйвер Windivert'а для перехвата пакетов на уровне ядра, что вызывает эвристические предупреждения mL (Machine learning).  Он безопасен в использовании.**

**Вопрос: Discord voice не подключается.**

**Ответ: Переключите сервер/голосовой-чат на Роттердам.**

---

# 🇺🇸 English Version (auto translate)

## 🛠 Overview
**Zapret Toolkit** is a professional-grade Windows utility designed to bypass Deep Packet Inspection (DPI) and state-level internet censorship. It utilizes the `winws.exe` engine and `WinDivert` driver to manipulate network packets in real-time.

### 🚀 Key Features
*   **Custom TLS Handshakes**: Spoof your traffic using binary dumps that mimic non-blocked, trusted domains.
*   **TCP/UDP Desynchronization**: Advanced `fake`, `split`, and `disorder` strategies to confuse DPI sniffers.
*   **Game-Ready Latency**: Specifically tuned for low-ping performance in competitive shooters and MMOs.
*   **Auto-TTL Discovery**: Automatically adapts to your ISP's network topology to find the optimal bypass distance.

---

## 📊 Connection Status

*   **Social Media**: Instagram, Facebook, X (Twitter) — **RESTORED**
*   **Streaming**: YouTube 4K/8K, Twitch, SoundCloud — **RESTORED**
*   **Communication**: Discord (Voice/Video), Telegram — **RESTORED**
*   **Development**: GitHub, Docker, NPM, OpenAI — **RESTORED**

---

## 📂 Toolkit Components

*   **`service.bat`**: The command center for service installation, DNS management, and manual IP mapping.
*   **`DUMP_GEN_PRO.bat`**: Create your own unique bypass signatures to stay ahead of DPI updates.
*   **`MaxFuckYouDolbaeb.bat`**: The flagship high-power bypass profile for Russian ISPs (Rostelecom, MGTS, etc.).

---

## ❓ FAQ

**Q: Why does my antivirus flag the toolkit?**  
**A:** This is a **False Positive**. The toolkit uses the `WinDivert` driver to intercept packets at the kernel level, which triggers heuristic warnings. It is safe to use.

**Q: Discord voice is not connecting.**  
**A:** Switch the server/voice chat to Rotterdam.

---

<div align="center">

**Developed Toolkit by Artworkpunk**

**Developed Zapret by bol-van**

</div>
