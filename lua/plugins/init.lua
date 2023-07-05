return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use 'neovim/nvim-lspconfig'

	use {
		"folke/which-key.nvim",
			config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
		}

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


  if packer_bootstrap then
    require('packer').sync()
  end
end)



-- LOAD CONFIGS

