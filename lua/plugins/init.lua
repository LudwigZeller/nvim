require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use 'neovim/nvim-lspconfig'

	use "folke/which-key.nvim"	

	use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', }, }

	use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } } }

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'hrsh7th/nvim-cmp' 

	use 'hrsh7th/cmp-nvim-lsp'

	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-vsnip'                              
	use 'hrsh7th/cmp-path'                              
	use 'hrsh7th/cmp-buffer'                            
	use 'hrsh7th/vim-vsnip'     

	use { 'akinsho/toggleterm.nvim', tag = '*' } 

	use { 'phaazon/hop.nvim', branch = 'v2' }

	use { 'fgheng/winbar.nvim', requires = { { 'nvim-tree/nvim-web-devicons' }, { 'SmiteshP/nvim-navic' } } }

	use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

	use 'tamton-aquib/staline.nvim'

  if packer_bootstrap then require('packer').sync() end
end)

--[[ Load Config ]]--
require("plugins.config.manson")
require("plugins.config.toggleterm")
require("plugins.config.nvim_tree")
require("plugins.config.cmp")
require("plugins.config.treesitter")
require("plugins.config.hop")
require("plugins.config.which_key")
require("plugins.config.winbar")
require("plugins.config.bufferline")
require("plugins.config.staline")


--[[ Load Plugin Keymap ]]--
require("plugins.keymap")

