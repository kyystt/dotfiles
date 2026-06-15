return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',

            org_capture_templates = {
                t = { description = 'Tarefa', template = '* TODO %?\n SCHEDULED: %t' },
                e = { description = 'Estudo', template = '* TODO Estudar %?\n DEADLINE: %t' }
            }
        })

        vim.lsp.enable('org')
    end,
}
