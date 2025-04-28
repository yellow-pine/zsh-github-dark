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

## 🎨 Terminal Preview

Here's a preview of the final setup:

![Terminal Preview](assets/terminal-preview.png)

## 🚀 Quick Start

### 1. Install Required Packages

```bash
brew install coreutils lsd zsh
```

### 2. (Optional) Install Developer Tools

Recommended if you work with Python, Node, or Poetry:

```bash
brew install pyenv nvm poetry
```

### 3. Clone the Repository and Set Up

```bash
git clone https://github.com/yellow-pine/zsh-github-dark.git
cd zsh-github-dark
cp src/.zshrc ~/.zshrc
exec zsh
```

### 4. Import the Terminal Profile

Terminal profile: Double-click `src/github-dark.terminal` to import it, then set
it as your default under **Terminal Settings → Profiles → Default**.

✅ You are now fully set up!

## 🛠 Features

- GitHub Dark-optimized zsh prompt
- Git branch awareness, last command timing, and error status
- Human-readable `lsd` output with matching color theme
- No plugins, no bloated frameworks — pure native zsh

## 🎨 Terminal Theme Details

- Based on [GitHub Dark](https://terminalcolors.com/themes/github/dark/)
- Minor Yellow Pine customizations:
  - Font size set to 12
  - Background opacity set to 85%
  - Cursor color changed to match Bold Text instead of orange
- Provided file: `src/github-dark.terminal`

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
