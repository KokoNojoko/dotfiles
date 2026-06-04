#!/usr/bin/env bash
set -e

# ================================
# Dotfiles Bootstrap Installer
# Cross-platform: macOS, Linux, WSL
# ================================

DOTFILES="$HOME/Documents/dotfiles"
OS="$(uname -s)"
IS_WSL=false
IS_WORK_MACHINE=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() { echo -e "${BLUE}▶${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# ================================
# Detect Environment
# ================================

if grep -qi microsoft /proc/version 2>/dev/null; then
    IS_WSL=true
fi

echo ""
echo "================================"
echo "  Dotfiles Bootstrap Installer"
echo "================================"
echo "OS: $OS | WSL: $IS_WSL"
echo ""

# ================================
# Ask: Work or Personal Machine?
# ================================

read -p "Is this a work machine? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    IS_WORK_MACHINE=true
fi

# ================================
# Package Manager Setup
# ================================

install_packages() {
    print_step "Installing packages..."

    if [[ "$OS" == "Darwin" ]]; then
        # macOS - use Homebrew
        if ! command -v brew &> /dev/null; then
            print_step "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        print_step "Installing Homebrew packages..."
        xargs brew install < "$DOTFILES/packages/brew.txt"
        print_step "Installing Homebrew cask apps..."
        xargs brew install --cask < "$DOTFILES/packages/brew-cask.txt"

    elif [[ "$OS" == "Linux" ]]; then
        # Linux/WSL - use apt (Ubuntu/Debian)
        if command -v apt &> /dev/null; then
            print_step "Updating apt..."
            sudo apt update

            print_step "Installing core packages..."
            xargs -a "$DOTFILES/packages/apt.txt" sudo apt install -y
            
            # Neovim (latest via appimage or PPA)
            print_step "Installing Neovim..."
            if ! command -v nvim &> /dev/null; then
                curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
                sudo rm -rf /opt/nvim
                sudo tar -C /opt -xzf nvim-linux64.tar.gz
                sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
                rm nvim-linux64.tar.gz
            fi
            
            # Lazygit
            print_step "Installing Lazygit..."
            if ! command -v lazygit &> /dev/null; then
                LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
                curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
                tar xf lazygit.tar.gz lazygit
                sudo install lazygit /usr/local/bin
                rm lazygit lazygit.tar.gz
            fi
            
            # Lazydocker
            print_step "Installing Lazydocker..."
            if ! command -v lazydocker &> /dev/null; then
                curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
            fi
            
            # Fastfetch
            print_step "Installing Fastfetch..."
            if ! command -v fastfetch &> /dev/null; then
                sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
                sudo apt update
                sudo apt install -y fastfetch || print_warning "Fastfetch install failed - optional"
            fi
            
            # WSL-specific: win32yank for clipboard
            if [[ "$IS_WSL" == true ]]; then
                print_step "Installing win32yank for clipboard support..."
                if ! command -v win32yank.exe &> /dev/null; then
                    curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
                    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
                    chmod +x /tmp/win32yank.exe
                    sudo mv /tmp/win32yank.exe /usr/local/bin/
                    rm /tmp/win32yank.zip
                fi

                # Windows apps via winget
                if command -v winget.exe &> /dev/null; then
                    print_step "Installing Windows apps via winget..."
                    while IFS= read -r app_id || [[ -n "$app_id" ]]; do
                        [[ -z "$app_id" || "$app_id" == \#* ]] && continue
                        winget.exe install --id "$app_id" -e \
                            --accept-package-agreements --accept-source-agreements \
                            --silent 2>/dev/null \
                            && print_success "winget: $app_id" \
                            || print_warning "winget: $app_id failed or already installed"
                    done < "$DOTFILES/packages/winget.txt"
                else
                    print_warning "winget.exe not found - skipping Windows app installs"
                fi
            fi
        else
            print_error "apt not found. Please install packages manually."
            exit 1
        fi
    fi
    
    print_success "Packages installed"
}

# ================================
# Oh-My-Zsh Installation
# ================================

install_oh_my_zsh() {
    print_step "Installing Oh-My-Zsh..."
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh-My-Zsh installed"
    else
        print_success "Oh-My-Zsh already installed"
    fi
}

# ================================
# Powerlevel10k Installation
# ================================

install_powerlevel10k() {
    print_step "Installing Powerlevel10k theme..."
    
    P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ ! -d "$P10K_DIR" ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        print_success "Powerlevel10k installed"
    else
        print_success "Powerlevel10k already installed"
    fi
}

# ================================
# Oh-My-Tmux
# ================================

install_oh_my_tmux() {
    print_step "Installing oh-my-tmux..."

    if [[ ! -f "$HOME/.tmux/.tmux.conf" ]]; then
        # Preserve existing plugins if ~/.tmux already exists
        if [[ -d "$HOME/.tmux/plugins" ]]; then
            cp -r "$HOME/.tmux/plugins" /tmp/tmux-plugins-backup
        fi
        rm -rf "$HOME/.tmux"
        git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
        if [[ -d /tmp/tmux-plugins-backup ]]; then
            mkdir -p "$HOME/.tmux/plugins"
            cp -r /tmp/tmux-plugins-backup/. "$HOME/.tmux/plugins/"
            rm -rf /tmp/tmux-plugins-backup
        fi
        print_success "oh-my-tmux installed"
    else
        print_success "oh-my-tmux already installed"
    fi
}

# ================================
# TPM (Tmux Plugin Manager)
# ================================

install_tpm() {
    print_step "Installing TPM (Tmux Plugin Manager)..."

    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$TPM_DIR" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
        print_success "TPM installed"
    else
        print_success "TPM already installed"
    fi
}

# ================================
# Catppuccin Tmux Theme
# ================================

install_catppuccin_tmux() {
    print_step "Installing Catppuccin tmux theme..."
    
    CATPPUCCIN_DIR="$HOME/.config/tmux/plugins/catppuccin"
    if [[ ! -d "$CATPPUCCIN_DIR" ]]; then
        mkdir -p "$HOME/.config/tmux/plugins"
        git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$CATPPUCCIN_DIR/tmux"
        print_success "Catppuccin tmux installed"
    else
        print_success "Catppuccin tmux already installed"
    fi
}

# ================================
# Nerd Font Installation (WSL/Linux)
# ================================

install_nerd_font() {
    if [[ "$OS" == "Linux" ]]; then
        print_step "Installing Nerd Font (MesloLGS NF)..."
        
        FONT_DIR="$HOME/.local/share/fonts"
        if [[ ! -f "$FONT_DIR/MesloLGS NF Regular.ttf" ]]; then
            mkdir -p "$FONT_DIR"
            cd "$FONT_DIR"
            curl -fLO "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
            curl -fLO "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
            curl -fLO "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
            curl -fLO "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
            fc-cache -fv
            cd - > /dev/null
            print_success "Nerd Font installed"
            
            if [[ "$IS_WSL" == true ]]; then
                print_warning "WSL: You also need to install MesloLGS NF in Windows"
                print_warning "Download from: https://github.com/romkatv/powerlevel10k#fonts"
                print_warning "Then set it in Windows Terminal settings"
            fi
        else
            print_success "Nerd Font already installed"
        fi
    fi
}

# ================================
# Symlink Dotfiles
# ================================

link_dotfiles() {
    print_step "Linking dotfiles..."
    
    # Zsh
    ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
    print_success "Linked .zshrc"
    
    # Powerlevel10k config
    ln -sf "$DOTFILES/p10k/.p10k.zsh" "$HOME/.p10k.zsh"
    print_success "Linked .p10k.zsh"
    
    # Tmux: ~/.tmux.conf must point to oh-my-tmux base; ~/.tmux.conf.local holds customizations
    ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$DOTFILES/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
    print_success "Linked .tmux.conf (oh-my-tmux base) and .tmux.conf.local"
    
    # Neovim config
    mkdir -p "$HOME/.config"
    if [[ -d "$DOTFILES/nvim" ]]; then
        # Remove existing dir/symlink so ln -sf creates the symlink at the right level
        rm -rf "$HOME/.config/nvim"
        ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
        print_success "Linked nvim config"
    else
        print_warning "No nvim config in dotfiles - skipping"
    fi
    
    # Ghostty (macOS only)
    if [[ "$OS" == "Darwin" ]]; then
        GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
        mkdir -p "$GHOSTTY_DIR"
        ln -sf "$DOTFILES/ghostty/config" "$GHOSTTY_DIR/config"
        print_success "Linked Ghostty config"
    fi
    
    # Shared theme files (macOS only)
    if [[ "$OS" == "Darwin" ]]; then
        mkdir -p "$HOME/.config"
        ln -sf "$DOTFILES/colors.sh" "$HOME/.config/colors.sh"
        ln -sf "$DOTFILES/icons.sh" "$HOME/.config/icons.sh"
        print_success "Linked shared theme files (colors.sh, icons.sh)"

        # Sketchybar (top bar)
        rm -rf "$HOME/.config/sketchybar"
        ln -sf "$DOTFILES/sketchybar" "$HOME/.config/sketchybar"
        print_success "Linked Sketchybar config"

        # Bottombar (bottom bar — second sketchybar instance)
        rm -rf "$HOME/.config/bottombar"
        ln -sf "$DOTFILES/bottombar" "$HOME/.config/bottombar"
        print_success "Linked Bottombar config"

        # Create bottombar symlink if it doesn't exist
        if command -v sketchybar &> /dev/null && ! command -v bottombar &> /dev/null; then
            SKETCHYBAR_PATH=$(which sketchybar)
            sudo ln -sf "$SKETCHYBAR_PATH" /usr/local/bin/bottombar
            print_success "Created bottombar symlink"
        fi
    fi
}

# ================================
# Git Configuration
# ================================

configure_git() {
    print_step "Configuring Git..."
    
    if [[ "$IS_WORK_MACHINE" == true ]]; then
        echo ""
        print_warning "Work machine detected - please enter your work git identity:"
        read -p "  Git name: " GIT_NAME
        read -p "  Git email: " GIT_EMAIL
        
        git config --global user.name "$GIT_NAME"
        git config --global user.email "$GIT_EMAIL"
        print_success "Git configured with work identity"
        
        print_warning "Remember to set up SSH keys or access tokens for GitLab"
    else
        # Personal machine - link the dotfiles gitconfig
        ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
        print_success "Linked .gitconfig"
    fi
    
    # Common git settings
    git config --global init.defaultBranch main
    git config --global core.editor nvim
    git config --global pull.rebase false
}

# ================================
# Set Zsh as Default Shell
# ================================

set_default_shell() {
    print_step "Setting Zsh as default shell..."
    
    if [[ "$SHELL" != *"zsh"* ]]; then
        if command -v zsh &> /dev/null; then
            chsh -s "$(which zsh)"
            print_success "Zsh set as default shell (restart terminal to apply)"
        fi
    else
        print_success "Zsh is already default shell"
    fi
}

# ================================
# Main Installation
# ================================

main() {
    install_packages
    install_oh_my_zsh
    install_powerlevel10k
    install_oh_my_tmux
    install_tpm
    install_catppuccin_tmux
    install_nerd_font
    link_dotfiles
    configure_git
    set_default_shell
    
    echo ""
    echo "================================"
    echo -e "${GREEN}✅ Dotfiles installed successfully!${NC}"
    echo "================================"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal"
    echo "  2. Run 'p10k configure' if you want to customize the prompt"
    echo "  3. Start tmux — plugins install automatically on first launch"
    
    if [[ "$IS_WSL" == true ]]; then
        echo ""
        echo "WSL Tips:"
        echo "  • Install MesloLGS NF font in Windows for proper icons"
        echo "  • Set the font in Windows Terminal: Settings > Profiles > Ubuntu > Appearance"
    fi
    
    echo ""
}

main "$@"

