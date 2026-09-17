return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup()

        treesitter.install({
            "c",
            "lua",
            "vim",
            "vimdoc",
            "cpp",
            "javascript",
            "html",
            "sql",
            "julia",
            "python",
            "vhdl",
            "systemverilog",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "c",
                "lua",
                "vim",
                "cpp",
                "javascript",
                "html",
                "sql",
                "julia",
                "python",
                "vhdl",
                "systemverilog"
            },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
