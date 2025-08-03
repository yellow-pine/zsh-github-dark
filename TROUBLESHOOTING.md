# Troubleshooting

## Installation fails

**Problem**: `curl: command not found`
**Fix**: Install Xcode Command Line Tools: `xcode-select --install`

**Problem**: `brew: command not found`
**Fix**: Install Homebrew from <https://brew.sh>

## Prompt looks wrong

**Problem**: No colors or broken characters
**Fix**: Set Terminal → Preferences → Profiles → "GitHub Dark" as default

## Command not found: lsd

**Fix**: Run `brew install lsd`

## Still having issues?

1. Start fresh:

   ```bash
   rm ~/.zshrc
   rm -rf ~/.zsh-github-dark
   ```

2. Reinstall:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash
   ```
