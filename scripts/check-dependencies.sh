#!/bin/bash
# Check and install dependencies for zsh-github-dark
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 zsh-github-dark Dependency Checker${NC}"
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}❌ Error: This script is only for macOS${NC}"
  exit 1
fi

# Required dependencies
REQUIRED_DEPS=(
  "coreutils:GNU core utilities"
  "lsd:Modern ls replacement"
  "zsh:Z shell"
)

# Optional dependencies
OPTIONAL_DEPS=(
  "pyenv:Python version management"
  "nvm:Node.js version management"
  "poetry:Python dependency management"
  "shfmt:Shell script formatter"
)

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to get version
get_version() {
  local cmd="$1"
  case "$cmd" in
    coreutils)
      if command_exists gls; then
        gls --version | head -n1 | awk '{print $NF}'
      fi
      ;;
    lsd)
      lsd --version | awk '{print $2}'
      ;;
    zsh)
      zsh --version | awk '{print $2}'
      ;;
    pyenv)
      pyenv --version | awk '{print $2}'
      ;;
    nvm)
      if [ -f "$HOME/.nvm/nvm.sh" ]; then
        echo "installed"
      fi
      ;;
    poetry)
      poetry --version | awk '{print $3}' | tr -d '()'
      ;;
    shfmt)
      shfmt --version
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

# Check Homebrew
echo -e "${YELLOW}Checking Homebrew...${NC}"
if ! command_exists brew; then
  echo -e "${RED}❌ Homebrew not installed${NC}"
  echo "Install with:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
else
  BREW_VERSION=$(brew --version | head -n1 | awk '{print $2}')
  echo -e "${GREEN}✅ Homebrew ${BREW_VERSION}${NC}"
fi

echo ""
echo -e "${YELLOW}Checking required dependencies...${NC}"

MISSING_REQUIRED=()
for dep_info in "${REQUIRED_DEPS[@]}"; do
  IFS=':' read -r dep desc <<< "$dep_info"
  
  if [[ "$dep" == "coreutils" ]] && command_exists gls; then
    version=$(get_version "$dep")
    echo -e "${GREEN}✅ $dep ($desc) - $version${NC}"
  elif [[ "$dep" != "coreutils" ]] && command_exists "$dep"; then
    version=$(get_version "$dep")
    echo -e "${GREEN}✅ $dep ($desc) - $version${NC}"
  else
    echo -e "${RED}❌ $dep ($desc) - NOT INSTALLED${NC}"
    MISSING_REQUIRED+=("$dep")
  fi
done

echo ""
echo -e "${YELLOW}Checking optional dependencies...${NC}"

MISSING_OPTIONAL=()
for dep_info in "${OPTIONAL_DEPS[@]}"; do
  IFS=':' read -r dep desc <<< "$dep_info"
  
  if [[ "$dep" == "nvm" ]]; then
    if [ -f "$HOME/.nvm/nvm.sh" ]; then
      echo -e "${GREEN}✅ $dep ($desc) - installed${NC}"
    else
      echo -e "${YELLOW}⚠️  $dep ($desc) - NOT INSTALLED${NC}"
      MISSING_OPTIONAL+=("$dep")
    fi
  elif command_exists "$dep"; then
    version=$(get_version "$dep")
    echo -e "${GREEN}✅ $dep ($desc) - $version${NC}"
  else
    echo -e "${YELLOW}⚠️  $dep ($desc) - NOT INSTALLED${NC}"
    MISSING_OPTIONAL+=("$dep")
  fi
done

# Installation recommendations
echo ""
if [ ${#MISSING_REQUIRED[@]} -gt 0 ]; then
  echo -e "${RED}Missing required dependencies!${NC}"
  echo ""
  echo "Install with:"
  echo -e "${BLUE}brew install ${MISSING_REQUIRED[*]}${NC}"
  echo ""
  read -p "Install required dependencies now? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    brew install "${MISSING_REQUIRED[@]}"
    echo -e "${GREEN}✅ Required dependencies installed${NC}"
  else
    echo -e "${YELLOW}⚠️  Please install required dependencies before proceeding${NC}"
    exit 1
  fi
fi

if [ ${#MISSING_OPTIONAL[@]} -gt 0 ]; then
  echo ""
  echo -e "${YELLOW}Optional dependencies not installed:${NC}"
  for dep in "${MISSING_OPTIONAL[@]}"; do
    echo "  - $dep"
  done
  echo ""
  echo "To install all optional dependencies:"
  echo -e "${BLUE}brew install pyenv poetry shfmt${NC}"
  echo -e "${BLUE}brew install nvm${NC}"
  echo ""
  read -p "Install optional dependencies? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Install brew-based optional deps
    BREW_OPTIONAL=()
    for dep in "${MISSING_OPTIONAL[@]}"; do
      if [[ "$dep" != "nvm" ]]; then
        BREW_OPTIONAL+=("$dep")
      fi
    done
    
    if [ ${#BREW_OPTIONAL[@]} -gt 0 ]; then
      brew install "${BREW_OPTIONAL[@]}"
    fi
    
    # Special handling for nvm
    if [[ " ${MISSING_OPTIONAL[*]} " =~ " nvm " ]]; then
      brew install nvm
      mkdir -p "$HOME/.nvm"
      echo -e "${YELLOW}Note: NVM requires shell configuration. This will be handled by .zshrc${NC}"
    fi
    
    echo -e "${GREEN}✅ Optional dependencies installed${NC}"
  fi
fi

# System information
echo ""
echo -e "${BLUE}System Information:${NC}"
echo "  macOS: $(sw_vers -productVersion)"
echo "  Architecture: $(uname -m)"
echo "  Shell: $SHELL"

if [ ${#MISSING_REQUIRED[@]} -eq 0 ]; then
  echo ""
  echo -e "${GREEN}✅ All required dependencies are satisfied!${NC}"
  echo "You're ready to use zsh-github-dark."
else
  echo ""
  echo -e "${YELLOW}⚠️  Some dependencies are missing. Please install them first.${NC}"
fi