# zsh-github-dark

[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![💛 Yellow Pine](https://img.shields.io/badge/%F0%9F%92%9B%20Yellow%20Pine-gray.svg)](https://github.com/yellow-pine)

Minimalistic macOS zsh and Terminal configuration optimized for GitHub Dark themes.  
Designed for clarity, speed, and a visually cohesive development environment.

## 🎨 Terminal Preview

Here's a preview of the final setup:

![Terminal Preview](assets/terminal-preview.png)

## 🚀 Quick Start

Install required system packages:

```bash
brew install coreutils lsd zsh
```

(Optional, recommended for developers: Python, Node, and Poetry tools)

```bash
brew install pyenv nvm poetry
```

Clone and set up:

```bash
git clone https://github.com/yellow-pine/zsh-github-dark.git
cd zsh-github-dark
cp src/.zshrc ~/.zshrc
exec zsh
```

✅ You are now fully set up!

## 🛠 Features

- GitHub Dark-optimized zsh prompt
- Git branch awareness, last command timing, and error status
- Human-readable `lsd` output with matching color theme
- Clean handling of personal vs. organizational Git identities
- No plugins, no bloated frameworks — pure native zsh

## 🎨 Terminal Theme Details

- Based on [GitHub Dark](https://terminalcolors.com/themes/github/dark/)
- Minor Yellow Pine customizations:
  - Font size set to 12
  - Background opacity set to 85%
  - Cursor color changed to match Bold Text instead of orange
- Provided file: `src/github-dark.terminal`

## 🛠 Troubleshooting

If anything doesn't work as expected, please check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) first.

## 📫 Contact

For feedback, ideas, or contributions:  
**<hello@yellowpine.com>**

## ⚡ License

This project is licensed under the [MIT License](LICENSE).  
Authored and maintained by **Cansin Yildiz**.
