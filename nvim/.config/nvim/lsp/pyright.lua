---@type vim.lsp.Config
return {
    cmd = {
        "rustup",
        "run",
        "stable",
        "rust-analyzer",
    },

    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },

            check = {
                command = "clippy",
            },

            procMacro = {
                enable = true,
            },
        },
    },
}
