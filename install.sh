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
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --dry-run) DRY_RUN=true ;;
    -h|--help)
      echo "zsh-github-dark installer"
      echo ""
      echo "Usage:"
      echo "  curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash"
      echo "  curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash -s -- --dry-run"
      echo ""
      echo "Options:"
      echo "  --dry-run    Preview changes without making them"
      echo "  -h, --help   Show this help message"
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

# Run the full setup script
echo ""
echo -e "${YELLOW}🚀 Running setup...${NC}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}[DRY RUN] Would run: $INSTALL_DIR/scripts/full-setup.sh${NC}"
  echo -e "${BLUE}[DRY RUN] This would:${NC}"
  echo -e "${BLUE}  - Install required packages (coreutils, lsd, zsh)${NC}"
  echo -e "${BLUE}  - Configure zsh as default shell${NC}"
  echo -e "${BLUE}  - Create ~/.nvm directory${NC}"
  echo -e "${BLUE}  - Backup and install .zshrc${NC}"
  echo -e "${BLUE}  - Import GitHub Dark Terminal profile${NC}"
  echo -e "${BLUE}  - Optionally install developer tools${NC}"
  echo -e "${BLUE}  - Enable performance optimizations${NC}"
else
  cd "$INSTALL_DIR"
  ./scripts/full-setup.sh
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