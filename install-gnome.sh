#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "[*] Setting up GNOME extensions..."

# Install dependencies (Arch Linux)
if ! command -v gnome-tweaks &> /dev/null || ! command -v dconf &> /dev/null; then
  echo "[*] Installing gnome-shell-extensions, gnome-tweaks, and dconf..."
  sudo pacman -Syu --noconfirm
  sudo pacman -S --needed gnome-shell-extensions gnome-tweaks dconf
fi

if [ ! -d "$DOTFILES/extensions" ]; then
  echo "[!] Folder extensions tidak ditemukan di $DOTFILES/extensions. Pastikan sudah clone repo."
  exit 1
fi
if [ ! -f "$DOTFILES/extensions/extensions-settings.ini" ]; then
  echo "[!] File extensions-settings.ini tidak ditemukan di $DOTFILES/extensions."
  exit 1
fi

# Copy folder extensions
mkdir -p ~/.local/share/gnome-shell/extensions
cp -r "$DOTFILES/extensions/"* ~/.local/share/gnome-shell/extensions/

# Load settings from dconf
dconf load /org/gnome/shell/extensions/ < "$DOTFILES/extensions/extensions-settings.ini"

# Restart GNOME Shell
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  echo "[*] Wayland detected. Please log out and log back in to apply GNOME Shell changes."
else
  gnome-shell --replace &
  echo "[*] GNOME Shell restarted."
fi

echo "[✓] GNOME extensions files and settings installed!"
echo "[*] Enable extensions manually via gnome-tweaks or https://extensions.gnome.org/local/"
echo "[*] See README.md for list of extensions."
echo "[*] If issues occur, run 'bash -x ./install-gnome.sh' and check output."
