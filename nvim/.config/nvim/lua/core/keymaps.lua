-- leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Oil plugin -- 
map("n", "-", "<cmd>Oil --float<CR>", { desc = "Abre o oil com uma janela flutuante" })

local pwn = require("utils.pwn")
-- Pwntools template
map("n", "<leader>pwn", pwn.pwn_template, { desc = "Pwntools Template" })
