return {
	{
		"zaldih/themery.nvim",
		cmd = "Themery",
		keys = {
			{ "<leader>uC", "<cmd>Themery<cr>", desc = "Colorscheme" },
		},
		opts = {
			themes = {
				"gruvbox",
				"tokyonight-day",
				"tokyonight-moon",
				"tokyonight-night",
				"tokyonight-storm",
				"catppuccin-latte",
				"catppuccin-mocha",
				"catppuccin-frappe",
				"catppuccin-macchiato",
				"kanagawa-dragon",
				"kanagawa-lotus",
				"kanagawa-wave",
			},
			themeConfigFile = vim.fn.expand(vim.fn.stdpath("config") .. "/init.lua"),
			livePreview = true,
		},
		config = true,
	},

	--[[ Kanagawa ]]
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},

	--[[ Tokyonight ]]
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "storm",  -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			light_style = "day", -- The theme is used when the background is set to light
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true,
			styles = {
				comments = { italic = true, bold = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				sidebars = "transparent", -- style for sidebars, see below
				floats = "dark",      -- style for floating windows
			},
			sidebars = { "qf", "help", "OverseerList", "NvimTree" },
			day_brightness = 0.3,
			hide_inactive_statusline = false,
			dim_inactive = false, -- dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		},
		config = true,
	},

	--[[ catppuccin ]]
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.overlay2 },
				}
			end,
			integrations = {
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				dap = {
					enabled = true,
					enable_ui = true, -- enable nvim-dap-ui
				},
				alpha = true,
				cmp = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				mason = true,
				navic = { enabled = true, custom_bg = "lualine" },
				lsp_trouble = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				which_key = true,
				overseer = true,
				aerial = true,
			},
		},
	},

	--[[ Gruvbox ]]
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {},
	},
}
