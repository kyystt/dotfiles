return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- Carrega na inicializacao
    priority = 1000,

    config = function()
        -- Configuracao das opcoes
        require("catppuccin").setup({
            flavour = "mocha", -- "latte", "frappe", "macchiato", "mocha"

            -- Fundo transparente
            transparent_background = true,

            -- Adiciona "dimming" para paineis interativos
            no_italic = false, -- habilita italico
            no_bold = false, -- habilita negrito
            no_underline = false, -- habilita sublinhado

            -- Integracao com outros plugins
            integrations = {
                gitsings = true,
                telescope = true,
                treesitter = true,
            },
        })

    -- Aplica o tema
    vim.cmd.colorscheme("catppuccin")

    end,
} 
