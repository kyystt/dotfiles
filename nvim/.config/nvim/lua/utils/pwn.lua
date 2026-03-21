local M = {}

function M.pwn_template()
    local template = {
            "from pwn import *",
            "",
            "elf = ELF(\"./binary\")",
            "libc = ELF(\"./libc.so.6\")",
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
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)
    vim.api.nvim_win_set_cursor(0, {row + 22, 4})
end

return M
