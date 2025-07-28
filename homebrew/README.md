# Homebrew Formula for zsh-github-dark

This directory contains the Homebrew formula for installing zsh-github-dark.

## Installation

To install via Homebrew tap (when published):

```bash
brew tap yellow-pine/tap
brew install zsh-github-dark
```

## Local Testing

To test the formula locally before publishing:

```bash
# From the project root
brew install --build-from-source homebrew/zsh-github-dark.rb
```

## Publishing

To publish this formula:

1. Create a new repository called `homebrew-tap` under the yellow-pine organization
2. Copy this formula to the `Formula` directory in that repository
3. Update the URL and SHA256 in the formula for each release
4. Users can then install with `brew tap yellow-pine/tap && brew install zsh-github-dark`

## Formula Details

The formula:
- Installs all required dependencies (coreutils, lsd, zsh)
- Provides three commands:
  - `zsh-github-dark-init`: Quick setup of .zshrc and terminal profile
  - `zsh-github-dark-setup`: Full interactive setup
  - `zsh-github-dark-terminal`: Terminal profile installation only
- Installs files to proper Homebrew locations
- Includes comprehensive tests