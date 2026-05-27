# Keybindings Cheat Sheet

Quick reference for all custom keybindings across the dotfiles setup.

---

## Neovim / LazyVim

### General

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+S` | n/i/v | Save file |
| `Ctrl+B` | n | Toggle file explorer (Neo-tree) |
| `Ctrl+\` | t | Close terminal |

### Movement

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl+D` | n | Scroll down (centered) |
| `Ctrl+U` | n | Scroll up (centered) |
| `n` / `N` | n | Next/prev search result (centered) |
| `Ctrl+H/J/K/L` | n | Navigate between splits |

### Editing

| Keybind | Mode | Action |
|---------|------|--------|
| `J` | v | Move selection down |
| `K` | v | Move selection up |
| `J` | n | Join lines (cursor stays) |
| `leader+p` | x | Paste without overwriting register |
| `leader+d` | n/v | Delete to void register |
| `leader+sr` | n | Replace word under cursor (global) |

### Formatting

| Keybind | Mode | Action |
|---------|------|--------|
| `Alt+Shift+F` | n/v | Format file |
| `leader+cf` | n/v | Format file (LazyVim default) |

### Harpoon

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+a` | n | Add file to Harpoon list |
| `Ctrl+N` | n | Toggle Harpoon menu |
| `leader+1-5` | n | Jump to Harpoon file 1–5 |

### Quickfix

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+qn` | n | Next quickfix item |
| `leader+qp` | n | Prev quickfix item |

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

### Buffers (LazyVim defaults)

| Keybind | Mode | Action |
|---------|------|--------|
| `Shift+H` | n | Previous buffer |
| `Shift+L` | n | Next buffer |
| `leader+bd` | n | Delete buffer |

### LSP

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+ca` | n/v | Code actions |
| `leader+cA` | n | Source actions |
| `leader+cd` | n | Line diagnostics |
| `[d` / `]d` | n | Previous/next diagnostic |

### Splits (LazyVim defaults)

| Keybind | Mode | Action |
|---------|------|--------|
| `leader+-` | n | Split horizontal |
| `leader+\|` | n | Split vertical |
| `leader+wd` | n | Delete window |

---

## Tmux

### Prefix Key
Custom prefix: `Ctrl+Z`

### Session Management

| Keybind | Action |
|---------|--------|
| `prefix+d` | Detach from session |
| `prefix+$` | Rename session |
| `prefix+J` | Session switcher (fzf popup) |
| `prefix+K` | Kill sessions (fzf popup) |

### Windows

| Keybind | Action |
|---------|--------|
| `prefix+c` | Create new window |
| `prefix+b` | Previous window |
| `prefix+,` | Rename window |
| `prefix+&` | Kill window |
| `Alt+H` | Previous window |
| `Alt+L` | Next window |

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
| `y` | Copy selection (+ clipboard) |
| `q` | Exit copy mode |

### Popup Tools

| Keybind | Action |
|---------|--------|
| `prefix+g` | LazyGit popup |
| `prefix+D` | LazyDocker popup |
| `prefix+s` | LazySQL popup |
| `prefix+f` | Tool launcher (fzf) |

### Config & Menu

| Keybind | Action |
|---------|--------|
| `prefix+M` | Dotfiles menu (.zshrc / tmux.conf.local) |
| `prefix+r` | Reload tmux config |
| `prefix+m` | Toggle mouse on/off |

---

## Zsh

### Aliases

| Alias | Command |
|-------|---------|
| `lg` | lazygit |
| `ld` | lazydocker |
| `zshconfig` | Edit .zshrc in nvim |
| `zshreload` | Reload .zshrc |
| `tmuxconfig` | Edit tmux.conf.local in nvim |
| `nvimconfig` | Edit nvim config |
| `sonnet` | claude --model claude-sonnet-4-6 |
| `opus` | claude --model claude-opus-4-6 |

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

- `leader` in Neovim is `Space` (LazyVim default)
- `n` = normal mode, `i` = insert mode, `v` = visual/x mode, `t` = terminal mode
- `prefix` in tmux is `Ctrl+Z`
