local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

require("core")

require('lazy').setup({
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	'neovim/nvim-lspconfig',

  'folke/which-key.nvim',	

	{ 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons', }, },

	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } } },

	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

	'hrsh7th/nvim-cmp', 

	'hrsh7th/cmp-nvim-lsp',

	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-vsnip',                              
	'hrsh7th/cmp-path',                              
	'hrsh7th/cmp-buffer',                            
	'hrsh7th/vim-vsnip',     

	'akinsho/toggleterm.nvim',

	{ 'phaazon/hop.nvim', branch = 'v2' },

	{ 'fgheng/winbar.nvim', dependencies = { { 'nvim-tree/nvim-web-devicons' }, { 'SmiteshP/nvim-navic' } } },

	{'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},

	'tiagovla/scope.nvim',

	'tamton-aquib/staline.nvim',
})

require("plugins")
