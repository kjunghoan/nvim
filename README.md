# kjunghoan's nvim config

This branch is a more minimal version that is meant for client machines to use. 

## Instructions

This repo should be placed in ~/.config/nvim and requires a few dependencies to be installed.

## Dependencies

- fzf
- ripgrep
- a nerd font
- [a valid node version(for linting and formatting)](https://github.com/nvm-sh/nvm)

```bash
brew install fzf ripgrep node neovim stylua shfmt
```

```bash
# I've been using prettier to format md files but feel free to use your own
npm install -g prettier
```

## Configured Languages

- markdown
- yaml
- shell scripts

## Configured Formatters
- prettier
- stylua
- yamlfmt
- shfmt
