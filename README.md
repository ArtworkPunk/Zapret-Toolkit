# 🛡️ ZAPRET Advanced Bypass Toolkit

<div align="center">
  
![GitHub stars](https://img.shields.io/github/stars/ArtworkPunk/zapret-toolkit?style=for-the-badge&color=yellow)
![GitHub forks](https://img.shields.io/github/forks/ArtworkPunk/zapret-toolkit?style=for-the-badge&color=blue)
![Platform](https://img.shields.io/badge/Platform-Windows%2010%2F11-informational?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)

**Ultimate solution for bypassing internet censorship and DPI blocking**

</div>

<div align="center">
  <img src="https://img.shields.io/badge/Russian-версия-red" alt="Russian">
  <img src="https://img.shields.io/badge/English-version-blue" alt="English">
</div>

---

## 📖 Содержание / Table of Contents
- [🇷🇺 Русская версия](#-русская-версия)
  - [✨ Возможности](#возможности)
  - [🎯 Что восстанавливает](#что-восстанавливает)
  - [🚀 Быстрый старт](#быстрый-старт)
  - [📁 Структура проекта](#структура-проекта)
  - [⚙️ Конфигурация](#конфигурация)
  - [🔧 Управление](#управление)
  - [❓ Частые вопросы](#частые-вопросы)
- [🇺🇸 English Version](#-english-version)
  - [✨ Features](#features)
  - [🎯 What It Restores](#what-it-restores)
  - [🚀 Quick Start](#quick-start)
  - [📁 Project Structure](#project-structure)
  - [⚙️ Configuration](#configuration)
  - [🔧 Management](#management)
  - [❓ FAQ](#faq)
---

# 🇷🇺 Русская версия

## ✨ Возможности

### 🛡️ **Многоуровневая защита**
- **Интеллектуальная DPI-фильтрация** с десинхронизацией
- **TLS/QUIC маскировка** для обхода глубокого анализа пакетов
- **Адаптивные алгоритмы** под разные типы блокировок

### 🌐 **Полная поддержка**
- **🎮 Игровые сервисы** (Discord, Steam, игровые лаунчеры)
- **📺 Медиаплатформы** (YouTube, Twitch, Spotify)
- **💬 Мессенджеры** (WhatsApp, Telegram)
- **🎨 Креативные платформы** (DeviantArt, ArtStation)
- **И еще 9+ миллионов хостов**

### ⚡ **Оптимизация**
- **Минимальная задержка** для игр и стриминга
- **Эффективное использование ресурсов** (~50-100 МБ ОЗУ)
- **Автоматическая диагностика** конфликтов

## 🎯 Что восстанавливает

<div align="center">

| Категория | Сервисы | Статус |
|-----------|---------|--------|
| 🎮 **Игры** | Roblox, Fortnite, Valorant, CS2, Dota 2, Arc Raiders | ✅ Работает |
| 📺 **Видео** | YouTube (Music/Shorts), Twitch, Netflix | ✅ Работает |
| 💬 **Чат** | Discord, WhatsApp, Telegram, Signal | ✅ Работает |
| 🎵 **Музыка** | Spotify (с аккаунтом), SoundCloud | ✅ Работает |
| 🎨 **Дизайн** | DeviantArt, ArtStation, Behance | ✅ Работает |
| ☁️ **Облака** | Google Drive, Dropbox, OneDrive | ✅ Работает |

</div>

> **✅ Проверка работоспособности**: После установки убедитесь через сервис [DPI Checker](https://hyperion-cs.github.io/dpi-checkers/ru/tcp-16-20/), что все сервера прошли проверку.

## 🚀 Быстрый старт

### 1. 📥 **Скачивание**
```
git clone https://github.com/yourusername/zapret-toolkit.git
cd zapret-toolkit
```

### 2. 🛠️ **Установка**
**Запустите сервисный менеджер (права администратора)**
```
service.bat
```

### 3. ⚙️ **Выбор режима**

```
Install Bypass Service 📥 / Установить как службу Windows
Remove Bypass Services 🗑️ / Удалить службы
Check Status 📊 / Проверить статус
Run Diagnostics 🔍 / Диагностика системы
Switch Game Filter 🎮 / Вкл/Выкл игровые порты
Switch IP Filter 🌐 / Вкл/Выкл IP-фильтрацию
```

**Рекомендуется**: Выберите **1** для установки как службы (автозапуск).

## 📁 Структура проекта

```
ZAPRET/
├── 📂 bin/ # Исполняемые файлы
│ ├── ⚙️ winws.exe # Основной движок обхода
│ ├── 🔒 tls_clienthello_max_ru.bin
│ └── 🚀 quic_initial_www_google_com.bin
│
├── 📂 lists/ # Конфигурационные списки
│ ├── ✅ list-exclude.txt # Whitelist (исключения)
│ ├── 🌍 list-universal.txt # Основные правила
│ ├── 🌎 list-foreign.txt # Зарубежные домены
│ ├── 🌎 list-general.txt # Все хосты и домены
│ ├── 🔍 list-google.txt # Google сервисы
│ ├── 💬 list-whatsapp.txt # WhatsApp
│ ├── 🎮 list-games.txt # Игры
│ ├── 📊 ipset-all.txt # IP-адреса
│ └── ⚠️ ipset-exclude.txt # IP-исключения
│
├── 🛠️ service.bat # Сервисный менеджер
└── ⚡ MaxFuckYouDolbaeb.bat # Основной скрипт
```

## ⚙️ Конфигурация

### 🔧 **Уровни фильтрации**
```
# Лайтовая фильтрация (.ru, .рф, .su)
--dpi-desync=fake --dpi-desync-repeats=1

# Полная фильтрация (.com, .net, .org)  
--dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts

# Игровые протоколы
--dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic
```

✅ Добавление исключений
Чтобы сайт работал без фильтрации, добавьте его в **lists/list-exclude.txt:**
```
your-site.com
*.your-site.com
subdomain.your-site.com
```

## 🎮 Игровые порты
Включено: 1024-65535 (полная фильтрация игр)

Выключено: только порт 12 (минимальная фильтрация)

## 🔧 Управление

**📊 Через графическое меню**
```
service.bat
```

**💻 Через командную строку**
```
# Статус службы
service.bat status_zapret

# Загрузка игровых фильтров
service.bat load_game_filter

# Установка как службы
service.bat install
```

**🖥️ Ручной запуск**
```
MaxFuckYouDolbaeb.bat
```

❓ Частые вопросы
<details> <summary><b>❓ ERR_CONNECTION_RESET на конкретном сайте</b></summary>
 
Добавьте сайт в lists/list-exclude.txt: (остановит фильтрацию для сайта)

problematic-site.com

*.problematic-site.com

problematic-site.ru

*.problematic-site.ru

После добавления перезапустите службу. (Если автоматически не применилось)

Добавьте сайт в lists/list-universal.txt: (добавит фильтрацию для сайта)

problematic-site.com

*.problematic-site.com

problematic-site.ru

*.problematic-site.ru

После добавления перезапустите службу. (Если автоматически не применилось)

</details><details> <summary><b>❓ Служба не запускается</b></summary>
 
Выполните полную переустановку:

service.bat → 2. Remove Bypass Services

service.bat → 1. Install Bypass Service

Если после переустановки не запускается, проверить антивирусник который установлен на пк.
</details><details> <summary><b>❓ Высокое потребление ресурсов</b></summary>
 
Нормальные показатели:

Память: ~50-100 МБ

CPU: <2% в простое

Сеть: нулевая задержка для исключений

Если выше — проверьте конфликты с антивирусом.

</details><details> <summary><b>❓ Как добавить новый сайт?</b></summary>
 
Добавьте домен в соответствующий файл:

Для любых сайтов — lists/list-universal.txt

Если служба работает то она автоматически подхватит новые данные после сохранения, если нет (не запускает) то выполнить переустановку через service.bat

</details>





---

# 🇺🇸 English Version

## ✨ Features

### 🛡️ **Multi-Layer Protection**
- **Intelligent DPI filtering** with desynchronization
- **TLS/QUIC masking** to bypass deep packet analysis
- **Adaptive algorithms** for different types of blocking

### 🌐 **Full Support**
- **🎮 Gaming Services** (Discord, Steam, game launchers)
- **📺 Media Platforms** (YouTube, Twitch, Spotify)
- **💬 Messengers** (WhatsApp, Telegram)
- **🎨 Creative Platforms** (DeviantArt, ArtStation)
- **And over 9+ million hosts**

### ⚡ **Optimization**
- **Minimal latency** for gaming and streaming
- **Efficient resource usage** (~50-100 MB RAM)
- **Automatic diagnostics** for conflicts

## 🎯 What It Restores

<div align="center">

| Category | Services | Status |
|----------|----------|--------|
| 🎮 **Games** | Roblox, Fortnite, Valorant, CS2, Dota 2, Arc Raiders | ✅ Working |
| 📺 **Video** | YouTube (Music/Shorts), Twitch, Netflix | ✅ Working |
| 💬 **Chat** | Discord, WhatsApp, Telegram, Signal | ✅ Working |
| 🎵 **Music** | Spotify (with account), SoundCloud | ✅ Working |
| 🎨 **Design** | DeviantArt, ArtStation, Behance | ✅ Working |
| ☁️ **Cloud** | Google Drive, Dropbox, OneDrive | ✅ Working |

</div>

> **✅ Performance Check**: After installation, verify with the [DPI Checker](https://hyperion-cs.github.io/dpi-checkers/en/tcp-16-20/) that all servers pass the test.

## 🚀 Quick Start

### 1. 📥 **Download**
```
git clone https://github.com/yourusername/zapret-toolkit.git
cd zapret-toolkit
```

### 2. 🛠️ **Installation**
**Run the service manager (administrator rights required)**
```
service.bat
```

### 3. ⚙️ **Select Mode**

```
Install Bypass Service 📥 / Install as Windows Service
Remove Bypass Services 🗑️ / Remove services
Check Status 📊 / Check status
Run Diagnostics 🔍 / System diagnostics
Switch Game Filter 🎮 / Toggle game ports
Switch IP Filter 🌐 / Toggle IP filtering
```

**Recommended**: Choose **1** to install as a service (auto-start).

## 📁 Project Structure

```
ZAPRET/
├── 📂 bin/ # Executable files
│ ├── ⚙️ winws.exe # Main bypass engine
│ ├── 🔒 tls_clienthello_max_ru.bin
│ └── 🚀 quic_initial_www_google_com.bin
│
├── 📂 lists/ # Configuration lists
│ ├── ✅ list-exclude.txt # Whitelist (exceptions)
│ ├── 🌍 list-universal.txt # Main rules
│ ├── 🌎 list-foreign.txt # Foreign domains
│ ├── 🌎 list-general.txt # All hosts and domains
│ ├── 🔍 list-google.txt # Google services
│ ├── 💬 list-whatsapp.txt # WhatsApp
│ ├── 🎮 list-games.txt # Games
│ ├── 📊 ipset-all.txt # IP addresses
│ └── ⚠️ ipset-exclude.txt # IP exceptions
│
├── 🛠️ service.bat # Service manager
└── ⚡ MaxFuckYouDolbaeb.bat # Main script
```

## ⚙️ Configuration

### 🔧 **Filter Levels**
```
Light filtering (.ru, .рф, .su)
--dpi-desync=fake --dpi-desync-repeats=1

Full filtering (.com, .net, .org)
--dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=ts

Gaming protocols
--dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic
```

### ✅ **Adding Exceptions**
To make a site work without filtering, add it to **lists/list-exclude.txt:**
```
your-site.com
*.your-site.com
subdomain.your-site.com
```

## 🎮 Game Ports
Enabled: 1024-65535 (full game filtering)

Disabled: only port 12 (minimal filtering)

## 🔧 Management

**📊 Via Graphical Menu**
```
service.bat
```

**💻 Via Command Line**
```
Service status
service.bat status_zapret

Load game filters
service.bat load_game_filter

Install as service
service.bat install
```

**🖥️ Manual Start**
```
MaxFuckYouDolbaeb.bat
```

❓ Frequently Asked Questions
<details> <summary><b>❓ ERR_CONNECTION_RESET on specific site</b></summary>
 
Add the site to lists/list-exclude.txt: (will stop filtering for the site)

problematic-site.com

*.problematic-site.com

problematic-site.ru

*.problematic-site.ru

After adding, restart the service. (If not applied automatically)

Add the site to lists/list-universal.txt: (will add filtering for the site)

problematic-site.com

*.problematic-site.com

problematic-site.ru

*.problematic-site.ru

After adding, restart the service. (If not applied automatically)

</details><details> <summary><b>❓ Service won't start</b></summary>
 
Perform a full reinstallation:

service.bat → 2. Remove Bypass Services

service.bat → 1. Install Bypass Service

If it still doesn't start after reinstallation, check the antivirus software installed on your PC.
</details><details> <summary><b>❓ High resource usage</b></summary>
 

Normal metrics:

- **Memory**: ~50-100 MB
- **CPU**: <2% idle
- **Network**: zero latency for exceptions

If higher — check for conflicts with antivirus.

</details><details> <summary><b>❓ How to add a new site?</b></summary>
 
Add the domain to the appropriate file:

- For any sites — lists/list-universal.txt

If the service is running, it will automatically pick up new data after saving. If not (won't start), perform a reinstallation via service.bat.

</details>
