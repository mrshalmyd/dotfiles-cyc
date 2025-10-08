
<h1 align="center">🌌 Dotfiles: Wallpaper Symphony 🌌</h1>

<p align="center">
  <em>A minimalist canvas for your GNOME desktop, where wallpapers dance in cycles and icon themes hum in harmony.<br>
  Transform your screen with a single keystroke. 🎨✨</em>
</p>

<p align="center">
  <a href="https://github.com/mrshalmyd/dotfiles-cyc/stargazers">
    <img src="https://img.shields.io/github/stars/mrshalmyd/dotfiles-cyc?color=9370DB&style=for-the-badge" alt="Stars"/>
  </a>
  <a href="https://github.com/mrshalmyd/dotfiles-cyc/issues">
    <img src="https://img.shields.io/github/issues/mrshalmyd/dotfiles-cyc?color=E6B422&style=for-the-badge" alt="Issues"/>
  </a>
  <a href="https://github.com/mrshalmyd/dotfiles-cyc/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/mrshalmyd/dotfiles-cyc?color=66CCFF&style=for-the-badge" alt="License"/>
  </a>
  <img src="https://img.shields.io/badge/Shell-100%25-2E8B57?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell"/>
</p>

---

## 🖼️ The Structure

Step into a harmonious atelier of visual artistry, where every folder weaves a thread of the symphony:

```
📁 dotfiles/
 ┣ 🎨 wallpapers/
 ┃ ┣ 🟥 red.jpg
 ┃ ┣ 🟪 purple.jpg
 ┃ ┣ 🟩 green.jpg
 ┃ ┗ 🟦 blue.jpg
 ┣ 🧩 icons/
 ┃ ┣ 🟪 purple/
 ┃ ┃ ┗ index.theme
 ┃ ┣ 🟥 red/
 ┃ ┃ ┗ index.theme
 ┃ ┣ 🟩 green/
 ┃ ┃ ┗ index.theme
 ┃ ┗ 🟦 blue/
 ┃   ┗ index.theme
 ┣ ⚙️ scripts/
 ┃ ┣ wallpaper-switch.sh
 ┃ ┗ themes-map.csv
 ┗ 📦 install.sh
```

A gallery of vibrant JPGs, icon theme palettes, and the magic scripts blend into a seamless masterpiece.

---

## 🎶 The Symphony

This dotfiles setup orchestrates a graceful performance of visuals and flow:

- **Cyclic Switching 🔄** — Glide through wallpapers (next/prev) from a CSV score, syncing icon themes.
- **Keybindings 🎹** — `<Super><Shift>n` for next, `<Super><Shift>p` for previous.
- **Fallback Grace 🛡️** — If GNOME stumbles, `feh` steps in. Icon woes? Adwaita’s got your back.
- **Extension Flourish 🌟** — Enhances select GNOME extensions with synchronized visuals.

### How it Flows

1. Reads your current wallpaper’s note.  
2. Finds the next/prev in the CSV melody.  
3. Paints the screen and syncs the icons.  

---

## 🌟 Supported Extensions

This setup harmonizes with GNOME extensions to elevate your desktop experience:

🎼 **Open Bar** — Seamlessly updates *bguri* and *dark-bguri* to match your wallpaper.  
🌫️ **Blur My Shell** — Softens your desktop’s edges with atmospheric blur, syncing to your wallpaper’s tone.  
🎨 **Just Perfection Desktop** — Conducts layouts and themes into synchronized grace.  

🎵 **Other Ensemble Members:**  
`lockscreen-extension`, `drive-menu`, `caffeine`, `bluetooth-quick-connect`,  
`quick-settings-tweaks`, `dash2dock-animated`, `tweaks-system-menu`,  
`netspeedsimplified`, `freon` — ready for future harmonies.

💡 *Got ideas for deeper extension sync? Contribute to the symphony!*

---

## 🛠️ Conjuring the Setup

Clone this repo to `$HOME/dotfiles` — your canvas awaits.

Then run:
```bash
./install.sh
```

Use your shortcuts:
```bash
<Super><Shift>n  # Next wallpaper
<Super><Shift>p  # Previous wallpaper
```

If the spell falters:
- Check paths in the scripts.
- Debug with `bash -x ./install.sh`.
- Remember: icon theme copying may require `sudo` (`/usr/share/icons/`).

---

## 📜 The `themes-map.csv` Scroll

A simple parchment mapping wallpapers to icon themes:

```csv
red.jpg,red
purple.jpg,purple
green.jpg,green
blue.jpg,blue
```

Add more lines to expand your palette! 🖌️

---

## 🌙 Notes in the Moonlight
 
- Ensure wallpapers and icons are valid and ready.  
- Want to add your own flair? *Pull requests welcome!* 🌈  

---

<p align="center">
  <em>Created with ✨ by <strong>[Marshal]</strong><br>
  A love letter to effortless desktop artistry.</em>
</p>

<p align="center">
  <sub>~ Let your screen sing with color and rhythm ~</sub>
</p>
