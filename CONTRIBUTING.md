# 🛠 Contributing to zsh-github-dark

Thanks for considering contributing! We keep things simple and clean —
here’s how you can help:

## ✨ How to Contribute

- Open an issue if you find a bug, improvement idea, or enhancement.
- Fork the repo and submit a pull request (PR).
- Keep changes small and focused.

## 🎯 Code Style

- Keep `.zshrc` readable and minimal — no unnecessary plugin frameworks.
- Follow existing file organization.
- No external dependencies unless absolutely necessary.

## 📦 Before Submitting a PR

- Test your changes locally.
- Make sure prompt rendering and terminal colors remain clean.

---

## 🛠 Developer Setup

To contribute cleanly to this project, we recommend setting up a local
environment with basic tooling.

### 🔹 Required Developer Tools

Please ensure you have the following installed locally:

- [`shfmt`](https://github.com/mvdan/sh) — for shell script formatting

Install it via Homebrew:

```bash
brew install shfmt
```

We use `shfmt` to automatically format `src/.zshrc` for consistency.

> **Note:** Syntax checking (`zsh -n`) and formatting validation (`shfmt -d`)
> are handled automatically by GitHub Actions CI.

---

### 🔹 Pre-Commit Hook Setup

To enable automatic formatting of `src/.zshrc` before every commit, manually copy the pre-commit hook:

```bash
cp git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
```

This ensures consistent formatting standards.

---

## 🧩 Recommended VSCode Extensions

To ensure a smooth development experience, we recommend installing the
suggested extensions when prompted by VSCode or Cursor:

- **Shell Format** (`foxundermoon.shell-format`) — Formats `.zshrc` cleanly
  using `shfmt`
- **EditorConfig** (`editorconfig.editorconfig`) — Ensures consistent
  formatting rules across different editors
- **Markdownlint** (`davidanson.vscode-markdownlint`) — Helps maintain clean
  and consistent Markdown style

These extensions are optional but highly recommended.

---

## 🛡 License

By contributing, you agree that your code will be licensed under the
[MIT License](LICENSE).

---

Thank you for helping make this project better! Built with 💛 by
[Yellow Pine](https://github.com/yellow-pine).
