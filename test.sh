#!/bin/bash
# Basic tests for zsh-github-dark
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
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

echo "Running zsh-github-dark tests..."
echo ""

# Test 1: Check .zshrc syntax
run_test ".zshrc syntax" "zsh -n src/.zshrc"

# Test 2: Check install.sh syntax
run_test "install.sh syntax" "bash -n install.sh"

# Test 3: Check pre-commit hook syntax
run_test "pre-commit syntax" "bash -n git-hooks/pre-commit"

# Test 4: Verify required files exist
run_test "README.md exists" "test -f README.md"
run_test "LICENSE exists" "test -f LICENSE"
run_test ".zshrc exists" "test -f src/.zshrc"
run_test "Terminal profile exists" "test -f src/github-dark.terminal"
run_test "install.sh exists" "test -f install.sh"

# Test 5: Check file permissions
run_test "install.sh is executable" "test -x install.sh"
run_test "pre-commit is executable" "test -x git-hooks/pre-commit"

# Test 6: Verify no configuration files
run_test "No config file" "! test -f .zsh-github-dark.conf.example"

# Test 7: Verify no scripts directory
run_test "No scripts directory" "! test -d scripts"

# Test 8: Check install.sh dry run
run_test "install.sh dry run" "bash install.sh --dry-run | grep -q 'DRY RUN'"

# Summary
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