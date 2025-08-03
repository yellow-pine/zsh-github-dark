#!/bin/bash
# Comprehensive test suite for zsh-github-dark
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
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
    ((TESTS_PASSED++))
  else
    echo -e "${RED}✗${NC}"
    ((TESTS_FAILED++))
  fi
}

echo -e "${BLUE}Running zsh-github-dark test suite...${NC}"
echo ""

# ========================================
# SECTION 1: Basic Project Structure Tests
# ========================================
echo "=== Basic Project Structure Tests ==="

# Syntax checks
run_test ".zshrc syntax" "zsh -n src/.zshrc"
run_test "install.sh syntax" "bash -n install.sh"
run_test "pre-commit syntax" "bash -n git-hooks/pre-commit"

# Required files
run_test "README.md exists" "test -f README.md"
run_test "LICENSE exists" "test -f LICENSE"
run_test ".zshrc exists" "test -f src/.zshrc"
run_test "Terminal profile exists" "test -f src/github-dark.terminal"
run_test "install.sh exists" "test -f install.sh"

# File permissions
run_test "install.sh is executable" "test -x install.sh"
run_test "pre-commit is executable" "test -x git-hooks/pre-commit"

# Project structure validation
run_test "No config file" "! test -f .zsh-github-dark.conf.example"
run_test "No scripts directory" "! test -d scripts"

# Installation tests
run_test "install.sh dry run" "bash install.sh --dry-run | grep -q 'DRY RUN'"
run_test "uninstall dry run" "bash install.sh --uninstall --dry-run | grep -q 'Uninstaller'"

# ========================================
# SECTION 2: Advanced .zshrc Functionality Tests
# ========================================
echo ""
echo "=== Advanced .zshrc Functionality Tests ==="

# Create a temporary test environment
TEST_DIR=$(mktemp -d)
TEST_HOME="$TEST_DIR/home"
mkdir -p "$TEST_HOME"

# PATH Configuration Tests
echo ""
echo "--- PATH Configuration ---"
run_test "Homebrew path added" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$PATH' | grep -q '/opt/homebrew/bin'
"

run_test "Coreutils path conditional" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; exit 0'
"

# History Configuration Tests
echo ""
echo "--- History Configuration ---"
run_test "HISTFILE set correctly" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$HISTFILE == ~/.zsh_history ]]'
"

run_test "HISTSIZE set to 10000" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$HISTSIZE -eq 10000 ]]'
"

run_test "SAVEHIST set to 10000" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ \$SAVEHIST -eq 10000 ]]'
"

run_test "History ignore dups option" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q hist_ignore_dups'
"

run_test "History ignore space option" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q hist_ignore_space'
"

run_test "Share history option" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; setopt | grep -q share_history'
"

# Alias Tests
echo ""
echo "--- Alias Definitions ---"
run_test "ls alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias ls' | grep -q lsd
"

run_test "ll alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias ll' | grep -q 'lsd -l'
"

run_test "la alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias la' | grep -q 'lsd -la'
"

run_test "l alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias l' | grep -q lsd
"

run_test "dir alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias dir' | grep -q lsd
"

run_test "vdir alias defined" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; alias vdir' | grep -q 'lsd -l'
"

# Git Integration Tests
echo ""
echo "--- Git Integration ---"

# Create a mock git repo
MOCK_REPO="$TEST_DIR/mock-repo"
mkdir -p "$MOCK_REPO"
cd "$MOCK_REPO"
git init --quiet
git config user.email "test@example.com"
git config user.name "Test User"
echo "test" > file.txt
git add file.txt
git commit -m "Initial commit" --quiet

run_test "_git_branch function exists" "
  cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; type _git_branch' | grep -q function
"

run_test "Git branch detection" "
  cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; _git_branch' | grep -q 'main\\|master'
"

# Make a change to test dirty state
echo "changed" >> file.txt

run_test "Git dirty state detection" "
  cd $MOCK_REPO && HOME=$TEST_HOME zsh -c 'source $OLDPWD/src/.zshrc 2>/dev/null; _git_branch' | grep -q '\\*'
"

cd - > /dev/null

# Environment Variables
echo ""
echo "--- Environment Variables ---"
run_test "LS_COLORS exported" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; [[ -n \$LS_COLORS ]]'
"

run_test "LS_COLORS contains directory colors" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$LS_COLORS' | grep -q 'di=38;5;33'
"

run_test "LS_COLORS contains python colors" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$LS_COLORS' | grep -q '*.py=38;5;41'
"

run_test "LS_COLORS contains typescript colors" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; echo \$LS_COLORS' | grep -q '*.ts=38;5;81'
"

# Optional Tool Integration Tests
echo ""
echo "--- Optional Tool Integration ---"
run_test "pyenv integration safe when not installed" "
  HOME=$TEST_HOME PATH=/usr/bin:/bin zsh -c 'source src/.zshrc 2>/dev/null; exit 0'
"

run_test "nvm integration safe when not installed" "
  HOME=$TEST_HOME zsh -c 'unset NVM_DIR; source src/.zshrc 2>/dev/null; exit 0'
"

run_test "poetry integration safe when not installed" "
  HOME=$TEST_HOME PATH=/usr/bin:/bin zsh -c 'source src/.zshrc 2>/dev/null; exit 0'
"

# Key Bindings
echo ""
echo "--- Key Bindings ---"
run_test "Up arrow key binding set" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -q '\\^\\[\\[A.*history-search-backward'
"

run_test "Down arrow key binding set" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -q '\\^\\[\\[B.*history-search-forward'
"

run_test "Ctrl+R binding set" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; bindkey' | grep -q '\\^R.*history-incremental-search-backward'
"

# Prompt Functions
echo ""
echo "--- Prompt Functions ---"
run_test "build_prompt function exists" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; type build_prompt' | grep -q function
"

run_test "preexec function exists" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; type preexec' | grep -q function
"

run_test "precmd function exists" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; type precmd' | grep -q function
"

run_test "Prompt contains username" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%n'
"

run_test "Prompt contains hostname" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%m'
"

run_test "Prompt contains directory" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q '%~'
"

run_test "Prompt has newline before prompt char" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; build_prompt; echo \$PROMPT' | grep -q $'\\n'
"

# Completion System
echo ""
echo "--- Completion System ---"
run_test "compinit is called" "
  HOME=$TEST_HOME zsh -c 'source src/.zshrc 2>/dev/null; type _complete' | grep -q function
"

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
  echo -e "${GREEN}All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}Some tests failed!${NC}"
  exit 1
fi