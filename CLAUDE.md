# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project Overview

This is a minimalistic macOS zsh and Terminal configuration project optimized for
GitHub Dark themes. The project provides:

- A custom `.zshrc` configuration with GitHub Dark-optimized zsh prompt
- A Terminal profile (`github-dark.terminal`) with custom settings
- Developer setup automation scripts

## Common Commands

### Linting and Formatting

```bash
# Check syntax of .zshrc
zsh -n src/.zshrc

# Format .zshrc with shfmt
shfmt -w -i 2 src/.zshrc

# Check formatting without modifying
shfmt -d src/.zshrc
```

### Development Setup

```bash
# Install pre-commit hook for automatic formatting
cp git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### CI/CD

The project uses GitHub Actions for continuous integration. The CI pipeline:

- Validates `.zshrc` syntax using `zsh -n`
- Checks formatting compliance using `shfmt -d`
- Verifies presence of required files

## Architecture

### Project Structure

- `install.sh` - One-line installer script
- `src/.zshrc` - Main zsh configuration file with prompt and git integration
- `src/github-dark.terminal` - macOS Terminal profile with GitHub Dark theme
- `git-hooks/pre-commit` - Auto-formats `.zshrc` before commits

### Key Components

The `.zshrc` file includes:

- Dynamic prompt with git branch awareness, command timing, and error status
- Color scheme optimized for GitHub Dark Terminal theme
- `lsd` aliases for enhanced directory listings

## Development Guidelines

### Code Style

- Keep `.zshrc` minimal and readable - no unnecessary plugin frameworks
- Use `shfmt` with 2-space indentation for shell script formatting
- Follow existing file organization patterns

### Testing Changes

Before submitting changes:

1. Test your modifications locally by sourcing the `.zshrc`
2. Ensure prompt rendering and terminal colors remain clean
3. Run `zsh -n src/.zshrc` to check syntax
4. Run `shfmt -d src/.zshrc` to verify formatting

### Recommended Tools

- Install `shfmt` for shell script formatting: `brew install shfmt`
- VSCode/Cursor extensions: Shell Format, EditorConfig, Markdownlint
