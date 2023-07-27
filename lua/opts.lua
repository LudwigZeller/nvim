vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

vim.o.guifont = "FiraCode Nerd Font Mono:h12:#e-subpixelantialias"
vim.opt.linespace = 2

vim.opt.termguicolors = true

vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.relativenumber = true

vim.opt.shell = 'fish'

vim.opt.clipboard = 'unnamedplus'
--    i" ""󰃽 ""󰃽 ""󰃽 " 
-- Scope save to Session
vim.opt.sessionoptions = { -- required
    "buffers",
    "tabpages",
    "globals",
}

vim.opt.winblend = 30

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
	set signcolumn=yes
	autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

