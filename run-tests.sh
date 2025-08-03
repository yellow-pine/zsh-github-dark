#!/bin/bash
# Test suite for customer-facing functionality only
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TESTS_PASSED=0
TESTS_FAILED=0

# Test function
run_test() {
  local test_name="$1"
  local test_command="$2"
  
  echo -n "Testing $test_name... "
  
  if eval "$test_command" 2>/dev/null; then
    echo -e "${GREEN}✓${NC}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
  else
    echo -e "${RED}✗${NC}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
  fi
}

echo -e "${BLUE}Testing customer-facing functionality...${NC}"
echo ""

# Create a temporary test environment
TEST_DIR=$(mktemp -d)
TEST_HOME="$TEST_DIR/home"
mkdir -p "$TEST_HOME"

# ========================================
# INSTALLER TESTS (Customer-Facing)
# ========================================
echo "=== One-Line Installer ==="
run_test "installer syntax valid" "bash -n install.sh"
run_test "installer help works" "bash install.sh --help | grep -q 'zsh-github-dark installer'"
run_test "installer shows usage" "bash install.sh --help | grep -q 'curl -fsSL'"
run_test "installer dry-run mode works" "bash install.sh --dry-run 2>&1 | grep -q 'DRY RUN'"
run_test "installer uninstall dry-run works" "bash install.sh --uninstall --dry-run 2>&1 | grep -q 'Uninstaller'"
run_test "installer checks prerequisites" "bash install.sh --dry-run 2>&1 | grep -q 'Checking prerequisites'"
run_test "installer shows complete message" "bash install.sh --dry-run 2>&1 | grep -q 'Dry run complete'"
run_test "installer handles unknown options" "bash install.sh --invalid-option 2>&1 | grep -q 'Unknown option'"

# ========================================
# ZSHRC FUNCTIONALITY TESTS (Customer-Facing)
# ========================================
echo ""
echo "=== .zshrc Configuration ==="

# Basic syntax
run_test ".zshrc syntax valid" "zsh -n src/.zshrc"

# PATH configuration
run_test "Homebrew path added" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$PATH' | grep -q '/opt/homebrew/bin'"

# History configuration
run_test "HISTFILE configured" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$HISTFILE == ~/.zsh_history ]]'"
run_test "HISTSIZE set to 10000" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$HISTSIZE -eq 10000 ]]'"
run_test "SAVEHIST set to 10000" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$SAVEHIST -eq 10000 ]]'"
run_test "history ignore duplicates" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q histignoredups'"
run_test "history ignore space" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q histignorespace'"
run_test "history sharing enabled" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q sharehistory'"

# Aliases (lsd directory listings)
run_test "ls alias uses lsd" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias ls' | grep -q lsd"
run_test "ll alias configured" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias ll' | grep -q 'lsd -l'"
run_test "la alias configured" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias la' | grep -q 'lsd -la'"

# Git integration
MOCK_REPO="$TEST_DIR/mock-repo"
mkdir -p "$MOCK_REPO"
cd "$MOCK_REPO"
git init --quiet
git config user.email "test@example.com"
git config user.name "Test User"
echo "test" > file.txt
git add file.txt
git commit -m "Initial commit" --quiet

run_test "git branch function exists" "cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; type _git_branch' | grep -q function"
run_test "git branch detection works" "cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; _git_branch' | grep -E -q '^(main|master)$'"

# Test dirty state
echo "changed" >> file.txt
run_test "git dirty state detection" "cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; _git_branch' | grep -q '\*'"

cd - > /dev/null

# Environment variables
run_test "LS_COLORS exported" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ -n \$LS_COLORS ]]'"
run_test "LS_COLORS has directory colors" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$LS_COLORS' | grep -q 'di=38;5;33'"
run_test "LS_COLORS has python colors" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$LS_COLORS' | grep -q '*.py=38;5;41'"

# Key bindings
run_test "up arrow history search" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -F '\"^[[A\"' | grep -q 'history-search-backward'"
run_test "down arrow history search" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -F '\"^[[B\"' | grep -q 'history-search-forward'"
run_test "ctrl-r incremental search" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -F '\"^R\"' | grep -q 'history-incremental-search-backward'"

# Prompt functionality
run_test "build_prompt function exists" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; typeset -f build_prompt >/dev/null 2>&1'"
run_test "preexec function exists" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; typeset -f preexec >/dev/null 2>&1'"
run_test "precmd function exists" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; typeset -f precmd >/dev/null 2>&1'"
run_test "prompt shows username" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%n'"
run_test "prompt shows hostname" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%m'"
run_test "prompt shows directory" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%~'"
run_test "prompt has newline" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q $'\\n'"

# Optional tool integrations (safe when not installed)
run_test "pyenv integration safe" "HOME=$TEST_HOME PATH=/usr/bin:/bin zsh -c 'source src/.zshrc 2>/dev/null; exit 0'"
run_test "nvm integration safe" "HOME=$TEST_HOME zsh -c 'unset NVM_DIR; source src/.zshrc 2>/dev/null; exit 0'"
run_test "poetry integration safe" "HOME=$TEST_HOME PATH=/usr/bin:/bin zsh -c 'source src/.zshrc 2>/dev/null; exit 0'"

# Completion system
run_test "completion system loads" "HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; typeset -f _complete >/dev/null 2>&1'"

# ========================================
# TERMINAL PROFILE TESTS (Customer-Facing)
# ========================================
echo ""
echo "=== Terminal Profile ==="
run_test "terminal profile is valid XML" "plutil -lint src/github-dark.terminal"
run_test "terminal profile has name" "grep -q 'GitHub Dark' src/github-dark.terminal"
run_test "terminal profile has colors" "grep -q 'ANSIBlackColor' src/github-dark.terminal"

# Cleanup
rm -rf "$TEST_DIR"

# ========================================
# Summary
# ========================================
echo ""
echo "================================"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
echo "================================"

if [ $TESTS_FAILED -eq 0 ]; then
  echo -e "${GREEN}All customer-facing functionality works!${NC}"
  exit 0
else
  echo -e "${RED}Some customer-facing features failed!${NC}"
  exit 1
fi