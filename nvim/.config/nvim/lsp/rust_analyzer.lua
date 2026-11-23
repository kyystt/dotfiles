---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {},
    },

    before_init = function(params, config)
        local settings = config.settings["rust-analyzer"]

        settings.detachedFiles = {
            vim.api.nvim_buf_get_name(0),
        }

        params.initializationOptions = settings
    end,
}
