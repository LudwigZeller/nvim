-- disable language provider support (lua and vimscript plugins only)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.filetype.add {
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  }
}

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "


vim.opt.termguicolors = true


vim.opt.linespace = 2
vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 1000
vim.opt.autoread = true

vim.opt.shell = "fish"
vim.opt.clipboard = "unnamedplus"
vim.opt.mousemodel = "extend"

vim.wo.fillchars = "eob: "

-- Scope save to Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.winminwidth = 10
vim.opt.winblend = 30

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- LSP Diagnostics Options Setup
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "󰌶" })
sign({ name = "DiagnosticSignInfo", text = "" })

--[[ Folds ]]
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
	set signcolumn=yes
	autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
