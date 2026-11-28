return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { "clang-format", lsp_format = "fallback"},
            cpp = { "clang-format", lsp_format = "fallback"},
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        }
    },
}
