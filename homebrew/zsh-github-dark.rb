class ZshGithubDark < Formula
  desc "Minimalistic macOS zsh and Terminal configuration optimized for GitHub Dark themes"
  homepage "https://github.com/yellow-pine/zsh-github-dark"
  url "https://github.com/yellow-pine/zsh-github-dark/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/yellow-pine/zsh-github-dark.git", branch: "main"

  depends_on "coreutils"
  depends_on "lsd"
  depends_on "zsh"
  depends_on :macos

  def install
    # Install scripts
    bin.install "scripts/full-setup.sh" => "zsh-github-dark-setup"
    bin.install "scripts/install-terminal-profile.sh" => "zsh-github-dark-terminal"
    
    # Install the .zshrc to share directory
    (share/"zsh-github-dark").install "src/.zshrc"
    
    # Install the terminal profile
    (share/"zsh-github-dark").install "src/github-dark.terminal"
    
    # Install documentation
    doc.install "README.md", "CONTRIBUTING.md", "TROUBLESHOOTING.md"
    
    # Create a wrapper script that references the installed files
    (bin/"zsh-github-dark-init").write <<~EOS
      #!/bin/bash
      set -e
      
      SHARE_DIR="#{share}/zsh-github-dark"
      
      echo "🚀 zsh-github-dark Homebrew Installation"
      echo ""
      
      # Check if .zshrc already exists
      if [ -f "$HOME/.zshrc" ]; then
        echo "⚠️  Existing .zshrc found"
        read -p "Backup to ~/.zshrc.backup? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
          echo "✅ Backed up existing .zshrc"
        fi
      fi
      
      # Copy .zshrc
      cp "$SHARE_DIR/.zshrc" "$HOME/.zshrc"
      echo "✅ Installed .zshrc"
      
      # Import terminal profile
      echo ""
      read -p "Import GitHub Dark Terminal profile? (y/n) " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "$SHARE_DIR/github-dark.terminal"
        echo "✅ Terminal profile imported"
        echo ""
        echo "Set it as default in Terminal → Settings → Profiles"
      fi
      
      echo ""
      echo "✅ Setup complete! Open a new terminal to see changes."
      echo ""
      echo "For full setup with all options, run: zsh-github-dark-setup"
    EOS
    
    # Make the wrapper executable
    chmod 0755, bin/"zsh-github-dark-init"
  end

  def caveats
    <<~EOS
      To get started with zsh-github-dark:
      
        zsh-github-dark-init
      
      This will install the .zshrc and optionally import the Terminal profile.
      
      For a full guided setup including optional dependencies:
      
        zsh-github-dark-setup
      
      To only install the Terminal profile:
      
        zsh-github-dark-terminal
      
      Optional: For faster startup on trusted systems, add to your environment:
      
        export ZSH_DISABLE_COMPFIX=true
    EOS
  end

  test do
    # Test that the formula installed the files correctly
    assert_predicate share/"zsh-github-dark/.zshrc", :exist?
    assert_predicate share/"zsh-github-dark/github-dark.terminal", :exist?
    assert_predicate bin/"zsh-github-dark-init", :exist?
    assert_predicate bin/"zsh-github-dark-setup", :exist?
    assert_predicate bin/"zsh-github-dark-terminal", :exist?
    
    # Test that zsh can parse the .zshrc without errors
    system "zsh", "-n", share/"zsh-github-dark/.zshrc"
  end
end