#!/bin/bash

# This is a script that will set up the environment for Neovim 0.11.4 config

# Ask if user has read the setup file
read -p "Have you read the contents of this setup file? (y/n) [n]: " read_file
if [[ -z "$read_file" || "$read_file" =~ ^[Nn]$ ]]; then
  echo "Displaying contents of the setup file:"
  cat "$0"
  echo ""
  read -p "Press Enter to continue..."
fi

# Check if homebrew is installed
echo "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Homebrew could not be found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed. Please restart your shell and re-run this script."
  exit 1
fi

# Check if the computer has neovim installed (version 0.11.3+)
echo "Checking for Neovim..."
if ! command -v nvim &>/dev/null; then
  echo "Neovim could not be found. Installing..."
  brew install neovim
  echo "Neovim installed. Please re-run this script."
  exit 1
else
  # Check Neovim version
  nvim_version=$(nvim --version | head -1 | grep -oP 'v\K[0-9]+\.[0-9]+')
  required_version="0.11"
  if [[ $(echo -e "$nvim_version\n$required_version" | sort -V | head -1) != "$required_version" ]]; then
    echo "Warning: Neovim version $nvim_version found, but 0.11.3+ is recommended."
    echo "Consider upgrading with: brew upgrade neovim"
  fi
fi

# Install additional development tools
echo "Installing additional development tools..."
tools_to_install=()

# Check and queue tools for installation
if ! command -v rg &>/dev/null; then
  echo "ripgrep not found, will install..."
  tools_to_install+=("ripgrep")
fi

if ! command -v fd &>/dev/null; then
  echo "fd not found, will install..."
  tools_to_install+=("fd")
fi

if ! command -v unzip &>/dev/null; then
  echo "unzip not found, will install..."
  tools_to_install+=("unzip")
fi

if ! command -v uv &>/dev/null; then
  echo "uv (Python package manager) not found, will install..."
  tools_to_install+=("uv")
fi

if ! command -v convert &>/dev/null || ! command -v identify &>/dev/null; then
  echo "ImageMagick not found, will install..."
  tools_to_install+=("imagemagick")
fi

if ! command -v tree-sitter &>/dev/null; then
  echo "tree-sitter CLI not found, will install..."
  tools_to_install+=("tree-sitter-cli")
fi

# Install tools if any are missing
if [ ${#tools_to_install[@]} -gt 0 ]; then
  echo "Installing: ${tools_to_install[*]}"
  brew install "${tools_to_install[@]}"
else
  echo "All development tools already installed!"
fi

# Check if the computer has Mason in path
echo "Checking for Mason in PATH..."
if [[ ":$PATH:" != *":$HOME/.local/share/nvim/mason/bin:"* ]]; then
  echo "Mason not found in PATH. Adding to shell config..."

  # Check for zshrc first
  if [[ -f "$HOME/.zshrc" ]]; then
    echo "Adding Mason to .zshrc..."
    echo 'export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"' >>"$HOME/.zshrc"
    echo "Please restart your shell or run 'source ~/.zshrc' to apply changes"
    exit 1
  # Then check for bashrc
  elif [[ -f "$HOME/.bashrc" ]]; then
    echo "Adding Mason to .bashrc..."
    echo 'export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"' >>"$HOME/.bashrc"
    echo "Please restart your shell or run 'source ~/.bashrc' to apply changes"
    exit 1
  else
    echo "Could not find .zshrc or .bashrc. Please add Mason to your PATH manually."
    exit 1
  fi
fi

# Check for Node.js version (>20)
echo "Checking for Node.js version..."
if ! command -v node &>/dev/null; then
  echo "Node.js not found. Installing via Homebrew..."
  brew install node
  echo "Node.js installed. Please re-run this script."
  exit 1
else
  node_version=$(node -v | cut -c 2- | cut -d'.' -f1)
  if [[ $node_version -lt 20 ]]; then
    echo "Node.js version must be 20 or higher. Current version: $(node -v)"
    echo "Upgrading Node.js..."
    brew upgrade node
    exit 1
  fi
fi

# Set up Python virtual environment for Neovim with pynvim
echo "Setting up Python virtual environment for Neovim..."
VENV_DIR="$HOME/.config/nvim/venv/neovim"

# Check if venv directory already exists
if [ -d "$VENV_DIR" ]; then
  echo "Neovim Python virtual environment already exists."

  # Check if pynvim is installed and working
  if ! "$VENV_DIR/bin/python3" -c "import pynvim" 2>/dev/null; then
    echo "pynvim not found or broken in existing venv. Reinstalling..."
    rm -rf "$VENV_DIR"
    mkdir -p "$HOME/.config/nvim/venv"
    python3 -m venv "$VENV_DIR" && "$VENV_DIR/bin/pip" install --upgrade pip pynvim
  else
    echo "pynvim is properly installed in the virtual environment."
  fi
else
  # Create directory if it doesn't exist
  echo "Creating Neovim Python virtual environment..."
  mkdir -p "$HOME/.config/nvim/venv"

  # Create virtual environment and install pynvim
  python3 -m venv "$VENV_DIR" && "$VENV_DIR/bin/pip" install --upgrade pip pynvim

  if [ $? -eq 0 ]; then
    echo "Successfully created Python virtual environment and installed pynvim."
  else
    echo "Failed to create Python virtual environment or install pynvim."
    exit 1
  fi
fi

# Success message
echo ""
echo " All requirements satisfied! Your environment is ready."
echo ""
echo "Installed tools summary:"
echo "- Neovim: $(nvim --version | head -1)"
echo "- ripgrep: $(rg --version | head -1)"
echo "- fd: $(fd --version | head -1)"
echo "- uv: $(uv --version 2>&1 || echo 'installed')"
echo "- ImageMagick: $(convert -version | head -1 | awk '{print $3}' || echo 'installed')"
echo "- unzip: $(unzip -v | head -1 | awk '{print $2}' || echo 'installed')"
echo "- tree-sitter: $(tree-sitter --version 2>&1 || echo 'installed')"
echo "- Node.js: $(node --version)"
echo "- Python (venv): $("$VENV_DIR/bin/python3" --version)"
echo ""
echo "Next steps:"
echo "1. Start Neovim with: nvim"
echo "2. Mason will auto-install LSP servers and tools (takes ~3-5 minutes)"
echo "3. Verify setup with: :checkhealth"
echo "4. For Python debugging, add 'debugpy' to your project: uv add --dev debugpy"
