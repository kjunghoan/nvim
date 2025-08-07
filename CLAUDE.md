# Neovim Configuration - CLAUDE.md

## Overview
This is a Neovim 0.11 configuration optimized for development and deployment tasks.

## Supported Languages & Technologies
- **Programming Languages**: JavaScript, TypeScript, Python 3.12, Java 17/21, Go
- **Configuration Formats**: YAML, JSON, Kubernetes manifests, Protocol Buffers
- **Additional Uses**: Note-taking (Obsidian), general text editing

## Key Features
- Uses Neovim 0.11's new `vim.lsp.enable()` API with individual LSP configs in `/lsp/` directory
- Modern completion with blink.cmp (Rust-based, faster than nvim-cmp)
- Organized keybindings via which-key
- Git integration with gitsigns
- File navigation with oil.nvim and telescope
- Language-specific tools: jdtls for Java, go-debug/go-tools for Go

## LSP Servers Configured
- `bashls` - Bash
- `pbls` - Protocol Buffers  
- `css-lsp` - CSS
- `gopls` - Go
- `json-lsp` - JSON
- `lua_ls` - Lua
- `markdown-oxide` - Markdown
- `pyright` & `ruff` - Python
- `tailwindcss` - Tailwind CSS
- `ts_ls` - TypeScript/JavaScript
- `yamlls` - YAML
- `jdtls` - Java (via plugin)
- `ltex_ls` - Grammar checking (via ltex_extra plugin)

## File Structure
```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lsp/                     # Individual LSP configurations (0.11 style)
├── lua/
│   ├── config/              # Core configuration
│   │   ├── lsp.lua         # LSP setup with vim.lsp.enable()
│   │   ├── options.lua     # Neovim options
│   │   ├── globalKeymaps.lua
│   │   └── autoCmds.lua
│   └── plugins/            # Plugin configurations
└── spell/                  # Custom dictionaries
```

## Key Keybindings
- `<leader>l*` - All LSP functions (definition, references, rename, etc.)
- `<leader>ld` - Open float diagnostic
- `[d` / `]d` - Navigate diagnostics
- Completion: `<C-j>`/`<C-k>` to navigate, `<M-CR>` to accept

## Testing & Linting Commands
To run tests and linting, check the specific project's package.json, Makefile, or project documentation for the appropriate commands.

## Notes
- Configuration follows Neovim 0.11 conventions
- Uses modern plugin ecosystem (blink.cmp, oil.nvim, etc.)
- LSP configurations are modular and easily extendable
- Optimized for performance with Rust-based completion and tree-sitter improvements