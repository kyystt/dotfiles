return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup()

        local ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "cpp",
            "rust",
            "python",
            "latex",
            "bibtex"
        }

        treesitter.install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "cpp",
                "julia",
                "python",
                "tex",
                "plaintex",
                "bib"
            },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
