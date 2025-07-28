# TODO

Potential improvements for zsh-github-dark project, organized by category.

## 🔧 Implementation Improvements

### Shell Script Robustness

- [x] **Validate git repository in setup.sh**
  - Check if `.git` directory exists before copying hooks
  - Exit gracefully with helpful error message if not in a git repo

  ```bash
  if [ ! -d ".git" ]; then
    echo "❌ Error: Not a git repository. Please run from project root."
    exit 1
  fi
  ```

- [x] **Add shfmt validation in pre-commit hook**
  - Check if `shfmt` is installed before attempting to format
  - Provide installation instructions if missing

  ```bash
  if ! command -v shfmt &> /dev/null; then
    echo "❌ shfmt not found. Install with: brew install shfmt"
    exit 1
  fi
  ```

- [x] **Handle existing git hooks**
  - Check for existing pre-commit hooks
  - Offer to backup or merge with existing hooks
  - Add option to force overwrite with `-f` flag

### Performance Optimizations

- [x] **Replace bc with native zsh arithmetic**
  - Use zsh's built-in floating point math instead of bc dependency
  - Example: `(( delta = EPOCHREALTIME - __TIMER_START ))`
  - Remove bc from prerequisites

- [x] **Optimize git branch detection**
  - Cache git branch status between prompts
  - Only refresh on directory change or after git commands
  - Use git's `__git_ps1` function if available for better performance

- [x] **Speed up zsh startup with compinit -C**
  - Add `-C` flag to skip security checks on trusted systems
  - Document security implications in comments
  - Make it configurable via environment variable

### Missing Automation

- [x] **Create Terminal profile installer**
  - Script to programmatically import terminal profile
  - Use `osascript` to automate Terminal.app configuration
  - Handle existing profiles gracefully

- [x] **Automate manual setup steps**
  - Script to create `~/.nvm` directory
  - Automate shell change with proper permission handling
  - Verify and set up all prerequisites

## 📦 Packaging Improvements

### Distribution Methods

- [x] **Create Homebrew formula**
  - Write formula for homebrew-tap
  - Handle dependencies automatically
  - Simplify installation to `brew install zsh-github-dark`

- [x] **Create comprehensive installer script**
  - Single command installation: `curl -fsSL ... | bash`
  - Interactive mode for customization
  - Dry-run option to preview changes

### Dependency Management

- [x] **Add dependency checker script**
  - Check for all required tools (coreutils, lsd, zsh)
  - Offer to install missing dependencies via Homebrew
  - Version compatibility checks

- [x] **Document system requirements**
  - Minimum macOS version (test on older versions)
  - Apple Silicon vs Intel compatibility notes
  - Homebrew installation prerequisites

### Configuration Management

- [x] **Add color customization support**
  - Environment variables for all color values
  - Example: `ZGD_PROMPT_COLOR`, `ZGD_BRANCH_COLOR`
  - Configuration file support (~/.zsh-github-dark.conf)

- [ ] **Support multiple terminal emulators**
  - iTerm2 color scheme export
  - Alacritty configuration
  - Kitty terminal support
  - Generic terminal color codes

## 🧪 Testing Infrastructure

### Code Quality

- [ ] **Add shellcheck to CI pipeline**
  - Lint all shell scripts with shellcheck
  - Configure appropriate exclusions
  - Add shellcheck installation to CI

- [ ] **Create test suite**
  - Test prompt generation with different states
  - Verify git integration functionality
  - Test installation scripts in Docker containers

### Continuous Integration

- [ ] **Expand CI matrix**
  - Test on multiple macOS versions
  - Test both Intel and Apple Silicon (if possible)
  - Add installation tests

## 📚 Documentation Enhancements

### Visual Documentation

- [ ] **Add comprehensive screenshots**
  - Normal prompt state
  - Error state (red prompt)
  - Git dirty state (with asterisk)
  - Long command timing display
  - Root user prompt

### User Guides

- [ ] **Create FAQ section**
  - Common installation issues
  - Troubleshooting guide
  - Performance tuning tips

- [ ] **Add uninstall instructions**
  - Clean removal steps
  - How to revert to default shell settings
  - Backup restoration guide

### Developer Documentation

- [ ] **Document contribution workflow**
  - How to test changes locally
  - Code style guidelines for shell scripts
  - PR review checklist

## 🔒 Security Enhancements

### Security Hardening

- [ ] **Add security checks**
  - Validate all file paths before operations
  - Add checksum verification for downloads
  - Implement proper error handling for all file operations

- [ ] **Create security policy**
  - Document security considerations
  - Add SECURITY.md best practices
  - GPG signing for releases

## 🎯 Future Features

### Advanced Features

- [ ] **Plugin system**
  - Allow custom prompt segments
  - Support for additional VCS (mercurial, svn)
  - Extensible alias system

- [ ] **Theme variants**
  - GitHub Light theme option
  - High contrast variant
  - Custom theme builder

### Integration Features

- [ ] **IDE integration**
  - VS Code integrated terminal configuration
  - JetBrains IDE terminal setup
  - Sublime Text terminal configuration
