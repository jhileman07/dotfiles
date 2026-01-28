# Dotfiles

My configuration environment, managed with **GNU Stow** and **Git Submodules**.

## Installation

### 1. Clone the Repository

Clone recursively to pull down the repo, Oh My Zsh, themes, and plugins in one single command.

```bash
git clone --recursive git@github.com:jhileman07/dotfiles.git ~/dotfiles

```

### 2. Clean Default Configs

If the OS created default config files (like `.bashrc` or `.zshrc`), delete them so Stow can replace them with symlinks.

```bash
rm -rf ~/.zshrc ~/.bashrc ~/.bash_profile ~/.oh-my-zsh

```

### 3. Stow Packages

Symlink the configurations to your home directory.

```bash
cd ~/dotfiles
stow */

```

### 4. Finalize

**A. Create Local Secrets**
Create the machine-specific secrets file (ignored by git).

```bash
touch ~/.zshrc.local
# Add: export GITHUB_TOKEN="your_token_here"

```

**B. Initialize Tmux Plugins**

1. Start tmux: `tmux`
2. Press `Prefix` + `I` (Capital `i`) to install the plugins via TPM.

**C. Set Default Shell**

```bash
chsh -s $(which zsh)
exec zsh

```

---

## 📂 How It Works

### Submodule Architecture

I use **Git Submodules** for all dependencies. This ensures 100% reproducibility without relying on external install scripts.

* **Shell:** `zsh/.oh-my-zsh` → Symlinked to `~/.oh-my-zsh`.
* **Plugins:** `zsh/custom/` → Pointed to by `$ZSH_CUSTOM` in `.zshrc`.
* **Tmux:** `tmux/.config/tmux/plugins/tpm` → Symlinked to `~/.config/tmux/plugins/tpm`.

### The "Clean Home" Strategy

* **Zsh Plugins:** The `zsh/custom` directory is **ignored** by Stow (via `.stow-local-ignore`) so it doesn't pollute `~`. The `.zshrc` points directly to the repo path.
* **Tmux Plugins:** The `plugins/` folder in Tmux contains a `.gitignore` that ignores everything except the TPM submodule. This keeps the repo clean while allowing TPM to download plugins freely.

---

## Management

### Adding a New Zsh Plugin

1. Add it as a submodule:
```bash
cd ~/dotfiles
git submodule add git@github.com:username/repo.git zsh/custom/plugins/repo

```


2. Add `repo` to the `plugins=(...)` list in `zsh/.zshrc`.
3. Commit changes.

### Updating Everything

Update the repo and all submodules (OMZ, themes, plugins) to their latest remote versions:

```bash
git pull
git submodule update --remote --merge

```
