# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project Overview

This is a minimalistic macOS zsh and Terminal configuration project optimized for
GitHub Dark themes. The project provides:

- A custom `.zshrc` configuration with GitHub Dark-optimized zsh prompt
- A Terminal profile (`github-dark.terminal`) with custom settings
- Developer setup automation scripts

## Common Commands

### Linting and Formatting

```bash
# Check syntax of .zshrc
zsh -n src/.zshrc

# Format .zshrc with shfmt
shfmt -w -i 2 src/.zshrc

# Check formatting without modifying
shfmt -d src/.zshrc
```

### Development Setup

```bash
# Install pre-commit hook for automatic formatting
cp git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

### CI/CD

The project uses GitHub Actions for continuous integration. The CI pipeline:

- Validates `.zshrc` syntax using `zsh -n`
- Checks formatting compliance using `shfmt -d`
- Verifies presence of required files

## Architecture

### Project Structure

- `install.sh` - One-line installer script
- `src/.zshrc` - Main zsh configuration file with prompt and git integration
- `src/github-dark.terminal` - macOS Terminal profile with GitHub Dark theme
- `git-hooks/pre-commit` - Auto-formats `.zshrc` before commits

### Key Components

The `.zshrc` file includes:

- Dynamic prompt with git branch awareness, command timing, and error status
- Color scheme optimized for GitHub Dark Terminal theme
- `lsd` aliases for enhanced directory listings

## MCP (Model Context Protocol) Support

This project includes GitHub MCP server configuration for enhanced Claude Code integration.

### Setup GitHub MCP (OAuth - Recommended)

1. **Copy the MCP configuration**:
   ```bash
   cp .claude_mcp_config.json.example .claude_mcp_config.json
   ```

2. **Add the MCP server to Claude Code**:
   ```bash
   claude mcp add github-oauth --config .claude_mcp_config.json
   ```

3. **Authenticate when prompted**:
   - Claude Code will prompt for GitHub OAuth authentication
   - No Personal Access Token required

4. **Use GitHub features in Claude Code**:
   - Reference issues/PRs: `@github what are the open issues?`
   - Create PRs: `@github create a pull request for this branch`
   - Review code: `@github review the changes in PR #123`

### Available GitHub MCP Tools

When configured, you'll have access to GitHub operations including:
- Repository management
- Issue and PR automation
- CI/CD workflow intelligence
- Code security analysis
- Team collaboration features

## Development Guidelines

### Code Style

- Keep `.zshrc` minimal and readable - no unnecessary plugin frameworks
- Use `shfmt` with 2-space indentation for shell script formatting
- Follow existing file organization patterns

### Testing Changes

Before submitting changes:

1. Test your modifications locally by sourcing the `.zshrc`
2. Ensure prompt rendering and terminal colors remain clean
3. Run `zsh -n src/.zshrc` to check syntax
4. Run `shfmt -d src/.zshrc` to verify formatting

### Recommended Tools

- Install `shfmt` for shell script formatting: `brew install shfmt`
- VSCode/Cursor extensions: Shell Format, EditorConfig, Markdownlint
