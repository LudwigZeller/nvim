return {
	--[[ Tokyonight ]]
	--
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "storm",    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- The theme is used when the background is set to light
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					comments = { italic = true, bold = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "dark",     -- style for sidebars, see below
					floats = "dark",       -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3,    -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false,
				dim_inactive = false,    -- dims inactive windows
				lualine_bold = false,    -- When `true`, section headers in the lualine theme will be bold
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	--[[ catppuccin ]]
	--
	{
		"catppuccin/nvim",
		lazy = true,
		event = "UIEnter",
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

	--[[ Gruvbox ]]
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		event = "UIEnter",
		name = "gruvbox",
		opts = {},
	},
}
