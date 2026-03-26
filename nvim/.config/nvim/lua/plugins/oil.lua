return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "permissions",
        },
        view_options = {
            show_hidden = true,
        },

        float = {
            enable = true,
            quit_on_focus_loss = true,

            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * 0.7  -- Example width: 70% of screen
                local window_h = screen_h * 0.7  -- Example height: 70% of screen
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

                return {
                    border = "rounded", -- Set the border style here (e.g., "rounded", "single", "double", "none")
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = math.floor(window_w),
                    height = math.floor(window_h),
                }
            end,
        },
    },
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
