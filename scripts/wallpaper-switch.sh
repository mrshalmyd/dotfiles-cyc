#!/bin/bash

DOTFILES="$HOME/dotfiles"
DIR="$DOTFILES/wallpapers"
ICONS="$DOTFILES/icons"
CSV="$DOTFILES/scripts/themes-map.csv"

# Pengecekan argumen
if [ "$#" -ne 1 ] || ([ "$1" != "next" ] && [ "$1" != "prev" ]); then
  echo "Usage: $0 next|prev"
  exit 1
fi

# Pengecekan folder dan file
if [ ! -d "$DIR" ]; then
  echo "[!] Folder wallpapers tidak ditemukan: $DIR"
  exit 1
fi
if [ ! -f "$CSV" ]; then
  echo "[!] File themes-map.csv tidak ditemukan: $CSV"
  exit 1
fi

# Cek current wallpaper
CURRENT=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/'//g")
if [ -z "$CURRENT" ]; then
  echo "[!] Gagal baca wallpaper saat ini."
  exit 1
fi

# Ambil daftar wallpaper dari themes-map.csv
mapfile -t WALLPAPERS < <(cut -d',' -f1 "$CSV")
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
  echo "[!] Tidak ada wallpaper di $CSV"
  exit 1
fi

# Cari wallpaper berikutnya/sebelumnya
TARGET=""
CURRENT_PATH=$(echo "$CURRENT" | sed 's|^file://||')
CURRENT_BASENAME=$(basename "$CURRENT_PATH")
for i in "${!WALLPAPERS[@]}"; do
  if [[ "$DIR/$CURRENT_BASENAME" == "$DIR/${WALLPAPERS[i]}" ]]; then
    if [ "$1" == "next" ]; then
      TARGET_INDEX=$(( (i + 1) % ${#WALLPAPERS[@]} ))
    else
      TARGET_INDEX=$(( (i - 1 + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))
    fi
    TARGET="$DIR/${WALLPAPERS[$TARGET_INDEX]}"
    break
  fi
done

# Fallback ke wallpaper pertama jika tidak ketemu
[ -z "$TARGET" ] && TARGET="$DIR/${WALLPAPERS[0]}"

# Set wallpaper
TARGET_PATH="file://$(realpath "$TARGET")"
if ! gsettings set org.gnome.desktop.background picture-uri "$TARGET_PATH" 2>/dev/null ||
   ! gsettings set org.gnome.desktop.background picture-uri-dark "$TARGET_PATH" 2>/dev/null; then
  echo "[!] Gagal set wallpaper via gsettings."
  if command -v feh &> /dev/null; then
    feh --bg-scale "$TARGET" && echo "[*] Wallpaper diset via feh."
  else
    echo "[!] feh tidak terinstall. Install: sudo apt install feh"
  fi
  exit 1
fi
echo "[*] Wallpaper set to: $TARGET"

# Update Open Bar bguri kalau aktif
if gnome-extensions list | grep -q "openbar@neuromorph"; then
  gsettings set org.gnome.shell.extensions.openbar bguri "$TARGET_PATH" 2>/dev/null &&
  gsettings set org.gnome.shell.extensions.openbar dark-bguri "$TARGET_PATH" 2>/dev/null ||
  echo "[!] Gagal update bguri Open Bar."
fi

# Set tema ikon
NAME=$(basename "$TARGET")
ICON=$(grep -E "^$NAME," "$CSV" | cut -d',' -f2 | head -n1)
if [ -n "$ICON" ] && [ -d "$ICONS/$ICON" ] && [ -f "$ICONS/$ICON/index.theme" ]; then
  sudo cp -r "$ICONS/$ICON" /usr/share/icons/ 2>/dev/null || {
    sudo rm -rf /usr/share/icons/$ICON 2>/dev/null
    sudo cp -r "$ICONS/$ICON" /usr/share/icons/ 2>/dev/null || {
      echo "[!] Gagal copy tema ikon $ICON."
      gsettings set org.gnome.desktop.interface icon-theme "Adwaita" 2>/dev/null || echo "[!] Gagal set Adwaita."
    }
  }
  if gsettings set org.gnome.desktop.interface icon-theme "$ICON" 2>/dev/null; then
    echo "[*] Icon theme diset: $ICON"
  else
    echo "[!] Gagal set icon theme: $ICON. Fallback ke Adwaita."
    gsettings set org.gnome.desktop.interface icon-theme "Adwaita" 2>/dev/null || echo "[!] Gagal set Adwaita."
  fi
else
  echo "[!] Icon theme tidak ditemukan untuk $NAME. Fallback ke Adwaita."
  gsettings set org.gnome.desktop.interface icon-theme "Adwaita" 2>/dev/null || echo "[!] Gagal set Adwaita."
fi
# Refresh extension Open Bar
gnome-extensions disable open-bar@domain.com
sleep 1
gnome-extensions enable open-bar@domain.com

