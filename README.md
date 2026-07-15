# 🛡️ ZAPRET Advanced Bypass Toolkit

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/ArtworkPunk/Zapret-Toolkit?style=for-the-badge&color=yellow)
![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-informational?style=for-the-badge)
![Status](https://img.shields.io/badge/DPI_Bypass-Active-success?style=for-the-badge)

**Инженерное решение для настройки сетевых пакетов, десинхронизации DPI и оптимизации TCP/UDP соединений (включая ускорение YouTube и Discord**

[🔍 Web Checker (DPI/TCP Analyzer)](https://artworkpunk.github.io/Zapret-Toolkit-Checker/) | [📦 Latest Release](https://github.com/ArtworkPunk/Zapret-Toolkit/releases)


[🇷🇺 Русская версия](#-русская-версия) | [🇺🇸 English Version](#-english-version)

</div>

---

# 🇷🇺 Русская версия

## 🛠 Описание работы
**Zapret Toolkit** — это мощная надстройка над ядром `winws.exe`, разработанная специально для обхода продвинутых методов цензуры (ТСПУ). Программа перехватывает сетевые пакеты на уровне драйвера и модифицирует их таким образом, чтобы системы глубокого анализа трафика (DPI) не могли распознать целевой домен.

### ✨ Ключевые возможности
* 🛡️ Многоуровневая защита: Комбинация десятков стратегий обхода DPI, которые работают там, где другие бессильны.

* 🌐 Полный охват: Возвращает доступ к YouTube 4K/8K, Discord (включая голосовые каналы), игровым серверам (Apex, Warzone) и соцсетям.

* ⚡ Максимальная скорость: Минимальное влияние на пинг благодаря точной настройке и использованию технологии UDP QUIC Bypass.

* 🔧 Гибкость настройки: Легко добавляйте свои домены для обхода или в исключения через текстовые файлы в папке lists/.

* 💡 Автономный генератор дампов: Утилита DUMP_GEN_PRO.bat создает ваши уникальные цифровые отпечатки, делая обход незаметным для провайдера.

---

## 🎯 Поддержка сервисов

| Категория | Сервисы | Статус |
|:---:|:---|:---:|
| 📺 | **YouTube / Music** | Full 4K/8K Bypass via Max-Dump |
| 💬 | **Discord (Full)** | Voice RTC Fix + Screenshare + Avatar Load |
| 🎮 | **Gaming Online** | Apex Legends, Warzone, Arena Breakout, ARC Raiders, Fornite, Overwatch, Roblox |
| 🌐 | **Global Web** | Instagram, Facebook, Twitter, Telegram |

> Примечание: Для наилучшей работы Discord Voice рекомендуется в настройках приложения выбрать сервер Роттердам.
---

## 📂 Структура и профили

*   **`service.bat`** — Центральный менеджер. Позволяет устанавливать обход как системную службу, менять DNS и обходить блокировки по IP через HOSTS.
*   **`MaxFuckYouDolbaeb.bat`** — Основной «боевой» скрипт. Содержит 16 уровней фильтрации для максимальной проходимости.
*   **`DUMP_GEN_PRO.bat`** — Генератор ваших собственных уникальных дампов. Если стандартные сайты «палятся» провайдером, создайте свой личный бинарник за 1 секунду.
*   **`lists/`** — Папка со списками. 
    *   `list-universal.txt` — добавьте сюда домен, если он не открывается.
    *   `list-exclude.txt` — добавьте сюда сайт/домен, если он тормозит (Сайт/Домен не заблокирован в рф).

---

## 🚀 Инструкция по запуску

1.  **Скачивание**: Распакуйте архив в папку без пробелов в пути.
2.  **Исключения**: Добавьте папку в **исключения Антивируса** и Защитника Windows. (Если mL (Machine learning) начнет ругатся, в других случаях можно ничего не делать)
3.  **Установка**: Запустите `service.bat` от админа и установите через [ 1 ] MaxFuckYouDolbaeb.bat.
4.  **Проверка**: Откройте [Web Checker](https://artworkpunk.github.io/Zapret-Toolkit-Checker/) для подтверждения статуса "Not detected".

---

## ❓ ЧАСТО задаваемые вопросы

**Вопрос: Discord voice не подключается.**

**Ответ: Переключите сервер/голосовой-чат на Роттердам.**

**Вопрос: Половину сайтов грузит вторая половина выдает DNS_PROBE_FINISHED_NXDOMAIN.**

**Ответ: Переключите DNS сервер на любой другой кроме тех кто находится в России, работают хорошо google (8.8.8.8), 9quad (9.9.9.9).**

---

# 🇺🇸 English Version

## 🛠 Job description
**Zapret Toolkit** is a powerful add—on to the core `winws.exe `, designed specifically to circumvent Advanced Censorship Techniques (TSP). The program intercepts network packets at the driver level and modifies them so that deep traffic analysis (DPI) systems cannot recognize the target domain.

### ✨ Key features
* Multi-level protection: A combination of dozens of DPI bypass strategies that work where others are powerless.

* 🌐 Full Coverage: Returns access to YouTube 4K/8K, Discord (including voice channels), game servers (Apex, Warzone), and social media.

* Maximum speed: Minimal ping impact due to fine tuning and the use of UDP QUIC Bypass technology.

* Flexible settings: Easily add your domains for crawling or exclusion via text files in the lists/ folder.

 Offline dump generator: DUMP_GEN_PRO utility.bat creates your unique digital fingerprints, making the bypass invisible to the provider.

---

## 🎯 Service support

| Category | Services | Status |
|:---:|:---|:---:|
| 📺 | **YouTube / Music** | Full 4K/8K Bypass via Max-Dump |
| 💬 | **Discord (Full)** | Voice RTC Fix + Screenshare + Avatar Load |
| 🎮 | **Gaming Online** | Apex Legends, Warzone, Arena Breakout, ARC Raiders, Fornite, Overwatch, Roblox |
| 🌐 | **Global Web** | Instagram, Facebook, Twitter, Telegram |

> Note: For the best performance of Discord Voice, it is recommended to select the Rotterdam server in the application settings.
---

## 📂 Структура и профили

*   **`service.bat`** is the Central Manager. Allows you to set up a bypass as a system service, change DNS, and bypass IP blockages through HOSTS.
*   **`MaxFuckYouDolbaeb.bat`** is the main "combat" script. It contains 16 filtration levels for maximum throughput.
*   **`DUMP_GEN_PRO.bat`** is a generator of your own unique dumps. If the standard sites are "burned" by the provider, create your own personal binary in 1 second.
* **`lists/`** is a folder with lists. 
    * `list-universal.txt ` — add the domain here if it doesn't open.
    * `list-exclude.txt ` — add the site/domain here if it slows down (the site/Domain is not blocked in the Russian Federation).

---

## 🚀 Launch Instructions

1. **Download**: Unzip the archive to a folder without spaces in the path.
2. **Exceptions**: Add the folder to the **Antivirus** and Windows Defender exceptions. (If mL (Machine learning) starts swearing, in other cases you can do nothing)
3. **Installation**: Run `service.bat` from the admin and install via [ 1 ] MaxFuckYouDolbaeb.bat.
4. **Verification**: Open [Web Checker](https://artworkpunk.github.io/Zapret-Toolkit-Checker/) to confirm the "Not detected" status.

---

<div align="center";>

**Developed Toolkit by Artworkpunk**

**Developed Zapret by bol-van**

</div>
