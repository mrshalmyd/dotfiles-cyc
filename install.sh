#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
SCRIPTS="$DOTFILES/scripts"
CSV="$SCRIPTS/themes-map.csv"

echo "[*] Setting up minimal dotfiles for wallpaper switching..."

# Pengecekan dependensi
if ! command -v gsettings &> /dev/null; then
  echo "[!] gsettings tidak ditemukan. Install gnome-settings-daemon dulu."
  echo "    Jalankan: sudo apt update && sudo apt install gnome-settings-daemon"
  exit 1
fi

# Pengecekan folder dan file
if [ ! -d "$DOTFILES" ]; then
  echo "[!] Folder dotfiles tidak ditemukan di $DOTFILES. Pastikan sudah clone repo."
  exit 1
fi
if [ ! -f "$CSV" ]; then
  echo "[!] File themes-map.csv tidak ditemukan di $SCRIPTS. Buat dulu!"
  exit 1
fi
if [ ! -d "$SCRIPTS" ] || [ ! -f "$SCRIPTS/wallpaper-switch.sh" ]; then
  echo "[!] Script wallpaper-switch.sh tidak ditemukan di $SCRIPTS."
  exit 1
fi
if [ ! -f "$DOTFILES/wallpapers/purple.jpg" ]; then
  echo "[!] Wallpaper purple.jpg tidak ditemukan di $DOTFILES/wallpapers."
  exit 1
fi
if [ ! -d "$DOTFILES/icons/purple" ] || [ ! -f "$DOTFILES/icons/purple/index.theme" ]; then
  echo "[!] Icon theme purple tidak ditemukan atau tidak valid di $DOTFILES/icons/purple."
  exit 1
fi

# Reset keybindings
if gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys 2>/dev/null; then
  echo "[*] Keybindings direset."
else
  echo "[!] Gagal reset keybindings."
fi

# Set custom keybindings untuk wallpaper-switch.sh
if gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-next/', \
    '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-prev/']" 2>/dev/null; then
  echo "[*] Custom keybindings diset."
else
  echo "[!] Gagal set custom keybindings."
fi

# Next wallpaper
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-next/ name 'Next Wallpaper' 2>/dev/null || echo "[!] Gagal set keybinding next."
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-next/ command "$SCRIPTS/wallpaper-switch.sh next" 2>/dev/null || echo "[!] Gagal set command next."
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-next/ binding '<Super><Shift>n' 2>/dev/null || echo "[!] Gagal set binding next."

# Prev wallpaper
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-prev/ name 'Prev Wallpaper' 2>/dev/null || echo "[!] Gagal set keybinding prev."
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-prev/ command "$SCRIPTS/wallpaper-switch.sh prev" 2>/dev/null || echo "[!] Gagal set command prev."
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wallpaper-prev/ binding '<Super><Shift>p' 2>/dev/null || echo "[!] Gagal set binding prev."

# Buat folder ~/.icons jika belum ada
mkdir -p ~/.icons

# Copy semua isi dari ~/dotfiles/icons ke ~/.icons
cp -r ~/dotfiles/icons/* ~/.icons/

echo "[✓] Ikon dari ~/dotfiles/icons sudah disalin ke ~/.icons/"
echo "[✓] Dotfiles setup selesai! Gunakan <Super><Shift>n untuk next wallpaper, <Super><Shift>p untuk prev."
echo "[*] Coba tes keybindings di Xorg."
echo "[*] Jika gagal, jalankan 'bash -x ./install.sh' dan share outputnya."
