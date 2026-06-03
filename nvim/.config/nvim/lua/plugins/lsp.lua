return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp", -- Link to blink cmp engine
    },

    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

       vim.lsp.config('clangd', {
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders=1",
            },
        })

        vim.lsp.enable('clangd')
    end,
}
