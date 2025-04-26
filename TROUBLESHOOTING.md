# 🛠 Troubleshooting

Helpful tips if something doesn't work as expected.

## 🔵 Shell does not change after installation

Check your current shell:

```bash
echo $SHELL
```

If it is not `/bin/zsh`, switch to zsh:

```bash
chsh -s /bin/zsh
exec zsh
```

## 🔵 `ls` still looks boring / missing colors

This setup uses [`lsd`](https://github.com/lsd-rs/lsd) instead of the system `ls`.

Install it if missing:

```bash
brew install lsd
```

## 🔵 `brew` command not found

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"
```

Then re-run the install steps.

## 🔵 Terminal colors look wrong or washed out

- Import the `github-dark.terminal` profile into Terminal ➔ Settings ➔ Profiles
- Set it as your **default profile**
- Enable **"Use colors from profile"** in Terminal Settings

Then restart Terminal.

## 🔵 Root shell (`sudo su -`) does not have colors

By default, macOS root uses bash.

Fix it by:

Linking your `.zshrc`:

```bash
sudo ln -sf /Users/$(whoami)/.zshrc /var/root/.zshrc
```

Changing root's shell:

```bash
sudo chsh -s /bin/zsh root
```

Now `sudo su -` will match your regular environment.

## 🧹 Still stuck?

- Reload zsh manually:

```bash
exec zsh
```

- Or restart Terminal completely.

If the issue persists, contact **<hello@yellowpine.com>**.
