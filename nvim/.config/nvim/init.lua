-- leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy nvim package manager
require("config.lazy")

-- Configuracoes e atalhos
require("core.options")
require("core.keymaps")

-- remove padding from kitty when open nvim
local function set_kitty_spacing(margin, padding)
	if vim.env.TERM == "xterm-kitty" and vim.env.KITTY_LISTEN_ON then
		vim.system({
			"kitty",
			"@",
			"--to",
			vim.env.KITTY_LISTEN_ON,
			"set-spacing",
			"margin=" .. margin,
			"padding=" .. padding,
		})
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	callback = function()
		set_kitty_spacing(0, 0)
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	callback = function()
		set_kitty_spacing("default", "default")
	end,
})

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
