local M = {}

function M.pwn_template()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function write_template(binary, libc)
        local template = {
            "from pwn import *",
            "",
            "elf = ELF(\"./" .. binary .. "\")",
        }

        if libc and libc ~= "None" then
            table.insert(template, "libc = ELF(\"./" .. libc .. "\")")
        end

        local suffix = {
            "",
            "context.binary = elf",
            "context.terminal = \"kitty @ launch --location=vsplit --cwd=current\".split()",
            "",
            "def conn():",
            "    if args.REMOTE:",
            "        p = remote(\"addr\", 1337)",
            "    else:",
            "        if args.GDB:",
            "            p = gdb.debug([elf.path], aslr=True, api=False, gdbscript=\"\"\"",
            "                \"\"\")",
            "        else:",
            "            p = process([elf.path])",
            "",
            "    return p",
            "",
            "def main():",
            "    p = conn()",
            "",
            "    # pwn it",
            "",
            "    p.interactive()",
            "",
            "if __name__ == '__main__':",
            "    main()"
        }

        for _, line in ipairs(suffix) do
            table.insert(template, line)
        end

        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)
        vim.api.nvim_win_set_cursor(0, {row + 22, 4})
    end

    require("telescope.builtin").find_files({
        prompt_title = "Select ELF Binary",
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local binary = action_state.get_selected_entry().value
                actions.close(prompt_bufnr)

                -- 2. Pick Libc (Custom Picker to include "None")
                local files = vim.fn.readdir(vim.fn.getcwd())
                table.insert(files, 1, "None") -- Add "None" as the first option

                pickers.new({}, {
                    prompt_title = "Select Libc (or None)",
                    finder = finders.new_table { results = files },
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(libc_bufnr, map)
                        actions.select_default:replace(function()
                            local libc = action_state.get_selected_entry().value
                            actions.close(libc_bufnr)
                            write_template(binary, libc)
                        end)
                        return true
                    end,
                }):find()
            end)
            return true
        end,
    })
end

return M
