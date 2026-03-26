-- leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy nvim package manager
require("config.lazy")

-- Configuracoes e atalhos
require("core.options")
require("core.keymaps")
