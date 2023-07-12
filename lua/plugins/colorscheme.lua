return {
  --[[ Tokyonight ]]--
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
		priority=1000,
    opts = {
			style = "storm",
			transparent = true,
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { bold = true, },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "transparent", -- style for sidebars, see below
				floats = "normal", -- style for floating windows
			},
			sidebars = { },
		},
		config = function ()
			vim.cmd[[colorscheme tokyonight]]
		end
  },

  --[[ catppuccin ]]--
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },

	--[[ Gruvbox ]]--
	{
		'ellisonleao/gruvbox.nvim',
		lazy = true,
		name = "gruvbox",
		opts = {
			transparent_mode = false,
		},
	}
}
