import sys
import os
import subprocess

# --- АВТО-УСТАНОВКА БИБЛИОТЕК ---
def install_requirements():
    required = {"customtkinter", "pystray", "pillow"}
    try:
        import pkg_resources
        installed = {pkg.key for pkg in pkg_resources.working_set}
        missing = required - installed
        if missing:
            print("Установка необходимых компонентов...")
            subprocess.check_call([sys.executable, "-m", "pip", "install", *missing], 
                                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            # Перезапускаем скрипт после установки
            os.execl(sys.executable, sys.executable, *sys.argv)
    except Exception as e:
        print(f"Ошибка проверки зависимостей: {e}")

install_requirements()
# --------------------------------

import socket
import threading
import struct
import winreg
import ctypes
import time
import json
import urllib.request

# Скрываем черную консоль (останется только GUI)
kernel32 = ctypes.windll.kernel32
user32 = ctypes.windll.user32
hwnd = kernel32.GetConsoleWindow()
if hwnd: user32.ShowWindow(hwnd, 0)

import customtkinter as ctk
from PIL import Image, ImageDraw
import pystray

LISTEN_HOST = '127.0.0.1'
LISTEN_PORT = 1080
DNS_CACHE = {}

def is_admin():
    try: return ctypes.windll.shell32.IsUserAnAdmin()
    except: return False

def set_system_proxy(enable: bool):
    try:
        key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, r"Software\Microsoft\Windows\CurrentVersion\Internet Settings", 0, winreg.KEY_WRITE)
        if enable:
            winreg.SetValueEx(key, "ProxyEnable", 0, winreg.REG_DWORD, 1)
            winreg.SetValueEx(key, "ProxyServer", 0, winreg.REG_SZ, f"{LISTEN_HOST}:{LISTEN_PORT}")
            # Исключения для YouTube и Google (идут напрямую в Zapret)
            bypass = "localhost;127.*;192.168.*;<local>;*.youtube.com;*.googlevideo.com;*.ytimg.com;*.ggpht.com;*.google.com"
            winreg.SetValueEx(key, "ProxyOverride", 0, winreg.REG_SZ, bypass)
        else:
            winreg.SetValueEx(key, "ProxyEnable", 0, winreg.REG_DWORD, 0)
        winreg.CloseKey(key)
        ctypes.windll.wininet.InternetSetOptionW(0, 39, 0, 0)
        ctypes.windll.wininet.InternetSetOptionW(0, 37, 0, 0)
    except: pass

def resolve_doh(domain):
    if not domain or domain.replace('.', '').isdigit(): return domain
    if domain in DNS_CACHE: return DNS_CACHE[domain]
    try:
        url = f"https://8.8.8.8/resolve?name={domain}&type=A"
        req = urllib.request.Request(url, headers={'Accept': 'application/dns-json'})
        req.set_proxy('', 'http')
        req.set_proxy('', 'https')
        with urllib.request.urlopen(req, timeout=1.5) as resp:
            data = json.loads(resp.read().decode())
            if "Answer" in data:
                ip = data["Answer"][0]["data"]
                DNS_CACHE[domain] = ip
                return ip
    except: pass
    
    try:
        ip = socket.gethostbyname(domain)
        DNS_CACHE[domain] = ip
        return ip
    except: return domain

def stream_relay(src, dst, is_telegram=False):
    """ Идеально стабильный потоковый мост """
    try:
        while True:
            chunk_size = 4096 if is_telegram else 32768
            data = src.recv(chunk_size)
            if not data: break
            dst.sendall(data)
    except: pass
    finally:
        try: src.close()
        except: pass
        try: dst.close()
        except: pass

def handle_client(client_sock, ui_logger):
    remote_sock = None
    try:
        first_byte = client_sock.recv(1)
        if not first_byte: return

        host, port, is_socks = "", 0, False

        # --- SOCKS5 (Telegram) ---
        if first_byte == b'\x05':
            nmethods = ord(client_sock.recv(1))
            client_sock.recv(nmethods)
            client_sock.sendall(b'\x05\x00')
            
            req = client_sock.recv(4)
            if len(req) < 4: return
            atyp = req[3]
            
            if atyp == 1: host = socket.inet_ntoa(client_sock.recv(4))
            elif atyp == 3: host = client_sock.recv(ord(client_sock.recv(1))).decode()
            elif atyp == 4: 
                client_sock.recv(16)
                host = "149.154.167.50" # Fallback
            
            port = struct.unpack('>H', client_sock.recv(2))[0]
            is_socks = True

        # --- HTTP CONNECT (Браузеры) ---
        elif first_byte == b'C':
            raw = client_sock.recv(1024).decode(errors='ignore')
            target = ("C" + raw).split('\r\n')[0].split(' ')[1]
            host, port = target.split(':') if ':' in target else (target, 80)
            port = int(port)
        else:
            client_sock.close(); return

        real_ip = resolve_doh(host)

        remote_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        remote_sock.settimeout(5.0)
        remote_sock.connect((real_ip, port))
        remote_sock.settimeout(None)
        
        remote_sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        client_sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)

        if is_socks:
            client_sock.sendall(b'\x05\x00\x00\x01\x00\x00\x00\x00\x00\x00')
        else:
            client_sock.sendall(b'HTTP/1.1 200 Connection Established\r\n\r\n')

        ui_logger(f"Туннель: {host} -> {real_ip}:{port}")

        is_tg = any(x in host or x in real_ip for x in["91.108.", "149.154.", "telegram", "tg."])

        t = threading.Thread(target=stream_relay, args=(client_sock, remote_sock, is_tg), daemon=True)
        t.start()
        stream_relay(remote_sock, client_sock, False)

    except Exception:
        pass
    finally:
        try: client_sock.close()
        except: pass
        if remote_sock:
            try: remote_sock.close()
            except: pass

class ProxyApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Zapret LocalProxy")
        self.geometry("650x420")
        self.resizable(False, False)
        
        # Красивая темная тема
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")
        
        self.protocol("WM_DELETE_WINDOW", self.hide_to_tray)

        self.running = False
        self.server = None

        self.grid_columnconfigure(1, weight=1)
        self.grid_rowconfigure(0, weight=1)

        # Боковая панель
        self.sidebar = ctk.CTkFrame(self, width=200, corner_radius=0, fg_color="#18181b")
        self.sidebar.grid(row=0, column=0, sticky="nsew")

        # Логотип
        self.logo = ctk.CTkLabel(self.sidebar, text="ZAPRET\nLocalProxy", 
                                 font=ctk.CTkFont(family="Segoe UI", size=22, weight="bold"), text_color="#00ffcc")
        self.logo.pack(pady=35)

        self.btn_power = ctk.CTkButton(self.sidebar, text="▶ ВКЛЮЧИТЬ", 
                                       font=ctk.CTkFont(size=14, weight="bold"),
                                       fg_color="#2ea043", hover_color="#238636", command=self.toggle_power)
        self.btn_power.pack(pady=10, padx=20, fill="x")

        self.btn_tg = ctk.CTkButton(self.sidebar, text="Telegram Auto-Set", 
                                    font=ctk.CTkFont(size=12),
                                    fg_color="#1f6feb", hover_color="#1158c7", command=self.auto_telegram)
        self.btn_tg.pack(pady=10, padx=20, fill="x")

        self.status_lbl = ctk.CTkLabel(self.sidebar, text="● Выключен", text_color="#8b949e", font=ctk.CTkFont(weight="bold"))
        self.status_lbl.pack(side="bottom", pady=20)

        # Основная панель
        self.main_frame = ctk.CTkFrame(self, corner_radius=10, fg_color="#0d1117")
        self.main_frame.grid(row=0, column=1, padx=15, pady=15, sticky="nsew")

        self.log_switch = ctk.CTkSwitch(self.main_frame, text="Логи трафика (DoH)", progress_color="#00ffcc")
        self.log_switch.pack(pady=10, padx=15, anchor="w")
        self.log_switch.select()

        # Красивое текстовое поле
        self.textbox = ctk.CTkTextbox(self.main_frame, font=("Cascadia Code", 11), 
                                      fg_color="#010409", text_color="#00ff00", border_color="#30363d", border_width=1)
        self.textbox.pack(fill="both", expand=True, padx=15, pady=15)
        self.textbox.bind("<Key>", lambda e: None if (e.state & 4 and e.keysym.lower() == 'c') or e.keysym in ("Up", "Down", "Left", "Right") else "break")

        self.log("Система готова. Zapret (winws.exe) должен быть запущен параллельно.")

    def log(self, message):
        if not self.log_switch.get() and "ВКЛЮЧИТЬ" not in message: return
        self.textbox.insert("end", f"[{time.strftime('%H:%M:%S')}] {message}\n")
        self.textbox.see("end")

    def auto_telegram(self):
        if not self.running:
            self.log("Сначала запустите прокси (кнопка ВКЛЮЧИТЬ)!")
            return
        os.startfile(f"tg://socks?server={LISTEN_HOST}&port={LISTEN_PORT}")
        self.log("Настройки отправлены в клиент Telegram.")

    def accept_clients(self):
        while self.running:
            try:
                c, a = self.server.accept()
                threading.Thread(target=handle_client, args=(c, self.log), daemon=True).start()
            except: break

    def toggle_power(self):
        if not self.running:
            self.running = True
            self.btn_power.configure(text="■ ОСТАНОВИТЬ", fg_color="#da3633", hover_color="#b62324")
            self.status_lbl.configure(text="● АКТИВЕН", text_color="#3fb950")
            set_system_proxy(True)
            self.log(f"Запуск защищенного моста на {LISTEN_HOST}:{LISTEN_PORT}...")
            
            self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            self.server.bind((LISTEN_HOST, LISTEN_PORT))
            self.server.listen(1024)
            
            threading.Thread(target=self.accept_clients, daemon=True).start()
        else:
            self.running = False
            self.btn_power.configure(text="▶ ВКЛЮЧИТЬ", fg_color="#2ea043", hover_color="#238636")
            self.status_lbl.configure(text="● Выключен", text_color="#8b949e")
            set_system_proxy(False)
            if self.server:
                try: self.server.close()
                except: pass
            self.log("Мост остановлен.")

    def hide_to_tray(self):
        self.withdraw()
        # Рисуем красивую иконку для трея "на лету"
        img = Image.new('RGB', (64, 64), (13, 17, 23))
        d = ImageDraw.Draw(img)
        d.ellipse([10, 10, 54, 54], fill=(0, 255, 204), outline=(48, 54, 61), width=4)
        
        menu = pystray.Menu(
            pystray.MenuItem('Показать окно', self.show_app),
            pystray.MenuItem('Закрыть', self.exit_app)
        )
        self.icon = pystray.Icon("zapret", img, "Zapret LocalProxy", menu)
        threading.Thread(target=self.icon.run, daemon=True).start()

    def show_app(self, icon):
        icon.stop()
        self.after(0, self.deiconify)

    def exit_app(self, icon):
        icon.stop()
        set_system_proxy(False)
        os._exit(0)

if __name__ == '__main__':
    if not is_admin():
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, f'"{os.path.abspath(__file__)}"', None, 1)
        sys.exit()
    app = ProxyApp()
    app.mainloop()