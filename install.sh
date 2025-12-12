#!/bin/bash
#
# shout installer
#

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

INSTALL_DIR="${HOME}/.local/bin"

echo "shout installer"
echo "==============="
echo

# Check dependencies
check_dep() {
    if command -v "$1" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1 - $2"
        return 1
    fi
}

echo "Checking dependencies..."
MISSING=0

check_dep "whisper-cli" "Install whisper.cpp (Arch: yay -S whisper.cpp)" || MISSING=1
check_dep "wtype" "Install wtype (Arch: yay -S wtype)" || MISSING=1
check_dep "pw-record" "Part of pipewire (usually pre-installed)" || MISSING=1
check_dep "notify-send" "Part of libnotify (usually pre-installed)" || MISSING=1

# Check for whisper model
echo
echo "Checking for whisper model..."
if [[ -f "/usr/share/whisper.cpp-model-tiny/ggml-tiny.bin" ]]; then
    echo -e "${GREEN}✓${NC} whisper model (tiny)"
elif [[ -f "$HOME/.local/share/whisper/models/ggml-tiny.bin" ]]; then
    echo -e "${GREEN}✓${NC} whisper model (tiny)"
else
    echo -e "${RED}✗${NC} whisper model not found"
    echo "  Install with: yay -S whisper.cpp-model-tiny"
    MISSING=1
fi

if [[ $MISSING -eq 1 ]]; then
    echo
    echo -e "${YELLOW}Please install missing dependencies first.${NC}"
    echo
    echo "Quick install (Arch):"
    echo "  yay -S whisper.cpp whisper.cpp-model-tiny wtype"
    exit 1
fi

# Install
echo
echo "Installing shout to ${INSTALL_DIR}..."
mkdir -p "$INSTALL_DIR"
cp shout "$INSTALL_DIR/shout"
chmod +x "$INSTALL_DIR/shout"

echo -e "${GREEN}✓${NC} Installed successfully!"
echo
echo "Add this keybind to ~/.config/hypr/bindings.conf:"
echo
echo -e "${YELLOW}  bindd = SUPER, R, shout, exec, ${INSTALL_DIR}/shout${NC}"
echo
echo "Then reload Hyprland (Super+Shift+E) or run: hyprctl reload"
