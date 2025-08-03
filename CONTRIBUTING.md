# Contributing to zsh-github-dark

Thanks for your interest in contributing! This project follows a simplicity-first approach.

## How to Contribute

1. **Report issues** - Found a bug or have an idea? [Open an issue](https://github.com/yellow-pine/zsh-github-dark/issues)
2. **Submit pull requests** - Fork the repo and submit focused changes
3. **Keep it minimal** - This project values simplicity over features

## Development Setup

### Required Tools

Install the formatting tool:

```bash
brew install shfmt
```

### Pre-commit Hook (Optional)

Automatically format code before commits:

```bash
cp git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### Testing Changes

Before submitting a PR:

```bash
# Run full test suite (42 tests)
./run-tests.sh

# Check syntax manually
zsh -n src/.zshrc

# Verify formatting
shfmt -d src/.zshrc

# Test locally
source src/.zshrc
```

## Code Guidelines

- **Keep `.zshrc` minimal** - No unnecessary frameworks or complexity
- **Follow existing patterns** - Match the current code style
- **No new dependencies** - Unless absolutely essential
- **Test thoroughly** - Ensure colors and prompt work correctly

## Development Philosophy

This project intentionally avoids:
- Plugin systems or frameworks
- Configuration files or customization options  
- Multiple terminal emulator support
- Advanced features that add complexity

We focus on providing one excellent default experience.

## Recommended Editor Extensions

For VSCode/Cursor:
- Shell Format (foxundermoon.shell-format)
- EditorConfig (editorconfig.editorconfig)
- Markdownlint (davidanson.vscode-markdownlint)

## Project Commands

See [CLAUDE.md](CLAUDE.md) for the complete list of development commands and project documentation.

## License

By contributing, you agree your code will be licensed under the [MIT License](LICENSE).
