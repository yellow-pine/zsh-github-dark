# System Requirements

## Operating System

- **macOS 10.15 (Catalina) or later**
- Tested on macOS 11 (Big Sur), 12 (Monterey), 13 (Ventura), 14 (Sonoma)
- Both Intel and Apple Silicon (M1/M2/M3) architectures supported

## Required Software

### Homebrew
- Required for package management
- Install from: https://brew.sh

### Command Line Tools
- Xcode Command Line Tools (for git)
- Install with: `xcode-select --install`

## Hardware Requirements

- **Minimum**: Any Mac that runs macOS 10.15+
- **Recommended**: 4GB RAM, 1GB free disk space

## Shell Requirements

- zsh 5.0 or later (included with macOS 10.15+)
- Terminal.app or compatible terminal emulator

## Dependencies Installed by Setup

### Required Dependencies
These will be automatically installed during setup:

| Package | Purpose | Version |
|---------|---------|---------|
| coreutils | GNU core utilities (for enhanced ls colors) | 9.0+ |
| lsd | Modern ls replacement with icons and colors | 0.23+ |
| zsh | Z shell (if not already present) | 5.0+ |

### Optional Dependencies
These are recommended for developers:

| Package | Purpose | Version |
|---------|---------|---------|
| pyenv | Python version management | 2.0+ |
| nvm | Node.js version management | 0.39+ |
| poetry | Python dependency management | 1.0+ |
| shfmt | Shell script formatter | 3.0+ |

## Terminal Requirements

- Terminal.app (included with macOS)
- 256-color support (standard in modern macOS)
- UTF-8 encoding support

## Network Requirements

- Internet connection required for:
  - Initial installation (downloading packages)
  - Homebrew package installation
  - Git repository cloning

## Compatibility Notes

### macOS Versions
- **macOS 10.14 and earlier**: Not tested, may work with manual adjustments
- **macOS 10.15-14.x**: Fully supported
- **macOS 15+**: Should work but not yet tested

### Terminal Emulators
- **Terminal.app**: Fully supported with custom profile
- **iTerm2**: Compatible but use default color scheme
- **Alacritty/Kitty**: Compatible with standard ANSI colors

### Shell Compatibility
- **zsh**: Primary target, fully supported
- **bash**: Not supported (incompatible syntax)
- **fish**: Not supported (different configuration system)

## Checking Your System

Run the dependency checker to verify your system:

```bash
scripts/check-dependencies.sh
```

This will:
- Verify macOS version
- Check all required dependencies
- Report any missing components
- Offer to install missing packages