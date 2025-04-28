# 🛠 Contributing to zsh-github-dark

Thanks for considering contributing!
We keep things simple and clean — here’s how you can help:

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

> **Note:** Linting and syntax checking (`zsh -n` and `shellcheck`) are handled
> automatically by GitHub Actions CI.

---

### 🔹 Optional: Pre-Commit Hook for Auto-Formatting

To automatically format `src/.zshrc` before every commit, run the provided setup
script:

```bash
scripts/setup.sh
```

This will install the pre-commit hook automatically.
It ensures that all committed changes stay consistent with our formatting
standards without manual intervention.

---

## 🛡 License

By contributing, you agree that your code will be licensed under the [MIT License](LICENSE).

---

Thank you for helping make this project better!
Built with 💛 by [Yellow Pine](https://github.com/yellow-pine).
