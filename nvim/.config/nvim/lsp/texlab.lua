---@type vim.lsp.Config
return {
    cmd = {
        "texlab",
    },

    filetypes = {
        "tex",
        "plaintex",
        "bib",
    },

    root_markers = {
        ".latexmkrc",
        "latexmkrc",
        "main.tex",
        ".git",
    },

    settings = {
        texlab = {
            -- A compilação pertence ao VimTeX/latexmk.
            build = {
                onSave = false,
                forwardSearchAfter = false,
            },

            -- O VimTeX também controla o Zathura e o SyncTeX.
            -- Portanto, não configuramos texlab.forwardSearch.

            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },

            diagnostics = {
                ignoredPatterns = {
                    "Overfull",
                    "Underfull",
                },
            },

            completion = {
                matcher = "fuzzy-ignore-case",
            },

            -- Formatação de LaTeX.
            latexFormatter = "latexindent",

            latexindent = {
                modifyLineBreaks = false,
            },

            -- Formatação de bibliografias.
            bibtexFormatter = "texlab",
            formatterLineLength = 100,

            hover = {
                symbols = "image",
            },

            inlayHints = {
                labelDefinitions = true,
                labelReferences = true,
                maxLength = 40,
            },
        },
    },
}
