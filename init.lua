vim.g.mapleader = " "
vim.g.maplocalleader = " "
pcall(require, "local-config")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")
require("config.lemonade")
