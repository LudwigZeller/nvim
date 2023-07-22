local Util = require("util")

return {
	--[[ Telescope ]] --
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { 'nvim-lua/plenary.nvim' },
		version = false, -- telescope did only one release, so use HEAD for now
		keys = {
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<cr>",       desc = "Buffers" },
			{ "<leader>ff", Util.telescope("files"),                                  desc = "Find Files (root dir)" },
			{ "<leader>fF", Util.telescope("files", { cwd = false }),                 desc = "Find Files (cwd)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",                            desc = "Recent" },
			{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }),     desc = "Recent (cwd)" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>",                         desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>",                          desc = "status" },
			-- search
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>",                        desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",           desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>",                     desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>",                            desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                 desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>",                         desc = "Workspace diagnostics" },
			{ "<leader>sg", Util.telescope("live_grep"),                              desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }),             desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>",                           desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>",                          desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>",                             desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>",                           desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>",                               desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>",                         desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>",                              desc = "Resume" },
			{ "<leader>sw", Util.telescope("grep_string"),                            desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }),           desc = "Word (cwd)" },
			{ "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
			{
				"<leader>ss",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				Util.telescope("lsp_dynamic_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<a-t>"] = function(...)
							return require("trouble.providers.telescope").open_selected_with_trouble(...)
						end,
						["<a-i>"] = function()
							local action_state = require("telescope.actions.state")
							local line = action_state.get_current_line()
							Util.telescope("find_files", { no_ignore = true, default_text = line })()
						end,
						["<a-h>"] = function()
							local action_state = require("telescope.actions.state")
							local line = action_state.get_current_line()
							Util.telescope("find_files", { hidden = true, default_text = line })()
						end,
						["<C-Down>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-Up>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
						["<C-f>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
						["<C-b>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
					},
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
			},
		},
	},
	--[[ Nvim-Tree ]] --
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		keys = {
			{ "<leader>ft", "NvimTreeToggle", desc = "Toggle Filetree" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		}
	},

	--[[ Toggleterm ]] --
	{
		'akinsho/toggleterm.nvim',
		opts = {
			shade_terminals = false,
		},
		config = function()
			--[[ Toggleterm ]]
			--
			local Terminal = require('toggleterm.terminal').Terminal

			local horizontal = Terminal:new({ direction = "horizontal" })
			function _Horizontal_toggle() horizontal:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _Horizontal_toggle()<CR>",
				{ desc = 'Horizontal Terminal', noremap = true, silent = true })

			local vertical = Terminal:new({ direction = "vertical" })
			function _Vertical_toggle() vertical:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _Vertical_toggle()<CR>",
				{ desc = 'Verical Terminal', noremap = true, silent = true })

			local float = Terminal:new({ direction = "float" })
			function _Float_toggle() float:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _Float_toggle()<CR>",
				{ desc = 'Floating Terminal', noremap = true, silent = true })

			local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
			function _Htop_toggle() htop:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _Htop_toggle()<CR>",
				{ desc = 'HTop', noremap = true, silent = true })

			local ncspot = Terminal:new({ cmd = "ncspot", hidden = true, direction = "float" })
			function _Ncspot_toggle() ncspot:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua _Ncspot_toggle()<CR>",
				{ desc = 'NcSpot', noremap = true, silent = true })

			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
			function _Lazygit_toggle() lazygit:toggle() end

			vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua _Lazygit_toggle()<CR>",
				{ desc = 'LazyGit', noremap = true, silent = true })
		end,
	},

	--[[ Trouble ]] --
	{
		'folke/trouble.nvim',
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
		},
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
					header = {},         --  config used for theme
					center = {
						{
							icon = ' ',
							icon_hl = 'Title',
							desc = 'Find File           ',
							desc_hl = 'String',
							key = 'b',
							keymap = 'SPC f f',
							key_hl = 'Number',
							action = 'lua print(2)'
						},
						{
							icon = ' ',
							desc = 'Find Dotfiles',
							key = 'f',
							keymap = 'SPC f d',
							action = 'lua print(3)'
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
}
