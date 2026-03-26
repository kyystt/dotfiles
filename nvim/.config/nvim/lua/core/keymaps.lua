local map = vim.keymap.set

-- Oil plugin -- 
map("n", "-", "<cmd>Oil --float<CR>", { desc = "Abre o oil com uma janela flutuante" })

-- Pwntools template
local pwn = require("utils.pwn")
map("n", "<leader>pwn", pwn.pwn_template, { desc = "Pwntools Template" })

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
