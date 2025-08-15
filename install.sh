#!/bin/bash
# Erweitertes Skript, um Abhängigkeiten, Konfigurationen und Wallpaper zu installieren.

# Stoppt das Skript sofort, wenn ein Befehl fehlschlägt
set -e

# --- PAKETLISTEN (Hier anpassen) ---
# Definiere hier alle benötigten Pakete für die jeweiligen Paketmanager.

# Für Arch Linux (pacman)
PACMAN_PACKAGES="hyprland hyprpaper waybar rofi-wayland alacritty thunar firefox swaylock dunst polkit-kde-agent grim slurp ttf-noto-nerd"
# AUR-Pakete (benötigen einen AUR-Helper wie yay oder paru)
AUR_PACKAGES="visual-studio-code-bin"

# Für Debian/Ubuntu (apt) - VORLAGE, Namen und Repositories können abweichen!
APT_PACKAGES="hyprland hyprpaper waybar rofi alacritty thunar firefox swaylock dunst polkit-kde-agent-1 grim slurp fonts-noto-color-emoji"

# Für Fedora (dnf) - VORLAGE, Namen und Repositories können abweichen!
DNF_PACKAGES="hyprland hyprpaper waybar rofi alacritty thunar firefox swaylock dunst polkit-kde grim slurp"


# --- FUNKTION ZUM INSTALLIEREN DER ABHÄNGIGKEITEN ---
install_dependencies() {
    echo "-> Suche nach Paketmanager und installiere Abhängigkeiten..."

    if command -v pacman &> /dev/null; then
        echo "--> Arch Linux erkannt. Installiere mit pacman..."
        sudo pacman -Syu --noconfirm --needed $PACMAN_PACKAGES

        # Prüfen, ob ein AUR-Helper installiert ist und AUR-Pakete installieren
        if command -v yay &> /dev/null; then
            yay -S --noconfirm --needed $AUR_PACKAGES
        elif command -v paru &> /dev/null; then
            paru -S --noconfirm --needed $AUR_PACKAGES
        else
            echo "--> Warnung: Kein AUR-Helper (yay/paru) gefunden. Bitte installiere $AUR_PACKAGES manuell."
        fi

    elif command -v apt &> /dev/null; then
        echo "--> Debian/Ubuntu erkannt. Installiere mit apt..."
        echo "!!! WICHTIG: Stelle sicher, dass du externe Repositories (z.B. für Hyprland) hinzugefügt hast!"
        sudo apt update
        sudo apt install -y $APT_PACKAGES

    elif command -v dnf &> /dev/null; then
        echo "--> Fedora erkannt. Installiere mit dnf..."
        echo "!!! WICHTIG: Stelle sicher, dass du externe Repositories (z.B. COPR für Hyprland) aktiviert hast!"
        sudo dnf install -y $DNF_PACKAGES
        
    else
        echo "--> Warnung: Konnte keinen unterstützten Paketmanager (pacman, apt, dnf) finden."
        echo "!!! Bitte installiere die benötigten Pakete manuell."
    fi
}


# --- VARIABLEN ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
CONFIG_SOURCE_DIR="$SCRIPT_DIR/.config"
WALLPAPER_SOURCE_DIR="$SCRIPT_DIR/wallpapers"
CONFIG_DEST_DIR="$HOME/.config"
WALLPAPER_DEST_DIR="$HOME/Pictures"


# --- START DES SKRIPTS ---
echo "🚀 Starte die Konfiguration deines Systems..."

# 1. Abhängigkeiten installieren
# ------------------------------
# install_dependencies

# 2. Konfigurationsdateien kopieren
# ---------------------------------
if [ -d "$CONFIG_SOURCE_DIR" ]; then
    echo "-> Kopiere Konfigurationsdateien nach $CONFIG_DEST_DIR..."
    cp -rv "$CONFIG_SOURCE_DIR"/* "$CONFIG_DEST_DIR/"
else
    echo "-> Warnung: Konfigurationsverzeichnis './config' nicht gefunden. Überspringe."
fi

# 3. Wallpapers kopieren
# ----------------------
if [ -d "$WALLPAPER_SOURCE_DIR" ]; then
    echo "-> Kopiere Wallpaper nach $WALLPAPER_DEST_DIR..."
    mkdir -p "$WALLPAPER_DEST_DIR"
    cp -rv "$WALLPAPER_SOURCE_DIR"/* "$WALLPAPER_DEST_DIR/"
else
    echo "-> Warnung: Wallpaper-Verzeichnis './wallpapers' nicht gefunden. Überspringe."
fi

echo ""
echo "✅ Installation abgeschlossen! System neu starten oder neu anmelden, um alle Änderungen zu übernehmen. ✨"
