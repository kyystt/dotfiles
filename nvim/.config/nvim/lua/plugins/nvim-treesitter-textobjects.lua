return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },

    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,

                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<C-v>",
                },

                include_surrounding_whitespace = true,
            },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local swap = require("nvim-treesitter-textobjects.swap")

        vim.keymap.set({ "x", "o" }, "af", function()
            select.select_textobject(
                "@function.outer",
                "textobjects"
            )
        end, {
            desc = "Select outer function",
        })

        vim.keymap.set({ "x", "o" }, "if", function()
            select.select_textobject(
                "@function.inner",
                "textobjects"
            )
        end, {
            desc = "Select inner function",
        })

        vim.keymap.set({ "x", "o" }, "ac", function()
            select.select_textobject(
                "@class.outer",
                "textobjects"
            )
        end, {
            desc = "Select outer class",
        })

        vim.keymap.set({ "x", "o" }, "ic", function()
            select.select_textobject(
                "@class.inner",
                "textobjects"
            )
        end, {
            desc = "Select inner class",
        })

        vim.keymap.set({ "x", "o" }, "ao", function()
            select.select_textobject(
                "@comment.outer",
                "textobjects"
            )
        end, {
            desc = "Select outer comment",
        })

        vim.keymap.set({ "x", "o" }, "as", function()
            select.select_textobject(
                "@local.scope",
                "locals"
            )
        end, {
            desc = "Select language scope",
        })

        vim.keymap.set("n", "<leader>sn", function()
            swap.swap_next("@parameter.inner")
        end, {
            desc = "Swap with next parameter",
        })

        vim.keymap.set("n", "<leader>sp", function()
            swap.swap_previous("@parameter.inner")
        end, {
            desc = "Swap with previous parameter",
        })

        local function swap_binary_operands()
            local node = vim.treesitter.get_node()

            if not node then
                vim.notify("No Tree-sitter node under cursor")
                return
            end

            local binary_types = {
                binary_expression = true,
                binary_operator = true,
                comparison_operator = true,
            }

            while node and not binary_types[node:type()] do
                node = node:parent()
            end

            if not node then
                vim.notify("No binary expression under cursor")
                return
            end

            local left
            local right

            local left_field = node:field("left")
            local right_field = node:field("right")

            if #left_field > 0 then
                left = left_field[1]
            end

            if #right_field > 0 then
                right = right_field[1]
            end

            -- Fallback for grammars without left/right fields.
            if not left or not right then
                local children = {}

                for child in node:iter_children() do
                    if child:named() then
                        table.insert(children, child)
                    end
                end

                if #children >= 2 then
                    left = children[1]
                    right = children[#children]
                end
            end

            if not left or not right then
                vim.notify("Could not find binary operands")
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()

            local left_text =
                vim.treesitter.get_node_text(left, bufnr)

            local right_text =
                vim.treesitter.get_node_text(right, bufnr)

            local lsr, lsc, ler, lec = left:range()
            local rsr, rsc, rer, rec = right:range()

            -- Replace right first so left coordinates remain valid.
            vim.api.nvim_buf_set_text(
                bufnr,
                rsr,
                rsc,
                rer,
                rec,
                vim.split(left_text, "\n", { plain = true })
            )

            vim.api.nvim_buf_set_text(
                bufnr,
                lsr,
                lsc,
                ler,
                lec,
                vim.split(right_text, "\n", { plain = true })
            )
        end

        vim.keymap.set("n", "<leader>so", swap_binary_operands, {
            desc = "Swap binary operands",
        })
    end,
}
