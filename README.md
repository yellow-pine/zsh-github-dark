# zsh-github-dark

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/Shell-Zsh-89e051)](https://www.zsh.org/)
[![Crafted with 💛 by Yellow Pine](https://img.shields.io/badge/Crafted%20with-%F0%9F%92%9B%20by%20Yellow%20Pine-ffcc00)](https://github.com/yellow-pine)

Minimalistic macOS zsh and Terminal configuration optimized for GitHub Dark themes.  
Designed for clarity, speed, and a visually cohesive development environment.

## 🚀 Quick Start

```bash
# Install required packages first

brew install coreutils lsd eza zsh

# (Optional but recommended for developers)

brew install pyenv nvm poetry

# Clone and set up

git clone <https://github.com/yellow-pine/zsh-github-dark.git>
cd zsh-github-dark
cp src/.zshrc ~/.zshrc
exec zsh
```

✅ You are now fully set up!

## 🛠 Requirements Before Installation

Make sure the following tools are installed (via Homebrew preferred):

```bash
brew install coreutils lsd eza zsh
```

If you work with Node.js, Python, or GitHub daily, it's also recommended to install:

```bash
brew install pyenv nvm poetry
```

## 📦 Full Installation Steps

1. **Install required packages (if not already installed):**

    ```bash
    brew install coreutils lsd eza zsh
    brew install pyenv nvm poetry  # optional but recommended
    ```

1. **Clone the repository:**

    ```bash
    git clone <https://github.com/yellow-pine/zsh-github-dark.git>
    cd zsh-github-dark
    ```

1. **Copy the `.zshrc` into your home directory:**

    ```bash
    cp src/.zshrc ~/.zshrc
    ```

1. **Import the Terminal profile:**

    - Open Terminal ➔ Settings ➔ Profiles ➔ Import
    - Select the file `src/github-dark.terminal`
    - Set it as the Default profile if desired

1. **Reload your shell:**

    ```bash
    exec zsh
    ```

## ✨ Features

- GitHub Dark-optimized zsh prompt
- Git branch awareness, last command timing, and error status
- Human-readable `lsd` output with matching color theme
- Clean handling of personal vs. organizational Git identities
- No plugins, no bloated frameworks — pure native zsh

## 🌐 Project Structure

```plaintext
zsh-github-dark/
├── src/
│   ├── .zshrc                  # The main zsh configuration
│   └── github-dark.terminal    # The customized Terminal profile
├── README.md
├── LICENSE
├── .gitignore
```

## 📫 Contact

For feedback, ideas, or contributions:  
**<hello@yellowpine.com>**

## ⚡ License

This project is licensed under the [MIT License](LICENSE) — free for personal and commercial use.  
Authored and maintained by **Cansin Yildiz**.
