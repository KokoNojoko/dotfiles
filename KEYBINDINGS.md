# Keybindings Cheat Sheet

Quick reference for all custom keybindings across the dotfiles setup.

---

## Neovim / LazyVim

### General

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+S` | n/i/v | Save file |
| `Ctrl+Shift+S` | n/i/v | Save all files |
| `Ctrl+Q` | n | Quit all (exit nvim) |
| `leader+Q` | n | Quit all (alternative) |
| `leader+W` | n | Save and close buffer |
| `leader+qq` | n | Quit all windows |

### File Explorer (Neo-tree)

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+B` | n | Toggle file explorer |
| `Ctrl+E` | n | Toggle file explorer |
| `leader+e` | n | Toggle file explorer (LazyVim default) |

### Buffers

| Keybind | Mode | Action |
|---------|------|--------|
| `Shift+H` | n | Previous buffer |
| `Shift+L` | n | Next buffer |
| `leader+bd` | n | Delete buffer |
| `leader+bD` | n | Delete buffer (force) |

### Formatting

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+Shift+F` | n/v | Format file (VS Code style) |
| `Alt+Shift+F` | n/v | Format file (terminal fallback) |
| `leader+cf` | n/v | Format file (LazyVim default) |

### Copilot & AI

| Keybind | Mode | Action |
|---------|------|--------|
| `Tab` | i | Accept Copilot suggestion |
| `Alt+]` | i | Next Copilot suggestion |
| `Alt+[` | i | Previous Copilot suggestion |
| `Ctrl+]` | i | Dismiss Copilot suggestion |
| `leader+cc` | n/v | Toggle Copilot Chat |
| `leader+ce` | n/v | Explain code |
| `leader+cr` | n/v | Review code |
| `leader+ct` | n/v | Generate tests |
| `leader+cm` | n | Generate commit message |

### Search & Navigation (LazyVim defaults)

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+ff` | n | Find files |
| `leader+fg` | n | Live grep |
| `leader+fb` | n | Find buffers |
| `leader+fr` | n | Recent files |
| `leader+/` | n | Search in current buffer |
| `gd` | n | Go to definition |
| `gr` | n | Go to references |
| `K` | n | Hover documentation |

### Windows & Splits

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+h/j/k/l` | n | Navigate between windows |
| `leader+-` | n | Split horizontal |
| `leader+\|` | n | Split vertical |
| `leader+wd` | n | Delete window |

### LSP

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+ca` | n/v | Code actions |
| `leader+cr` | n | Rename symbol |
| `leader+cd` | n | Line diagnostics |
| `[d` / `]d` | n | Previous/next diagnostic |

---

## Tmux

### Prefix Key
Default prefix: `Ctrl+B`

### Session Management

| Keybind | Action |
|---------|--------|
| `prefix+d` | Detach from session |
| `prefix+J` | Session switcher (fzf popup) |
| `prefix+K` | Kill sessions (fzf popup) |

### Windows

| Keybind | Action |
|---------|--------|
| `prefix+c` | Create new window |
| `prefix+n` | Next window |
| `prefix+p` | Previous window |
| `prefix+b` | Previous window (custom) |
| `Alt+H` | Previous window |
| `Alt+L` | Next window |
| `prefix+&` | Kill window |
| `prefix+,` | Rename window |

### Panes

| Keybind | Action |
|---------|--------|
| `prefix+"` | Split horizontal (path-aware) |
| `prefix+%` | Split vertical (path-aware) |
| `prefix+h/j/k/l` | Navigate panes (vim-style) |
| `prefix+Up/Down/Left/Right` | Resize panes |
| `prefix+x` | Kill pane |
| `prefix+z` | Toggle pane zoom |

### Copy Mode (Vi)

| Keybind | Action |
|---------|--------|
| `prefix+[` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection |
| `q` | Exit copy mode |

### Popup Tools

| Keybind | Action |
|---------|--------|
| `prefix+g` | LazyGit popup |
| `prefix+d` | LazyDocker popup |
| `prefix+s` | LazySQL popup |
| `prefix+f` | Tool launcher (fzf) |

### Menu

| Keybind | Action |
|---------|--------|
| `prefix+m` | Dotfiles menu |
| `prefix+r` | Reload tmux config |

---

## Zsh

### Aliases

| Alias | Command |
|-------|---------|
| `lg` | lazygit |
| `ld` | lazydocker |
| `zshconfig` | Edit .zshrc in nvim |
| `zshreload` | Reload .zshrc |
| `tmuxreload` | Reload tmux config |
| `nvimconfig` | Edit nvim config |

### WSL-Specific Aliases

| Alias | Command |
|-------|---------|
| `explorer` | Open Windows Explorer |
| `open` | Open Windows Explorer |
| `winopen` | Open current dir in Explorer |
| `clip` | Copy to Windows clipboard |
| `cdwin` | Navigate to Windows home |
| `pwsh` | PowerShell |

### macOS-Specific Aliases

| Alias | Command |
|-------|---------|
| `ghosttycfg` | Edit Ghostty config |

---

## Notes

- `leader` in Neovim is `Space` by default in LazyVim
- `n` = normal mode, `i` = insert mode, `v` = visual mode
- `prefix` in tmux is `Ctrl+B` by default
- Some terminal emulators may not support `Ctrl+Shift+` combos; use `Alt+Shift+` alternatives
