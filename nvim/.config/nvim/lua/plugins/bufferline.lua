return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
        { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
        { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close current buffer" },
        { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
    },
    opts = {
        options = {
            mode = "buffers",
            separator_style = "thin", -- Options: "slant", "padded_slant", "slope", "thick", "thin"
            show_buffer_close_icons = true,
            show_close_icon = false,
            diagnostics = "nvim_lsp",
            -- Pushes the tab bar to the right when nvim-tree is open (like in your screenshot)
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
            },
        },
    },
}

