#!/usr/bin/env bash
set -e

echo "🚀 Starting bootstrap setup..."

# --- Detect OS ---
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
else
  echo "❌ Unsupported OS: $OSTYPE"
  exit 1
fi

echo "📍 Detected OS: $OS"

# --- Install package manager and tools ---
if [[ "$OS" == "macos" ]]; then
  # Install Homebrew if missing
  if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "✅ Homebrew already installed"
  fi
  
  echo "📦 Installing tools via Homebrew..."
  brew install tmux neovim lazygit bat zoxide fzf ripgrep fd node

elif [[ "$OS" == "linux" ]]; then
  # Detect Linux package manager
  if command -v apt-get &> /dev/null; then
    echo "📦 Installing tools via apt..."
    sudo apt-get update
    sudo apt-get install -y tmux neovim git curl bat fzf ripgrep fd-find
    
    # Node.js via NodeSource
    if ! command -v node &> /dev/null; then
      echo "📦 Installing Node.js..."
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt-get install -y nodejs
    fi
    
    # Manually install zoxide (not in apt by default)
    if ! command -v zoxide &> /dev/null; then
      echo "📦 Installing zoxide..."
      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
    
    # Manually install lazygit (not in apt by default)
    if ! command -v lazygit &> /dev/null; then
      echo "📦 Installing lazygit..."
      LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
      curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
      tar xf lazygit.tar.gz lazygit
      sudo install lazygit /usr/local/bin
      rm lazygit lazygit.tar.gz
    fi
    
  elif command -v pacman &> /dev/null; then
    echo "📦 Installing tools via pacman..."
    sudo pacman -S --noconfirm tmux neovim git curl bat fzf ripgrep fd nodejs lazygit zoxide
    
  else
    echo "❌ No supported package manager found (apt/pacman)"
    exit 1
  fi
fi

# --- Initialize zoxide for current shell ---
SHELL_RC=""
if [ -n "$ZSH_VERSION" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
  SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ] && ! grep -q 'zoxide init' "$SHELL_RC"; then
  SHELL_NAME=$(basename "$SHELL")
  echo "eval \"\$(zoxide init $SHELL_NAME)\"" >> "$SHELL_RC"
  echo "⚙️ Added zoxide init to $SHELL_RC"
fi

# --- Clone Neovim config ---
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "📂 Neovim config already exists at $NVIM_CONFIG_DIR"
else
  echo "📂 Cloning Neovim config..."
  git clone https://github.com/CardosoShlomo/nvim "$NVIM_CONFIG_DIR"
fi

echo ""
echo "✅ Setup complete!"
echo "🔄 Restart your terminal to apply changes."
