return {
    "saghen/blink.cmp",
    version = '*',
    dependencies = { 'rafamadriz/friendly-snippets' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { 
            preset = 'default',

            ['<CR>'] = { 'accept', 'fallback' },
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },

            menu = { 
                draw = { 
                    columns = {
                        { "kind_icon" },
                        { "label", gap = 1 },
                        { "kind", gap = 1 },
                        { "label_description", gap = 1 }
                    },

                    treesitter = { 'lsp' } 
                } 
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        -- Shows the parameter types as you are typing inside function parentheses
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
