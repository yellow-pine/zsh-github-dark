# Troubleshooting

Common issues and solutions for zsh-github-dark.

## Installation Issues

### Command not found errors

**Problem**: `curl: command not found` or `git: command not found`  
**Solution**: Install Xcode Command Line Tools:
```bash
xcode-select --install
```

**Problem**: `brew: command not found`  
**Solution**: The installer will automatically install Homebrew, or install manually from https://brew.sh

### Permission errors

**Problem**: Permission denied during installation  
**Solution**: Don't use `sudo`. The installer handles permissions correctly.

## Display Issues

### Colors look wrong or missing

**Problem**: Terminal shows wrong colors or no colors  
**Solution**: 
1. Open Terminal → Preferences → Profiles
2. Select "GitHub Dark" profile 
3. Click "Default" button to make it the default

### Broken characters or symbols

**Problem**: Prompt shows weird characters  
**Solution**: Install a font that supports Unicode symbols, or the GitHub Dark profile should handle this automatically.

## Command Issues

### Missing commands after installation

**Problem**: `lsd` or other commands not found  
**Solution**: The installer handles all dependencies. If issues persist:
```bash
brew install lsd coreutils
```

### Git integration not working

**Problem**: Git branch not showing in prompt  
**Solution**: Make sure you're in a git repository and that git is installed.

## Nuclear Option

If nothing else works, start completely fresh:

```bash
# Remove everything
rm ~/.zshrc ~/.zshrc.backup
rm -rf ~/.zsh-github-dark

# Reinstall
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash
```

## Getting Help

Still having issues? [Open an issue](https://github.com/yellow-pine/zsh-github-dark/issues) with:
- Your macOS version
- Terminal.app version 
- Full error message
- Output of `echo $SHELL` and `which zsh`