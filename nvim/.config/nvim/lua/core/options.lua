local opt = vim.opt

-- Aparencia
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true -- Mostra linha em baixo do cursor

-- Indentacao
opt.tabstop = 4 -- Define a largura do tab
opt.softtabstop = 4 -- Quantidade de espaços aplicados quando tab for apertado
opt.shiftwidth = 4 -- Controla a largura de acordo com o nível de indentação
opt.expandtab = true -- Converte tabs pra espaço
opt.autoindent = true -- Mantém a indentação da linha anterior
opt.smarttab = true
opt.smartindent = true
opt.breakindent = true -- Se uma linha for além do que é possível mostrar, quebra a linha

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Display
opt.showmode = false -- Não mostra o modo, uma vez que já está presente na status line
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.scrolloff = 10 -- Número mínimo de linhas que deve manter acima e abaixo do cursor

-- Outros
opt.undofile = true -- Grava undos entre sessões
