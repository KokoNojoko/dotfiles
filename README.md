# Dotfiles

Cross-platform terminal setup for **macOS**, **Linux**, and **WSL**. Includes Zsh, Tmux, Powerlevel10k, Neovim, and related configurations for a minimal, fast, and productive terminal workflow.

---

## Features

### Shell (Zsh)
- **Oh-My-Zsh** with Powerlevel10k theme
- OS detection (macOS/Linux/WSL) with platform-specific config
- **Fastfetch** system info on shell start
- Auto-start **tmux** session
- WSL-specific: Windows integration aliases (`explorer`, `clip`, `winopen`)

### Tmux
- **Popup windows** for LazyGit, LazyDocker, LazySQL
- **Vi-style keybindings** for pane navigation
- Mouse support with clipboard integration
- **Catppuccin Mocha** theme
- TPM (Tmux Plugin Manager) integration
- Cross-platform clipboard (pbcopy/clip.exe)

### Git
- `.gitconfig` with sensible defaults
- Work machine support (prompts for identity during install)

### Terminal
- **Ghostty** config (macOS)
- **Sketchybar** status bar (macOS) - spaces, music, battery, CPU, clock
- Windows Terminal compatible (WSL)

### Neovim
- Config directory ready for your setup
- Recommended: LazyVim, NvChad, or AstroNvim

---

## Quick Start

### Clone the repository

```bash
git clone git@github.com:your-username/dotfiles.git ~/Documents/dotfiles
cd ~/Documents/dotfiles
```

### Run the installer

```bash
chmod +x install.sh
./install.sh
```

The installer will:
1. Detect your OS (macOS/Linux/WSL)
2. Ask if this is a work machine (for git identity)
3. Install packages (brew/apt)
4. Install Oh-My-Zsh + Powerlevel10k
5. Install TPM + tmux plugins
6. Install Nerd Fonts (Linux/WSL)
7. Create symlinks to your home directory
8. Set Zsh as default shell

---

## WSL Setup

### Prerequisites
1. **Windows Terminal** (recommended)
2. **Ubuntu** from Microsoft Store
3. Run the installer inside WSL

### After Installation
1. **Install MesloLGS NF font in Windows**:
   - Download from [Powerlevel10k fonts](https://github.com/romkatv/powerlevel10k#fonts)
   - Install all 4 TTF files in Windows
   
2. **Configure Windows Terminal**:
   - Settings → Profiles → Ubuntu → Appearance
   - Set font to "MesloLGS NF"
   - Optional: Enable acrylic/transparency

3. **Restart your terminal**

### WSL-Specific Aliases
| Alias | Description |
|-------|-------------|
| `explorer` | Open Windows Explorer |
| `winopen` | Open current directory in Explorer |
| `clip` | Copy to Windows clipboard |
| `cdwin` | Navigate to Windows home folder |

---

## Post-Installation

### First tmux run
```bash
# Inside tmux, install plugins:
Ctrl+b I   # Capital I
```

### Customize prompt
```bash
p10k configure
```

### Editing dotfiles
Files are symlinked from `~/Documents/dotfiles` - edit there and changes apply immediately.

---

## Directory Structure

```
dotfiles/
├── zsh/
│   └── .zshrc          # Zsh configuration
├── tmux/
│   └── .tmux.conf      # Tmux configuration
├── p10k/
│   └── .p10k.zsh       # Powerlevel10k theme
├── git/
│   └── .gitconfig      # Git configuration
├── ghostty/
│   └── config          # Ghostty terminal (macOS)
├── sketchybar/
│   ├── sketchybarrc    # Main config
│   ├── variables.sh    # Colors and variables
│   ├── items/          # Bar item definitions
│   └── plugins/        # Scripts for each item
├── nvim/
│   └── (your config)   # Neovim configuration
├── scripts/
│   └── install.sh      # Additional scripts
└── install.sh          # Bootstrap installer
```

---

## Required Tools

Installed automatically by `install.sh`:
- zsh, tmux, neovim, git, curl, fzf
- lazygit, lazydocker, fastfetch
- ripgrep, fd
- sketchybar (macOS only)
- win32yank (WSL only)

---

## Notes

- Sensitive files (`.ssh/`, `.zsh_history`) are not tracked
- Work machines prompt for git identity (no credentials stored)
- WSL uses `clip.exe` for clipboard integration
- Popups require: lazygit, lazydocker, lazysql
