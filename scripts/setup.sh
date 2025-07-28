#!/bin/bash
# Initialize development environment for zsh-github-dark
set -e

# Parse command line arguments
FORCE_INSTALL=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -f|--force) FORCE_INSTALL=true ;;
    -h|--help)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  -f, --force    Force overwrite existing hooks"
      echo "  -h, --help     Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use -h or --help for usage information"
      exit 1
      ;;
  esac
  shift
done

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "❌ Error: Not a git repository. Please run from project root."
  exit 1
fi

# Check for existing pre-commit hook
if [ -f ".git/hooks/pre-commit" ] && [ "$FORCE_INSTALL" = false ]; then
  echo "⚠️  A pre-commit hook already exists."
  echo ""
  echo "Options:"
  echo "  1. Backup existing hook and install new one"
  echo "  2. Cancel installation"
  echo "  3. Force overwrite (use -f flag)"
  echo ""
  read -p "Choose an option (1-3): " choice

  case $choice in
    1)
      # Backup existing hook
      backup_file=".git/hooks/pre-commit.backup.$(date +%Y%m%d_%H%M%S)"
      echo "📦 Backing up existing hook to $backup_file"
      cp .git/hooks/pre-commit "$backup_file"
      ;;
    2)
      echo "❌ Installation cancelled."
      exit 0
      ;;
    *)
      echo "❌ Invalid choice. Installation cancelled."
      exit 1
      ;;
  esac
fi

echo "🔧 Setting up pre-commit hook..."
cp scripts/git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
echo "✅ Pre-commit hook installed successfully."
