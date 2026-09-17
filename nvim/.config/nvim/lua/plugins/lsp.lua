return {
    "neovim/nvim-lspconfig",

    event = {
        "BufReadPre",
        "BufNewFile",
    },

    dependencies = {
        "saghen/blink.cmp",
    },

    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local keymap = vim.keymap

        -- ==========================================
        -- Configuração comum para todos os LSPs
        -- ==========================================

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- ==========================================
        -- UI e ícones de diagnóstico
        -- ==========================================

        local signs = {
            Error = " ",
            Warn = " ",
            Hint = "󰠠 ",
            Info = " ",
        }

        for diagnostic_type, icon in pairs(signs) do
            local highlight = "DiagnosticSign" .. diagnostic_type

            vim.fn.sign_define(highlight, {
                text = icon,
                texthl = highlight,
                numhl = "",
            })
        end

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 2,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- ==========================================
        -- Atalhos comuns dos LSPs
        -- ==========================================

        local lsp_group = vim.api.nvim_create_augroup(
            "UserLspConfig",
            { clear = true }
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_group,

            callback = function(ev)
                local opts = {
                    buffer = ev.buf,
                    silent = true,
                }

                opts.desc = "Ver referências com Telescope"
                keymap.set(
                    "n",
                    "gR",
                    "<cmd>Telescope lsp_references<CR>",
                    opts
                )

                opts.desc = "Ir para declaração"
                keymap.set(
                    "n",
                    "gD",
                    vim.lsp.buf.declaration,
                    opts
                )

                opts.desc = "Ir para definição"
                keymap.set(
                    "n",
                    "gd",
                    vim.lsp.buf.definition,
                    opts
                )

                opts.desc = "Ações de código"
                keymap.set(
                    { "n", "v" },
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    opts
                )

                opts.desc = "Renomear símbolo"
                keymap.set(
                    "n",
                    "<leader>rn",
                    vim.lsp.buf.rename,
                    opts
                )

                opts.desc = "Ver diagnósticos do arquivo"
                keymap.set(
                    "n",
                    "<leader>D",
                    "<cmd>Telescope diagnostics bufnr=0<CR>",
                    opts
                )

                opts.desc = "Ver diagnóstico da linha"
                keymap.set(
                    "n",
                    "<leader>d",
                    vim.diagnostic.open_float,
                    opts
                )

                opts.desc = "Diagnóstico anterior"
                keymap.set(
                    "n",
                    "[d",
                    vim.diagnostic.goto_prev,
                    opts
                )

                opts.desc = "Próximo diagnóstico"
                keymap.set(
                    "n",
                    "]d",
                    vim.diagnostic.goto_next,
                    opts
                )

                opts.desc = "Documentação do símbolo"
                keymap.set(
                    "n",
                    "K",
                    vim.lsp.buf.hover,
                    opts
                )
            end,
        })

        -- ==========================================
        -- Formatação automática de C/C++
        -- ==========================================

        local format_group = vim.api.nvim_create_augroup(
            "UserLspFormat",
            { clear = true }
        )

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_group,

            callback = function(ev)
                local filetype = vim.bo[ev.buf].filetype

                local cpp_like = vim.tbl_contains({
                    "c",
                    "cpp",
                    "objc",
                    "objcpp",
                    "cuda",
                }, filetype)

                if not cpp_like then
                    return
                end

                vim.lsp.buf.format({
                    bufnr = ev.buf,
                    async = false,

                    filter = function(client)
                        return client.name == "clangd"
                    end,
                })
            end,
        })

        -- ==========================================
        -- Ativação dos servidores
        -- ==========================================

        local servers = {
            "clangd",
            "rust_analyzer",
            "pyright",
        }

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end
    end,
}
