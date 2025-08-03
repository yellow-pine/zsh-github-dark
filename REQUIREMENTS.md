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

### Terminal
- **Terminal.app**: Required (included with macOS)
- Custom GitHub Dark profile automatically installed

### Shell Compatibility
- **zsh**: Primary target, fully supported
- **bash**: Not supported (incompatible syntax)
- **fish**: Not supported (different configuration system)

## Checking Your System

The installer automatically checks your system and installs missing dependencies:

```bash
# The installer will check and install what's needed
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash

# Or preview what would be installed
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash -s -- --dry-run
```

The installer automatically:
- Verifies macOS version compatibility
- Checks for required tools (git, homebrew)
- Installs missing dependencies (coreutils, lsd, zsh)
- Reports any issues clearly