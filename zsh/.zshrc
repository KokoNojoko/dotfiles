export ZSH="$HOME/.oh-my-zsh"

# Lazy tool commands (fallback if not installed)
command -v lazygit >/dev/null 2>&1 || alias lazygit="echo 'lazygit not installed'"
command -v lazydocker >/dev/null 2>&1 || alias lazydocker="echo 'lazydocker not installed'"
command -v lazysql >/dev/null 2>&1 || alias lazysql="echo 'lazysql not installed'"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ================================
# Detect OS
# ================================
case "$OSTYPE" in
  darwin*)   export OS_TYPE="mac" ;;
  linux*)    
    if grep -qi microsoft /proc/version 2>/dev/null; then
      export OS_TYPE="wsl"
    else
      export OS_TYPE="linux"
    fi
    ;;
  *) export OS_TYPE="unknown" ;;
esac

# ================================
# Common Aliases
# ================================
alias zshconfig="nvim ~/.zshrc"
alias tmuxreload="tmux source ~/.tmux.conf"
alias zshreload="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="nvim ~/.config/nvim"
alias lg="lazygit"
alias ld="lazydocker"

# ================================
# OS-Specific Configuration
# ================================
if [[ "$OS_TYPE" == "mac" ]]; then
    # macOS-specific aliases
    alias ghosttycfg='nvim "$HOME/Library/Application Support/com.mitchellh.ghostty/config"'
    
    # .NET (macOS path)
    export DOTNET_ROOT="/usr/local/share/dotnet"
    export PATH="$DOTNET_ROOT:$PATH"
fi

if [[ "$OS_TYPE" == "wsl" ]]; then
    # WSL-specific aliases
    alias explorer="explorer.exe"
    alias open="explorer.exe"
    alias clip="clip.exe"
    alias pwsh="powershell.exe"
    
    # Open current directory in Windows Explorer
    alias winopen='explorer.exe $(wslpath -w .)'
    
    # .NET (Linux path)
    export DOTNET_ROOT="$HOME/.dotnet"
    export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"
    
    # Fix interop for some WSL setups
    export WSL_INTEROP_PATH="/run/WSL"
    
    # Windows home directory shortcut
    export WINHOME="/mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"
    alias cdwin='cd "$WINHOME"'
fi

if [[ "$OS_TYPE" == "linux" ]]; then
    # Native Linux config
    export DOTNET_ROOT="$HOME/.dotnet"
    export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"
fi

# ================================
# Path additions
# ================================
# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Neovim from /opt (for Linux appimage install)
[[ -d "/opt/nvim-linux64/bin" ]] && export PATH="/opt/nvim-linux64/bin:$PATH"

# ================================
# Powerlevel10k
# ================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ================================
# Fastfetch on shell start
# ================================
if command -v fastfetch &> /dev/null; then
  fastfetch
fi

# ================================
# Auto-start tmux
# ================================
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach || tmux new || echo "tmux failed, continuing in shell"
fi
