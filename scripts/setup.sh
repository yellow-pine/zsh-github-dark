#!/bin/bash
# Initialize development environment for zsh-github-dark
set -e

echo "🔧 Setting up pre-commit hook..."
cp scripts/git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
echo "✅ Pre-commit hook installed successfully."
