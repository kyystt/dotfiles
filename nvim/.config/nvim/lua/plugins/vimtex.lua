return {
    "lervag/vimtex",

    -- VimTeX já carrega apenas para os filetypes necessários.
    -- O autor recomenda não usar event = "VeryLazy" ou ft = "tex".
    lazy = false,

    init = function()
        -- Usa espaço como localleader, configurado no init.lua:
        -- <Space>ll compila
        -- <Space>lv abre o PDF
        -- <Space>lk interrompe a compilação
        -- <Space>li mostra informações
        -- <Space>lo mostra o log da compilação
        -- <Space>le mostra os erros
        -- <Space>lc remove arquivos auxiliares
        -- <Space>lC remove arquivos auxiliares e o PDF
        -- <Space>lt abre o sumário do documento

        -- Abre e sincroniza o PDF usando Zathura.
        vim.g.vimtex_view_method = "zathura"

        -- Usa latexmk para compilação contínua.
        vim.g.vimtex_compiler_method = "latexmk"

        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "",
            out_dir = "",
            callback = 1,
            continuous = 1,
            executable = "latexmk",
            hooks = {},

            options = {
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
            },
        }

        -- Não abre automaticamente a janela de erros.
        vim.g.vimtex_quickfix_mode = 0

        -- Não abre a quickfix automaticamente apenas por warnings.
        vim.g.vimtex_quickfix_open_on_warning = 0

        -- Mantém o PDF aberto e atualizado enquanto você edita.
        vim.g.vimtex_view_automatic = 1

        -- Esconde visualmente alguns comandos LaTeX.
        -- Os comandos continuam presentes no arquivo.
        vim.g.vimtex_syntax_conceal = {
            accents = 1,
            ligatures = 1,
            cites = 1,
            fancy = 1,
            spacing = 1,
            greek = 1,
            math_bounds = 1,
            math_delimiters = 1,
            math_fracs = 1,
            math_super_sub = 1,
            math_symbols = 1,
            sections = 0,
            styles = 1,
        }
    end,

    config = function()
        local group = vim.api.nvim_create_augroup(
            "UserVimtexConfig",
            { clear = true }
        )

        vim.api.nvim_create_autocmd("FileType", {
            group = group,

            pattern = {
                "tex",
                "plaintex",
                "bib",
            },

            callback = function()
                -- Ativa conceal apenas em arquivos LaTeX e BibTeX.
                vim.opt_local.conceallevel = 2

                -- Mostra o conteúdo real na linha atual.
                vim.opt_local.concealcursor = ""
            end,
        })
    end,
}
