return {
	--[[ WhichKey ]] --
	{
		'folke/which-key.nvim',
		opts = {
			window = {
				border = "shadow",     -- none, single, double, shadow
				position = "bottom",   -- bottom, top
				margin = { 2, 10, 2, 10 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				zindex = 1000,         -- positive value to position WhichKey above other floating windows.
			},
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				--["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>t"] = { name = "+terminal" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>gt"] = { name = "+toggle" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				--["<leader>w"] = { name = "+windows" },
				--["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},

	--[[ Indent-Blankline ]] --
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_filetype_exclude = {
				'help',
				'startify',
				'dashboard',
				'packer',
				'neogitstatus',
				'NvimTree',
				'Trouble',
				'alpha',
				'lir',
				'Outline',
				'spectre_panel',
				'toggleterm',
				'qf',
				'lspinfo',
				'checkhealth',
				'man',
				''
			}
			require("indent_blankline").setup {
				show_current_context = true,
				show_current_context_start = false,
				indent_blankline_use_treesitter = true,
			}
		end
	},

	--[[ Noice ]] --
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
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
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	},

	--[[ Notify ]] --
	{
		'rcarriga/nvim-notify',
		keys = {
			{
				'<leader>un',
				function()
					require('notify').dismiss({ silent = true, pending = true })
				end,
				desc = 'Dismiss all Notifications',
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
		},
		init = function()
			vim.notify = require('notify')
		end,
	},

	--[[ Dressing ]] --
	{
		'stevearc/dressing.nvim',
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require('lazy').load({ plugins = { 'dressing.nvim' } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require('lazy').load({ plugins = { 'dressing.nvim' } })
				return vim.ui.input(...)
			end
		end,
	},

	--[[ Todo Comments ]] --
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},

	--[[ Twilight ]] --
	{
		'folke/twilight.nvim',
		keys = {
			{ '<leader>ut', '<cmd>Twilight<cr>', desc = 'Toggle Twilight' },
		},
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				color = { 'Normal', '#ffffff' },
				term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 10,      -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				'function',
				'method',
				'table',
				'if_statement',
			},
			exclude = {}, -- exclude these filetypes
		}
	},

	--[[ Statusline ]] --
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'chrisgrieser/nvim-recorder' },
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {
						'help',
						'startify',
						'dashboard',
						'packer',
						'neogitstatus',
						'NvimTree',
						'Trouble',
						'alpha',
						'lir',
						'Outline',
						'spectre_panel',
						'toggleterm',
						'qf',
					},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { function() return require('recorder').displaySlots() end,
					function() return require('recorder').recordingStatus() end },
				lualine_y = { 'encoding', 'fileformat', 'filetype' },
				lualine_z = { 'progress', 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			extensions = {}
		}
	},

	--[[ Bufferline ]] --
	{
		'akinsho/bufferline.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {},
	},

	--[[ Winbar ]] --
	{
		'fgheng/winbar.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
		opts = {
			enabled = true,
			show_file_path = true,
			show_symbols = true,
			colors = {
				path = '', -- You can customize colors like #c946fd
				file_name = '',
				symbols = '',
			},
			icons = {
				file_icon_default = '',
				seperator = '>',
				editor_state = '●',
				lock_icon = '',
			},
			exclude_filetype = {
				'help',
				'startify',
				'dashboard',
				'packer',
				'neogitstatus',
				'NvimTree',
				'Trouble',
				'alpha',
				'lir',
				'Outline',
				'spectre_panel',
				'toggleterm',
				'qf',
			}
		}
	},

	--[[ Alpha ]] --
	{
		'goolord/alpha-nvim',
		event = "VimEnter",
		enabled = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		--opts = require('alpha.themes.dashboard').config,
		config = function()
			require('alpha').setup(
				require('alpha.themes.dashboard').config
			)
		end
	},

	--[[ Dashboard ]] --
	{
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				theme = 'doom',        --  theme is doom and hyper default is hyper
				disable_move = false,  --  default is false disable move keymap for hyper
				shortcut_type = 'letter', --  shorcut type 'letter' or 'number'
				change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
				config = {
					header = {
						"",
						"",
						"",
						"",
						"                     `. ___",
						"                    __,' __`.                _..----....____",
						"        __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'",
						"  _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'",
						",'________________                          \\`-._`-','",
						" `._              ```````````------...___   '-.._'-:",
						"    ```--.._      ,.                     ````--...__\\-.",
						"            `.--. `-`                       ____    |  |`",
						"              `. `.                       ,'`````.  ;  ;`",
						"                `._`.        __________   `.      \\'__/`",
						"                   `-:._____/______/___/____`.     \\  `",
						"                               |       `._    `.    \\",
						"                               `._________`-.   `.   `.___",
						"                                             SSt  `------'`",
						"",
						"",
						"",
					}, --  config used for theme
					center = {
						{
							icon = ' ',
							icon_hl = 'Title',
							desc = 'Find File',
							desc_hl = 'String',
							key = 'h',
							key_hl = 'Number',
							action = 'Telescope find_files'
						},
						{
							icon = ' ',
							icon_hl = 'Title',
							desc = 'Recent Files',
							desc_hl = 'String',
							key = 'j',
							key_hl = 'Number',
							action = 'Telescope oldfiles'
						},
						{
							icon = ' ',
							desc = 'Find Dotfiles',
							desc_hl = 'String',
							key = 'k',
							key_hl = 'Number',
							action = 'cd ~/.config/nvim | edit .'
						},
					},
					footer = {} --your footer
				},
				hide = {
					statusline = true, -- hide statusline default is true
					tabline = true, -- hide the tabline
					winbar = true, -- hide winbar
				},
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},

	--[[ Screensaver ]] --
	{
		'folke/drop.nvim',
		event = 'VimEnter',
		opts = {
			theme = "snow",           -- can be one of rhe default themes, or a custom theme
			max = 40,                 -- maximum number of drops on the screen
			interval = 150,           -- every 150ms we update the drops
			screensaver = 2 * 60 * 1000, -- show after 5 minutes. Set to false, to disable
			filetypes = {},           -- will enable/disable automatically for the following filetypes
			winblend = 100,           -- winblend for the drop window
		}
	},
}
