return {
	--[[ WhichKey ]]
	{
		"folke/which-key.nvim",
		opts = {
			window = {
				border = "shadow",     -- none, single, double, shadow
				position = "bottom",   -- bottom, top
				margin = { 2, 10, 2, 10 }, -- extra window margin [top, right, bottom, left].
				padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				zindex = 1000,         -- positive value to position WhichKey above other floating windows.
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				--["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>p"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>t"] = { name = "+terminal" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>gt"] = { name = "+toggle" },
				["<leader>q"] = { name = "+session" },
				["<leader>r"] = { name = "+runner" },
				["<leader>d"] = { name = "+debug" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			})
			if vim.g.neovide then
				wk.register({ mode = { "n", "v" }, ["<leader>v"] = { name = "+neovide" } })
			end
		end,
	},

	--[[ Indent-Blankline ]]
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_filetype_exclude = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"alpha",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"qf",
				"lspinfo",
				"checkhealth",
				"man",
				"",
			}
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = false,
				indent_blankline_use_treesitter = true,
			})
		end,
	},

	--[[ UFO Folds ]]
	{
		"kevinhwang91/nvim-ufo",
		keys = {
			{
				"zR",
				function(...)
					require("ufo").openAllFolds(...)
				end,
			},
			{
				"zM",
				function(...)
					require("ufo").closeAllFolds(...)
				end,
			},
		},
		event = "VimEnter",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({
				provider_selector = function(_bufnr, _filetype, _buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	--[[ Noice ]]
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				progress = {
					enabled = false,
					-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
					-- See the section on formatting for more details on how to customize.
					--- @type NoiceFormat|string
					format = "lsp_progress",
					--- @type NoiceFormat|string
					format_done = "lsp_progress_done",
					throttle = 1000 / 10, -- frequency to update lsp progress message
					view = "mini",
				},
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true,     -- use a classic bottom cmdline for search
				command_palette = true,   -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false,       -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true,    -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	--[[ Notify ]]
	{
		"rcarriga/nvim-notify",
		lazy = false,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			background_colour = "NotifyBackground",
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = ""
			},
			level = 2,
			minimum_width = 50,
			render = "default",
			stages = "fade_in_slide_out",
			top_down = true
		},
		init = function()
			vim.notify = require("notify")
		end,
	},

	--[[ Dressing	 ]]
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	--[[ Todo Comments ]]
	{
		-- TODO: Configure
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	--[[ Twilight ]]
	{
		"folke/twilight.nvim",
		keys = {
			{ "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
		},
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				color = { "Normal", "#ffffff" },
				term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 10,      -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {}, -- exclude these filetypes
		},
	},

	--[[ Color Highlighting ]]
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		keys = {
			{ "<leader>ui", "<cmd>ColorizerToggle<cr>", desc = "Toggle color preview" },
		},
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true,      -- #RGB hex codes
					RRGGBB = true,   -- #RRGGBB hex codes
					names = true,    -- "Name" codes like Blue or blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true,   -- CSS rgb() and rgba() functions
					hsl_fn = true,   -- CSS hsl() and hsla() functions
					css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "virtualtext", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false,                           -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end,
	},

	--[[ Statusline ]]
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"chrisgrieser/nvim-recorder",
			{
				"SmiteshP/nvim-navic",
				dependencies = "neovim/nvim-lspconfig",
				lazy = true,
				config = function()
					require("nvim-navic").setup({ lsp = { auto_attach = true } })
				end,
			},
		},
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"help",
						"startify",
						"dashboard",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"qf",
						"OverseerList",
					},
					winbar = {
						"help",
						"startify",
						"dashboard",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"qf",
						"OverseerList",
						"dapui_watches",
						"dapui_stacks",
						"dapui_breakpoints",
						"dapui_scopes",
						"dapui_console",
						"dap-repl",
					},
				},
				ignore_focus = {
					"dapui_watches",
					"dapui_stacks",
					"dapui_breakpoints",
					"dapui_scopes",
					"dapui_console",
					"dap-repl",
				},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "b:gitsigns_head", icon = "" },
					{
						"diff",
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
					"diagnostics",
				},
				lualine_c = { "overseer" },
				lualine_x = {
					function()
						return require("NeoComposer.ui").status_recording()
					end,
					function()
						return require("recorder").recordingStatus()
					end,
					function()
						return require("recorder").displaySlots()
					end,
				},
				lualine_y = { "encoding", "filetype", "fileformat", "hostname" },
				lualine_z = { "progress", "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_c = {
					{
						"navic",
						draw_empty = true,
						color_correction = "dynamic",
						navic_opts = {
							highlight = true,
						},
					},
				},
			},
			inactive_winbar = {
				lualine_c = {
					{
						"navic",
						draw_empty = true,
						color_correction = "dynamic",
						navic_opts = {
							highlight = false,
						},
					},
				},
			},
			extensions = {},
		},
	},

	--[[ Bufferline ]]
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
					themable = true,
					indicator = { --[[ style = "icon", icon = " ▷" ]] style = "underline" },
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
						{
							filetype = "OverseerList",
							text = "Task List",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
						{
							filetype = "dapui_watches",
							text = "Debug",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
					},
				},
			})
		end,
		-- opts = {
		-- 	options = {
		-- 		indicator = { style = "underline" },
		-- 		diagnostics = "nvim_lsp",
		-- 		seperator_style = "slant",
		-- 		always_show_bufferline = false,
		-- 		offsets = {
		-- 			{
		-- 				filetype = "NvimTree",
		-- 				text = "File Explorer",
		-- 				highlight = "Directory",
		-- 				separator = true, -- use a "true" to enable the default, or set your own character
		-- 			},
		-- 			{
		-- 				filetype = "OverseerList",
		-- 				text = "Task List",
		-- 				highlight = "Directory",
		-- 				separator = true, -- use a "true" to enable the default, or set your own character
		-- 			},
		-- 		},
		-- 	},
		-- },
	},

	--[[ Highlight Words ]]
	{
		"RRethy/vim-illuminate",
		lazy = false,
		keys = {
			{ "<leader>ui", "<cmd>IlluminateToggle<cr>", desc = "Toggle Illuminate" },
		},
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 100,
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"qf",
				},
				under_cursor = true,
				large_file_cutoff = 10000,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
			})
		end,
	},

	--[[ Dashboard ]]
	{
		"goolord/alpha-nvim",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local config = vim.fn.stdpath("config")
			local logo = [[
                     `. ___
                    __,' __`.                _..----....____
        __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'
  _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'
,'________________                          \`-._`-','
 `._              ```````````------...___   '-.._'-:
    ```--.._      ,.                     ````--...__\-.
            `.--. `-`                       ____    |  |`
              `. `.                       ,'`````.  ;  ;`
                `._`.        __________   `.      \'__/`
                   `-:._____/______/___/____`.     \  `
                               |       `._    `.    \
                               `._________`-.   `.   `.___
                                             SSt  `------'`
]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " >" .. " Find file", "<cmd>Telescope find_files <CR>"),
				dashboard.button("n", " >" .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
				dashboard.button("r", " >" .. " Recent files", "<cmd>Telescope oldfiles <CR>"),
				dashboard.button("g", " >" .. " Find text", "<cmd>Telescope live_grep <CR>"),
				dashboard.button("c", " >" .. " Config", "<cmd>cd " .. config .. "| e " .. config .. "<CR>"),
				dashboard.button("s", " >" .. " Restore Session", "<cmd>SessionManager load_last_session<cr>"),
				dashboard.button("S", " >" .. " List Session", "<cmd>SessionManager load_session<cr>"),
				dashboard.button("l", "󰒲 >" .. " Lazy", "<cmd>Lazy<CR>"),
				dashboard.button("q", " >" .. " Quit", "<cmd>qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 2
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = ("%d / %d plugins loaded in %.2f ms ⚡"):format(
						stats.loaded,
						stats.count,
						ms
					)
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	--[[ Screensaver ]]
	{
		"folke/drop.nvim",
		event = "VimEnter",
		opts = {
			theme = "snow", -- can be one of rhe default themes, or a custom theme
			max = 40,    -- maximum number of drops on the screen
			interval = 150, -- every 150ms we update the drops
			screensaver = 3 * 60 * 1000,
			filetypes = {}, -- will enable/disable automatically for the following filetypes
			winblend = 100, -- winblend for the drop window
		},
	},
}
