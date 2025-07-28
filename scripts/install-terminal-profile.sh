#!/bin/bash
# Install GitHub Dark Terminal profile for macOS Terminal.app
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}❌ Error: This script is only for macOS${NC}"
  exit 1
fi

# Check if Terminal profile exists
PROFILE_PATH="src/github-dark.terminal"
# Check for Homebrew installation path as fallback
if [ ! -f "$PROFILE_PATH" ]; then
  if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/zsh-github-dark/github-dark.terminal" ]; then
    PROFILE_PATH="$(brew --prefix)/share/zsh-github-dark/github-dark.terminal"
  else
    echo -e "${RED}❌ Error: Terminal profile not found at $PROFILE_PATH${NC}"
    echo "Please run this script from the project root directory."
    exit 1
  fi
fi

echo "🎨 Installing GitHub Dark Terminal profile..."

# Import the terminal profile using osascript
osascript <<EOF
tell application "Terminal"
  set profilePath to POSIX file "$(pwd)/$PROFILE_PATH"
  do shell script "open " & quoted form of POSIX path of profilePath
end tell
EOF

# Wait a moment for the import
sleep 2

# Offer to set as default profile
echo ""
echo -e "${YELLOW}The GitHub Dark profile has been imported.${NC}"
echo ""
echo "To set it as your default profile:"
echo "1. Open Terminal → Settings (⌘,)"
echo "2. Select 'GitHub Dark' from the profiles list"
echo "3. Click 'Default' button at the bottom"
echo ""
read -p "Would you like to open Terminal preferences now? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Open Terminal preferences
  osascript <<EOF
tell application "Terminal"
  activate
  tell application "System Events"
    keystroke "," using command down
  end tell
end tell
EOF
  echo -e "${GREEN}✅ Terminal preferences opened. Please select 'GitHub Dark' and click 'Default'.${NC}"
else
  echo -e "${GREEN}✅ Terminal profile imported successfully!${NC}"
fi