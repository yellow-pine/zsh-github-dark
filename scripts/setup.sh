#!/bin/bash
# Initialize development environment for zsh-github-dark
set -e

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "❌ Error: Not a git repository. Please run from project root."
  exit 1
fi

echo "🔧 Setting up pre-commit hook..."
cp scripts/git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
echo "✅ Pre-commit hook installed successfully."
