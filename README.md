# zsh-github-dark

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Minimal GitHub Dark-optimized zsh configuration for developers, tuned for macOS + Homebrew.

---

## 📂 Files Included

- `.zshrc` – optimized for:
  - macOS ARM (M1/M2/M3)
  - Homebrew setups (`coreutils`, `pyenv`, `nvm`, `poetry`, `lsd`)
  - GitHub Dark Terminal Profile color-matching
  - Dynamic prompt (git branch, dirty marker, timing, exit code coloring)
  - Lightweight, fast loading (no oh-my-zsh or plugin frameworks)
- `github-dark.terminal` – matching Terminal.app profile (dark background, soft colors)

---

## 🚀 Quick Setup

1. Clone this repository:

   ```bash
   git clone <https://github.com/YOUR_USERNAME/zsh-github-dark.git>
   cd zsh-github-dark
   ```

2. Install the recommended Homebrew packages:

   ```bash
   brew install coreutils lsd bc pyenv nvm poetry
   ```

3. Copy the `.zshrc` to your home directory:

   ```bash
   cp .zshrc ~/.zshrc
   ```

4. Import `github-dark.terminal` into Terminal.app:
   - Open Terminal ➔ Settings ➔ Profiles ➔ Import ➔ select `github-dark.terminal`
   - Set it as the default profile.

5. Set `zsh` as your default shell:

   ```bash
   chsh -s /bin/zsh
   ```

6. Set `zsh` as root's shell to fix `sudo su -`:

   ```bash
   sudo chsh -s /bin/zsh root
   ```

7. Create the NVM working directory if missing:

   ```bash
   mkdir -p ~/.nvm
   ```

   ---

## 📋 Notes

- This setup is tuned for GitHub Dark themes.
- Lightweight, no plugin managers like oh-my-zsh.
- Safe for both interactive and root shells.
- Easy to extend if you want to add your own aliases, custom functions later.

---

## 🎨 Terminal Profile Source and Customizations

The included `github-dark.terminal` is based on:

- Original theme: [GitHub Dark – terminalcolors.com](https://terminalcolors.com/themes/github/dark/)

Custom modifications made:

- Font size set to **12 pt** for better readability.
- Background opacity adjusted to **85%** for a slightly translucent look.
- Cursor color changed to match **bold text color** (originally orange).

---

## 📜 License

MIT License – see [LICENSE](LICENSE) for full details.
