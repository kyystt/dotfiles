return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,

    config = function()
        vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

        vim.cmd([[
            function! OpenMarkdownPreview(url)
                let cmd = "firefox --new-window " . shellescape(a:url) . " &"
                silent call system(cmd)
            endfunction
        ]])
    end,
}
