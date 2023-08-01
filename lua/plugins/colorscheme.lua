return {
	--[[ Tokyonight ]]
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- The theme is used when the background is set to light
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true,
				styles = {
					comments = { italic = true, bold = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "transparent", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help", "OverseerList", "NvimTree" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	--[[ catppuccin ]]
	{
		"catppuccin/nvim",
		lazy = true,
		event = "VimEnter",
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
		event = "VimEnter",
		opts = {},
	},
}
