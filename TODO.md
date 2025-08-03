# TODO (Simplified)

Remaining improvements that align with our simplicity-first approach.

## 🎯 Guiding Principles

1. **One-command installation** - Users should get started with a single command
2. **Zero configuration** - It should work perfectly out of the box  
3. **No options** - The defaults should be so good that options aren't needed
4. **Minimal dependencies** - Only what's absolutely necessary

## 🧹 Simplification Tasks

### Remove Complexity

- [x] **Remove configuration file support**
  - Delete `.zsh-github-dark.conf.example`
  - Remove configuration loading from `.zshrc`
  - Hard-code the best default colors

- [x] **Consolidate installation scripts**
  - Keep only `install.sh` (one-line installer)
  - Remove all other installation scripts
  - Embed terminal profile installation directly

- [x] **Remove terminal emulator variants**
  - Focus only on Terminal.app (default macOS terminal)
  - Remove iTerm2, Kitty, Alacritty themes
  - Remove terminal theme installer

- [x] **Simplify dependency management**
  - Remove optional dependencies (pyenv, nvm, poetry)
  - Keep only essential: coreutils, lsd, zsh
  - Remove dependency checker script

## ✅ Essential Improvements

### Code Quality

- [x] **Add shellcheck to CI**
  - Basic linting for shell scripts
  - Ensure scripts are error-free

- [x] **Add comprehensive tests for user-facing functionality**
  - Test suite covers all user-facing features (42 tests)
  - One-line installer (help, dry-run, uninstall, error handling)
  - Shell configuration (aliases, git integration, prompt, key bindings)
  - Terminal profile (XML validation, color definitions)
  - Philosophy: Only test what users interact with

### Documentation

- [x] **Simplify README**
  - Remove all mentions of customization
  - Remove alternative installation methods
  - Focus on the one-line installer only

- [x] **Add simple troubleshooting**
  - 3-5 most common issues only
  - Simple solutions

- [x] **Create uninstall script**
  - One command to remove everything
  - Restore original settings

## ❌ Items to NOT Implement

These add complexity without significant value:

- Plugin systems
- Theme variants or builders  
- Multiple terminal emulator support
- Configuration files
- Color customization
- Feature toggles
- IDE integrations
- Advanced git features
- Performance options

## 📋 Final State Vision

The ideal end state:
1. User runs one command: `curl ... | bash`
2. Everything is installed and configured automatically
3. Terminal looks great with GitHub Dark theme
4. Fast, minimal zsh prompt with git support
5. No configuration needed or possible
6. To uninstall: `curl ... | bash -s -- --uninstall`