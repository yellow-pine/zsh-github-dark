# zsh-github-dark

A comprehensive zsh configuration with GitHub Dark terminal theme for macOS developers.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash
```

## What You Get

- **Beautiful GitHub Dark terminal colors** - Custom Terminal profile optimized for dark themes
- **Git-aware prompt** - Shows branch name, dirty state, and command timing
- **Enhanced directory listings** - `lsd` with colors and better formatting (ls, ll, la aliases)
- **Developer-friendly history** - 10,000 command history with deduplication and sharing
- **Tool integrations** - Safe support for pyenv, nvm, and poetry when installed
- **Optimized for GitHub Dark** - Colors and prompt designed for the GitHub Dark aesthetic

## Requirements

- macOS 10.15+
- Homebrew
- Terminal.app

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/yellow-pine/zsh-github-dark/main/install.sh | bash -s -- --uninstall
```

## Testing

This project includes comprehensive test coverage for all user-facing functionality:

```bash
./run-tests.sh
```

**42 comprehensive tests** covering:

- One-line installer (help, dry-run, uninstall, error handling)
- Shell configuration (aliases, git integration, prompt, key bindings)
- Terminal profile (XML validation, color definitions)

**Platform compatibility**: Tests run on both macOS (primary target) and Ubuntu (CI environment), with platform-appropriate validation methods.

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup.

## Help

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues.

## License

MIT © Cansin Yildiz
