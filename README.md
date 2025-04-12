# kjunghoan's nvim config

Place this repo in `~/.config/nvim`.

This is a personal config so I implore you to read through and make changes when forking

this is also meant to work with my tmux config on macos, windows, linux, and wsl so some of the binds may be a bit odd

## TODO:

- figure out whats going on with lombok support(low prio)
- test runner (maybe)
- make file support (maybe)
- go lsp (probably)
- eslint / prettier detection (basically if one or both of those files exist in
a project root then force the lsp to follow those)

## Dependencies

- [Neovim 0.11+](https://github.com/neovim/neovim/releases/tag/stable)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for telescope grep)
- [Node.js](https://github.com/nvm-sh/nvm) (for TypeScript/JavaScript LSP)
- [Java JDK](https://openjdk.org/) (for Java development)

## Features

- Intuitive keymaps with which-key integration
- LSP configuration for multiple languages
- Fast file navigation with Telescope, Harpoon, and Oil
- Git integration with gitsigns
- Treesitter for improved syntax highlighting
- GitHub Copilot integration

## Language Support

### Configured LSP Servers
- TypeScript/JavaScript (typescript-language-server)
- Python (pyright)
- Python linting (ruff-lsp)
- Lua (lua-language-server)
- Java (jdtls)
- Bash (bash-language-server)
- YAML (yaml-language-server)

### Utilities
- Git integration
- File browser (oil.nvim)
- Fuzzy finding (telescope)
- Completion (nvim-cmp)
- Obsidian vault integration
- Undo history visualization (undotree)

## Installation

1. Clone this repository to `~/.config/nvim`
2. Launch Neovim to automatically install plugins
3. Run `:Mason` to install language servers

## Keymaps

- `<leader>f` - Find (Telescope)
- `<leader>p` - Project (Oil file browser)
- `<leader>l` - LSP functions
- `<leader>g` - Git operations
- `<leader>h` - Clear search highlighting
- `<leader>q` - Quit

For a complete list of keymaps, press `<leader>` and wait for which-key popup.

