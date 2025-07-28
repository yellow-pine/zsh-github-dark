#!/bin/bash
# Full automated setup for zsh-github-dark
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 zsh-github-dark Full Setup Script${NC}"
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}❌ Error: This script is only for macOS${NC}"
  exit 1
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to prompt for confirmation
confirm() {
  read -p "$1 (y/n) " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

# 1. Check and install required dependencies
echo -e "${YELLOW}📦 Checking dependencies...${NC}"
MISSING_DEPS=()

if ! command_exists brew; then
  echo -e "${RED}❌ Homebrew not found. Please install it first:${NC}"
  echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  exit 1
fi

# Check required tools
for cmd in coreutils lsd zsh; do
  if ! command_exists $cmd; then
    MISSING_DEPS+=($cmd)
  fi
done

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
  echo -e "${YELLOW}Missing dependencies: ${MISSING_DEPS[*]}${NC}"
  if confirm "Install missing dependencies with Homebrew?"; then
    brew install "${MISSING_DEPS[@]}"
  else
    echo -e "${RED}❌ Cannot proceed without required dependencies${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}✅ All required dependencies installed${NC}"
fi

# 2. Check current shell
echo ""
echo -e "${YELLOW}🐚 Checking shell configuration...${NC}"
CURRENT_SHELL=$(echo $SHELL)
if [[ "$CURRENT_SHELL" != */zsh ]]; then
  echo "Current shell: $CURRENT_SHELL"
  if confirm "Change default shell to zsh?"; then
    chsh -s /bin/zsh
    echo -e "${GREEN}✅ Default shell changed to zsh${NC}"
    echo -e "${YELLOW}Note: You'll need to open a new terminal for this to take effect${NC}"
  fi
else
  echo -e "${GREEN}✅ Already using zsh${NC}"
fi

# 3. Create NVM directory if needed
echo ""
echo -e "${YELLOW}📁 Checking NVM directory...${NC}"
if [ ! -d "$HOME/.nvm" ]; then
  mkdir -p "$HOME/.nvm"
  echo -e "${GREEN}✅ Created ~/.nvm directory${NC}"
else
  echo -e "${GREEN}✅ NVM directory exists${NC}"
fi

# 4. Backup existing .zshrc if present
echo ""
echo -e "${YELLOW}📋 Setting up .zshrc...${NC}"
if [ -f "$HOME/.zshrc" ]; then
  BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
  echo -e "${YELLOW}Existing .zshrc found${NC}"
  if confirm "Backup existing .zshrc to $BACKUP_FILE?"; then
    cp "$HOME/.zshrc" "$BACKUP_FILE"
    echo -e "${GREEN}✅ Backed up to $BACKUP_FILE${NC}"
  fi
fi

# 5. Copy new .zshrc
if confirm "Copy new .zshrc to home directory?"; then
  # Check if we're running from Homebrew installation
  if [ -f "src/.zshrc" ]; then
    cp src/.zshrc "$HOME/.zshrc"
  elif [ -f "$(brew --prefix)/share/zsh-github-dark/.zshrc" ]; then
    cp "$(brew --prefix)/share/zsh-github-dark/.zshrc" "$HOME/.zshrc"
  else
    echo -e "${RED}❌ Error: .zshrc not found${NC}"
    exit 1
  fi
  echo -e "${GREEN}✅ Copied .zshrc${NC}"
fi

# 6. Install Terminal profile
echo ""
echo -e "${YELLOW}🎨 Setting up Terminal profile...${NC}"
if confirm "Install GitHub Dark Terminal profile?"; then
  # Check if we're running from Homebrew installation
  if [ -f "scripts/install-terminal-profile.sh" ]; then
    scripts/install-terminal-profile.sh
  elif command -v zsh-github-dark-terminal &> /dev/null; then
    zsh-github-dark-terminal
  else
    echo -e "${YELLOW}⚠️  Terminal profile installer not found${NC}"
  fi
fi

# 7. Setup git hooks for development
echo ""
echo -e "${YELLOW}🔧 Setting up development environment...${NC}"
if [ -d ".git" ] && confirm "Install git pre-commit hooks?"; then
  scripts/setup.sh
fi

# 8. Optional tools
echo ""
echo -e "${YELLOW}📦 Optional tools setup...${NC}"
OPTIONAL_TOOLS=()

if ! command_exists pyenv; then
  OPTIONAL_TOOLS+=("pyenv - Python version management")
fi
if ! command_exists nvm; then
  OPTIONAL_TOOLS+=("nvm - Node.js version management")
fi
if ! command_exists poetry; then
  OPTIONAL_TOOLS+=("poetry - Python dependency management")
fi

if [ ${#OPTIONAL_TOOLS[@]} -ne 0 ]; then
  echo "The following optional tools are not installed:"
  printf '%s\n' "${OPTIONAL_TOOLS[@]}"
  if confirm "Install optional developer tools?"; then
    brew install pyenv nvm poetry
  fi
else
  echo -e "${GREEN}✅ All optional tools already installed${NC}"
fi

# 9. Performance optimization
echo ""
echo -e "${YELLOW}⚡ Performance optimization...${NC}"
if confirm "Enable faster shell startup (recommended for trusted systems)?"; then
  echo "export ZSH_DISABLE_COMPFIX=true" >> "$HOME/.zshenv"
  echo -e "${GREEN}✅ Enabled fast startup mode${NC}"
fi

# 10. Final instructions
echo ""
echo -e "${GREEN}🎉 Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Open a new terminal window to use the new configuration"
echo "2. If you changed your shell, log out and back in"
echo "3. Set GitHub Dark as your default Terminal profile in preferences"
echo ""
echo -e "${BLUE}Enjoy your new zsh setup! 🚀${NC}"