-- leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy nvim package manager
require("config.lazy")

-- Configuracoes e atalhos
require("core.options")
require("core.keymaps")

-- colorscheme selector
local cache_file = vim.fn.stdpath("state") .. "/last_colorscheme"

local f = io.open(cache_file, "r")
if f then
    local theme = f:read("*all"):gsub("%s+", "")
    f:close()
    local success = pcall(vim.cmd.colorscheme, theme)
    if not success then
        vim.cmd.colorscheme("pywal16")
    end
else
    vim.cmd.colorscheme("pywal16")
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(ev)
        local theme = ev.match
        if theme then
            local file = io.open(cache_file, "w")
            if file then
                file:write(theme)
                file:close()
            end
        end
    end,
})
