#!/bin/bash
# Install terminal theme for various terminal emulators
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎨 Terminal Theme Installer${NC}"
echo ""

# Detect terminal emulator
detect_terminal() {
  if [ -n "$ITERM_SESSION_ID" ]; then
    echo "iterm2"
  elif [ -n "$KITTY_WINDOW_ID" ]; then
    echo "kitty"
  elif [ -n "$ALACRITTY_SOCKET" ]; then
    echo "alacritty"
  elif [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    echo "terminal"
  else
    echo "unknown"
  fi
}

TERMINAL=$(detect_terminal)
echo -e "${YELLOW}Detected terminal: $TERMINAL${NC}"

# Get theme directory
if [ -d "terminal-themes" ]; then
  THEME_DIR="terminal-themes"
elif [ -d "$(dirname "$0")/../terminal-themes" ]; then
  THEME_DIR="$(dirname "$0")/../terminal-themes"
elif command -v brew &> /dev/null && [ -d "$(brew --prefix)/share/zsh-github-dark/terminal-themes" ]; then
  THEME_DIR="$(brew --prefix)/share/zsh-github-dark/terminal-themes"
else
  echo -e "${RED}❌ Error: Terminal themes directory not found${NC}"
  exit 1
fi

install_iterm2() {
  local theme_file="$THEME_DIR/iterm2/github-dark.itermcolors"
  if [ ! -f "$theme_file" ]; then
    echo -e "${RED}❌ iTerm2 theme not found${NC}"
    return 1
  fi
  
  echo -e "${YELLOW}Installing iTerm2 theme...${NC}"
  open "$theme_file"
  echo -e "${GREEN}✅ iTerm2 theme imported${NC}"
  echo ""
  echo "To use the theme:"
  echo "1. Open iTerm2 Preferences (⌘,)"
  echo "2. Go to Profiles → Colors"
  echo "3. Select 'GitHub Dark' from Color Presets"
}

install_kitty() {
  local theme_file="$THEME_DIR/kitty/github-dark.conf"
  local kitty_config="$HOME/.config/kitty"
  
  if [ ! -f "$theme_file" ]; then
    echo -e "${RED}❌ Kitty theme not found${NC}"
    return 1
  fi
  
  echo -e "${YELLOW}Installing Kitty theme...${NC}"
  
  # Create config directory if needed
  mkdir -p "$kitty_config"
  
  # Copy theme file
  cp "$theme_file" "$kitty_config/github-dark.conf"
  
  # Check if already included
  if ! grep -q "include github-dark.conf" "$kitty_config/kitty.conf" 2>/dev/null; then
    echo "" >> "$kitty_config/kitty.conf"
    echo "# GitHub Dark theme" >> "$kitty_config/kitty.conf"
    echo "include github-dark.conf" >> "$kitty_config/kitty.conf"
  fi
  
  echo -e "${GREEN}✅ Kitty theme installed${NC}"
  echo "Restart Kitty to apply the theme"
}

install_alacritty() {
  local theme_file="$THEME_DIR/alacritty/github-dark.yml"
  local alacritty_config="$HOME/.config/alacritty"
  
  if [ ! -f "$theme_file" ]; then
    echo -e "${RED}❌ Alacritty theme not found${NC}"
    return 1
  fi
  
  echo -e "${YELLOW}Installing Alacritty theme...${NC}"
  
  # Create config directory if needed
  mkdir -p "$alacritty_config"
  
  # Copy theme file
  cp "$theme_file" "$alacritty_config/github-dark.yml"
  
  echo -e "${GREEN}✅ Alacritty theme copied to $alacritty_config/github-dark.yml${NC}"
  echo ""
  echo "To use the theme, add to your alacritty.yml:"
  echo "  import:"
  echo "    - ~/.config/alacritty/github-dark.yml"
}

install_terminal() {
  # For Terminal.app, use the existing installer
  if [ -f "$(dirname "$0")/install-terminal-profile.sh" ]; then
    "$(dirname "$0")/install-terminal-profile.sh"
  else
    echo -e "${YELLOW}Use the main Terminal.app profile installer${NC}"
  fi
}

# Manual selection if detection fails or user wants different terminal
if [ "$TERMINAL" = "unknown" ]; then
  echo ""
  echo "Could not auto-detect terminal emulator."
  echo ""
  echo "Available themes:"
  echo "1. Terminal.app"
  echo "2. iTerm2"
  echo "3. Kitty"
  echo "4. Alacritty"
  echo ""
  read -p "Select terminal (1-4): " choice
  
  case $choice in
    1) install_terminal ;;
    2) install_iterm2 ;;
    3) install_kitty ;;
    4) install_alacritty ;;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
  esac
else
  # Auto-install based on detection
  case $TERMINAL in
    terminal) install_terminal ;;
    iterm2) install_iterm2 ;;
    kitty) install_kitty ;;
    alacritty) install_alacritty ;;
  esac
  
  # Offer to install for other terminals
  echo ""
  read -p "Install theme for another terminal? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "Available themes:"
    echo "1. Terminal.app"
    echo "2. iTerm2"
    echo "3. Kitty"
    echo "4. Alacritty"
    echo ""
    read -p "Select terminal (1-4): " choice
    
    case $choice in
      1) install_terminal ;;
      2) install_iterm2 ;;
      3) install_kitty ;;
      4) install_alacritty ;;
      *) echo -e "${RED}Invalid choice${NC}" ;;
    esac
  fi
fi