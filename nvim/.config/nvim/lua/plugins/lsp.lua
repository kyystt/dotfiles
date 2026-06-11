return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp", -- Mantemos o Blink em vez do velho cmp_nvim_lsp!
    },
    config = function()
        -- 1. Pega os superpoderes do Blink
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local keymap = vim.keymap

        -- ==========================================
        -- 2. UI e Ícones de Diagnóstico
        -- ==========================================
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = { prefix = "●", spacing = 2 },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- ==========================================
        -- 3. Atalhos (Só ativam quando o LSP carrega!)
        -- ==========================================
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Ver Referências (Telescope)"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Ir para Declaração"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Ir para Definição"
                keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                opts.desc = "Ações de Código (Code Action)"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Renomear Variável"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Ver Erros do Arquivo (Telescope)"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Ver Erro da Linha"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Erro Anterior"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Próximo Erro"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "Documentação (Hover)"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end,
        })

        -- ==========================================
        -- 4. Formatação Automática (Ao Salvar)
        -- ==========================================
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(ev)
                local ft = vim.bo[ev.buf].filetype
                local cpp_like = vim.tbl_contains({ "c", "cpp", "objc", "objcpp" }, ft)

                if cpp_like then
                    vim.lsp.buf.format({
                        bufnr = ev.buf,
                        async = false,
                        filter = function(client)
                            return client.name == "clangd"
                        end,
                    })
                end
            end,
        })

        -- ==========================================
        -- 5. Configuração dos Servidores (API 0.11+)
        -- ==========================================

        -- Clangd (C++)
        vim.lsp.config("clangd", {
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
        vim.lsp.enable("clangd")

        -- Servidores Simples (Python, etc)
        local servers = { "pyright" }
        for _, server in ipairs(servers) do
            vim.lsp.config(server, {
                capabilities = capabilities,
            })
            vim.lsp.enable(server)
        end

    end,
}
