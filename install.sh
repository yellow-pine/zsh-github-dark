#!/bin/bash
# One-line installer for zsh-github-dark
# Usage: curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/yellow-pine/zsh-github-dark.git"
INSTALL_DIR="$HOME/.zsh-github-dark"
DRY_RUN=false

# Parse command line arguments
UNINSTALL=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --dry-run) DRY_RUN=true ;;
    --uninstall) UNINSTALL=true ;;
    -h|--help)
      echo "zsh-github-dark installer"
      echo ""
      echo "Usage:"
      echo "  curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash"
      echo "  curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash -s -- --dry-run"
      echo "  curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash -s -- --uninstall"
      echo ""
      echo "Options:"
      echo "  --dry-run     Preview changes without making them"
      echo "  --uninstall   Remove zsh-github-dark"
      echo "  -h, --help    Show this help message"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      exit 1
      ;;
  esac
  shift
done

# Function to run or preview commands
run_cmd() {
  if [ "$DRY_RUN" = true ]; then
    echo -e "${BLUE}[DRY RUN] Would run: $*${NC}"
  else
    "$@"
  fi
}

# Function to write or preview file writes
write_file() {
  local file="$1"
  local content="$2"
  if [ "$DRY_RUN" = true ]; then
    echo -e "${BLUE}[DRY RUN] Would write to: $file${NC}"
  else
    echo "$content" > "$file"
  fi
}

# Handle uninstall
if [ "$UNINSTALL" = true ]; then
  echo -e "${BLUE}╔════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║   zsh-github-dark Uninstaller      ║${NC}"
  echo -e "${BLUE}╚════════════════════════════════════╝${NC}"
  echo ""
  
  if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Running in DRY RUN mode - no changes will be made${NC}"
    echo ""
  fi
  
  echo -e "${YELLOW}🗑  Removing zsh-github-dark...${NC}"
  
  # Remove .zshrc if it's ours
  if [ -f "$HOME/.zshrc" ] && grep -q "zsh-github-dark" "$HOME/.zshrc" 2>/dev/null; then
    run_cmd rm "$HOME/.zshrc"
    echo -e "${GREEN}✅ Removed .zshrc${NC}"
  fi
  
  # Remove installation directory
  if [ -d "$INSTALL_DIR" ]; then
    run_cmd rm -rf "$INSTALL_DIR"
    echo -e "${GREEN}✅ Removed installation directory${NC}"
  fi
  
  # Note about Terminal profile
  echo ""
  echo -e "${YELLOW}Note: To remove the Terminal profile:${NC}"
  echo "1. Open Terminal → Settings (⌘,)"
  echo "2. Select 'GitHub Dark' profile"
  echo "3. Click the minus (-) button"
  echo "4. Set 'Basic' as default"
  
  echo ""
  if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Dry run complete. No changes were made.${NC}"
  else
    echo -e "${GREEN}✅ Uninstall complete!${NC}"
  fi
  exit 0
fi

echo -e "${BLUE}╔════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    zsh-github-dark Installer       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════╝${NC}"
echo ""

if [ "$DRY_RUN" = true ]; then
  echo -e "${YELLOW}Running in DRY RUN mode - no changes will be made${NC}"
  echo ""
fi

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}❌ Error: This installer is only for macOS${NC}"
  exit 1
fi

# Check for required tools
echo -e "${YELLOW}📋 Checking prerequisites...${NC}"

if ! command -v git &> /dev/null; then
  echo -e "${RED}❌ Git is not installed${NC}"
  echo "Please install Xcode Command Line Tools:"
  echo "  xcode-select --install"
  exit 1
fi

if ! command -v brew &> /dev/null; then
  echo -e "${RED}❌ Homebrew is not installed${NC}"
  echo "Please install Homebrew first:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

echo -e "${GREEN}✅ Prerequisites satisfied${NC}"

# Clone or update the repository
echo ""
echo -e "${YELLOW}📦 Setting up zsh-github-dark...${NC}"

if [ -d "$INSTALL_DIR" ]; then
  echo "Updating existing installation..."
  run_cmd cd "$INSTALL_DIR"
  run_cmd git pull --quiet
else
  echo "Cloning repository..."
  run_cmd git clone --quiet "$REPO_URL" "$INSTALL_DIR"
fi

# Install dependencies
echo ""
echo -e "${YELLOW}📦 Installing dependencies...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}[DRY RUN] Would check and install: coreutils, lsd, zsh${NC}"
else
  # Check and install required dependencies
  MISSING_DEPS=()
  for cmd in coreutils lsd zsh; do
    if ! command -v "$cmd" &> /dev/null && ! command -v "g$cmd" &> /dev/null; then
      MISSING_DEPS+=("$cmd")
    fi
  done
  
  if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo "Installing: ${MISSING_DEPS[*]}"
    brew install "${MISSING_DEPS[@]}"
  else
    echo -e "${GREEN}✅ All dependencies already installed${NC}"
  fi
fi

# Configure shell
echo ""
echo -e "${YELLOW}🐚 Configuring shell...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}[DRY RUN] Would set zsh as default shell${NC}"
else
  CURRENT_SHELL=$SHELL
  if [[ "$CURRENT_SHELL" != */zsh ]]; then
    chsh -s /bin/zsh
    echo -e "${GREEN}✅ Default shell changed to zsh${NC}"
  else
    echo -e "${GREEN}✅ Already using zsh${NC}"
  fi
fi

# Install .zshrc
echo ""
echo -e "${YELLOW}📄 Installing .zshrc...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}[DRY RUN] Would backup existing .zshrc and install new one${NC}"
else
  if [ -f "$HOME/.zshrc" ]; then
    BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HOME/.zshrc" "$BACKUP_FILE"
    echo -e "${GREEN}✅ Backed up existing .zshrc to $BACKUP_FILE${NC}"
  fi
  
  cp "$INSTALL_DIR/src/.zshrc" "$HOME/.zshrc"
  echo -e "${GREEN}✅ Installed .zshrc${NC}"
fi

# Install Terminal profile
echo ""
echo -e "${YELLOW}🎨 Installing Terminal profile...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}[DRY RUN] Would import GitHub Dark Terminal profile${NC}"
else
  # Import the terminal profile using osascript
  osascript <<EOF
tell application "Terminal"
  set profilePath to POSIX file "$INSTALL_DIR/src/github-dark.terminal"
  do shell script "open " & quoted form of POSIX path of profilePath
end tell
EOF
  
  echo -e "${GREEN}✅ Terminal profile imported${NC}"
  echo ""
  echo "👉 Set 'GitHub Dark' as default in Terminal → Settings → Profiles"
fi

# Cleanup
if [ "$DRY_RUN" = false ]; then
  echo ""
  echo -e "${GREEN}✨ Installation complete!${NC}"
  echo ""
  echo "The installer files are kept at: $INSTALL_DIR"
  echo "You can safely remove this directory if desired."
  echo ""
  echo -e "${YELLOW}Please open a new terminal window to start using your new setup.${NC}"
else
  echo ""
  echo -e "${YELLOW}Dry run complete. No changes were made.${NC}"
  echo "Run without --dry-run to perform the installation."
fi