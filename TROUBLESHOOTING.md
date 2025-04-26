# 🛠 Troubleshooting

Helpful tips if something doesn't work as expected.

---

## 🔵 Shell does not change after installation

Make sure you are actually running `zsh`.  
You can check your current shell:

```bash
echo $SHELL
```

If it is not `/bin/zsh`, you can switch:

```bash
chsh -s /bin/zsh
exec zsh
```

---

## 🔵 `ls` still looks boring / missing colors

This setup **relies on `lsd`** (a modern, colorful replacement for `ls`).

Make sure you have installed it:

```bash
brew install lsd
```

---

## 🔵 `brew` command not found

If you don't have Homebrew installed, install it first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then re-run the install steps.

---

## 🔵 Terminal colors look wrong or washed out

Make sure you have:

- Imported the `github-dark.terminal` profile into Terminal ➔ Settings ➔ Profiles
- Set it as your **default profile**
- Enabled **"Use colors from profile"** in Terminal settings

Then restart Terminal.

---

## 🔵 Root shell (`sudo su -`) does not have colors

By default, macOS root user (`sudo su -`) uses an old bash setup.  
To fix root's shell environment to match:

1. **Link your user `.zshrc` into root's home:**

    ```bash
    sudo ln -s /Users/$(whoami)/.zshrc /var/root/.zshrc
    ```

2. **Change root's default shell to zsh:**

    ```bash
    sudo chsh -s /bin/zsh root
    ```

After this, when you run `sudo su -`, you will see the correct colorful prompt and behavior.

---

## 🧹 Still stuck?

- Reload zsh manually:

    ```bash
    exec zsh
    ```

- Or restart your Terminal.

If the problem persists, please open an issue or contact: **<hello@yellowpine.com>**
