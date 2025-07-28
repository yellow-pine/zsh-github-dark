# zsh-github-dark

[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/yellow-pine/zsh-github-dark/actions/workflows/ci.yml/badge.svg)](https://github.com/yellow-pine/zsh-github-dark/actions/workflows/ci.yml)
[![shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![shfmt](https://img.shields.io/badge/code%20style-shfmt-1abc9c.svg)](https://github.com/mvdan/sh)
[![💛 Yellow Pine](https://img.shields.io/badge/%F0%9F%92%9B%20Yellow%20Pine-gray.svg)](https://github.com/yellow-pine)

Minimalistic macOS zsh and Terminal configuration optimized for GitHub Dark themes.
Designed for clarity, speed, and a visually cohesive development environment.

## 🎯 Why zsh-github-dark?

A minimal zsh and Terminal setup aligned with GitHub Dark themes — reusing an
optimized Terminal profile, fine-tuning prompt colors, and keeping everything
clean and fast.

Ready for developers working with TypeScript, Python, and modern CLI workflows.

## 📋 Requirements

- macOS 10.15 (Catalina) or later
- Homebrew package manager
- Internet connection for installation

See [REQUIREMENTS.md](REQUIREMENTS.md) for detailed system requirements.

## 🎨 Terminal Preview

Here's a preview of the final setup:

![Terminal Preview](assets/terminal-preview.png)

## 🚀 Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash
```

This will:
- Install all required packages (coreutils, lsd, zsh)
- Set up your shell configuration  
- Import the GitHub Dark Terminal profile
- Configure optional developer tools (pyenv, nvm, poetry)

## 🛠 Features

- GitHub Dark-optimized zsh prompt
- Git branch awareness, last command timing, and error status
- Human-readable `lsd` output with matching color theme
- No plugins, no bloated frameworks — pure native zsh

## 🎨 Terminal Theme Support

### Terminal.app (macOS)
- Custom profile with GitHub Dark colors
- Font size: 12pt
- Background opacity: 85%
- Auto-installed during setup

### Other Terminal Emulators
Also includes themes for:
- **iTerm2** - Native color scheme
- **Kitty** - Configuration file
- **Alacritty** - YAML color scheme

The Terminal.app theme is automatically installed during setup.

## 🛠 Troubleshooting & Contributions

If anything doesn't work as expected, please check:

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for setup issues
- [CONTRIBUTING.md](CONTRIBUTING.md) for developer guidelines

## 📫 Contact

For feedback, ideas, or contributions:
**<hello@yellowpine.com>**

## ⚡ License

This project is licensed under the [MIT License](LICENSE).
Authored and maintained by **Cansin Yildiz**.
