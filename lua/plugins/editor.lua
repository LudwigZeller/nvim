return {
	--[[ Telescope ]]
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-symbols.nvim" },
		version = false, -- telescope did only one release, so use HEAD for now
		keys = {
			-- find
			{
				"<leader>fb",
				"<cmd>Telescope buffers show_all_buffers=true<cr>",
				desc = "Buffers",
			},
			{
				"<leader>ff",
				"<cmd>lua require('telescope.builtin').find_files({ cwd=vim.lsp.buf.list_workspace_folders()[1] })<cr>",
				desc = "Find Files (root dir)",
			},
			{
				"<leader>fF",
				"<cmd>Telescope find_files<cr>",
				desc = "Find Files (cwd)",
			},
			{
				"<leader>fr",
				"<cmd>Telescope oldfiles<cr>",
				desc = "Recent",
			},
			{
				"<leader>fR",
				"<cmd>lua require('telescope.builtin').oldfiles({ cwd=vim.loop.cwd() })<cr>",
				desc = "Recent (cwd)",
			},
			-- git
			{
				"<leader>gc",
				"<cmd>Telescope git_commits<cr>",
				desc = "commits",
			},
			{
				"<leader>gs",
				"<cmd>Telescope git_status<cr>",
				desc = "status",
			},
			-- search
			{
				"<leader>sa",
				"<cmd>Telescope autocommands<cr>",
				desc = "Auto Commands",
			},
			{
				"<leader>se",
				"<cmd>Telescope symbols<cr>",
				desc = "Symbols",
			},

			{
				"<leader>sb",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Buffer",
			},
			{
				"<leader>sc",
				"<cmd>Telescope command_history<cr>",
				desc = "Command History",
			},
			{
				"<leader>sC",
				"<cmd>Telescope commands<cr>",
				desc = "Commands",
			},
			{
				"<leader>sd",
				"<cmd>Telescope diagnostics bufnr=0<cr>",
				desc = "Document diagnostics",
			},
			{
				"<leader>sD",
				"<cmd>Telescope diagnostics<cr>",
				desc = "Workspace diagnostics",
			},
			{
				"<leader>sg",
				"<cmd>lua require('telescope.builtin').live_grep({ cwd=vim.lsp.buf.list_workspace_folders()[1] })<cr>",
				desc = "Grep (root dir)",
			},
			{
				"<leader>sG",
				"<cmd>Telescope live_grep<cr>",
				desc = "Grep (cwd)",
			},
			{
				"<leader>sh",
				"<cmd>Telescope help_tags<cr>",
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				"<cmd>Telescope highlights<cr>",
				desc = "Search Highlight Groups",
			},
			{
				"<leader>sk",
				"<cmd>Telescope keymaps<cr>",
				desc = "Key Maps",
			},
			{
				"<leader>sM",
				"<cmd>Telescope man_pages<cr>",
				desc = "Man Pages",
			},
			{
				"<leader>sm",
				"<cmd>Telescope marks<cr>",
				desc = "Jump to Mark",
			},
			{
				"<leader>so",
				"<cmd>Telescope vim_options<cr>",
				desc = "Options",
			},
			{
				"<leader>sR",
				"<cmd>Telescope resume<cr>",
				desc = "Resume",
			},
			{
				"<leader>sw",
				"<cmd>Telescope grep_string<cr>",
				desc = "Word (root dir)",
			},
			{
				"<leader>sW",
				"<cmd>Telescope grep_string<cr>",
				desc = "Word (cwd)",
			},
			{
				"<leader>ss",
				'<cmd>lua require(\'telescope.builtin\').lsp_document_symbols({ symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property", }, })<cr>',
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				"lsp_dynamic_workspace_symbols",
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
							require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
						end,
						["<a-h>"] = function()
							local action_state = require("telescope.actions.state")
							local line = action_state.get_current_line()
							require("telescope.builtin").find_files({ hidden = true, default_text = line })
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

	--[[ Treesitter ]]
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua" },
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				ident = { enable = true },
				autotag = { enable = true },
			})
		end,
	},

	--[[ Code Runner ]]
	{
		keys = {
			{ "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle Task List" },
			{ "<leader>rr", "<cmd>OverseerRun<cr>",    desc = "Run Task" },
			{ "<leader>rn", "<cmd>OverseerBuild<cr>",  desc = "Create Task" },
		},
		"stevearc/overseer.nvim",
		opts = {
			strategy = {
				"toggleterm",
				use_shell = false,
				direction = "horizontal",
				highlights = nil,
				auto_scroll = nil,
				close_on_exit = false,
				-- can be "never, "success", or "always". "success" will close the window
				quit_on_exit = "never",
				open_on_start = false,
				hidden = true,
				on_create = nil,
			},
			component_aliases = {
				-- Most tasks are initialized with the default components
				default = {
					{ "display_duration",    detail_level = 2 },
					{ "on_output_summarize", max_lines = 8 },
					"on_exit_set_status",
					{ "on_complete_notify", statuses = { "FAILURE" } },
					-- "on_complete_dispose",
				},
				-- Tasks from tasks.json use these components
				default_vscode = {
					"default",
					"on_result_diagnostics",
					"on_result_diagnostics_quickfix",
				},
			},
			task_list = {
				direction = "right",
				bindings = {
					["?"] = "ShowHelp",
					["g?"] = "ShowHelp",
					["<CR>"] = "RunAction",
					["<C-e>"] = "Edit",
					["o"] = "Open",
					["<C-v>"] = "OpenVsplit",
					["<C-s>"] = "OpenSplit",
					["<C-f>"] = "OpenFloat",
					["<C-q>"] = "OpenQuickFix",
					["p"] = "TogglePreview",
					["<S-l>"] = "IncreaseDetail",
					["<S-h>"] = "DecreaseDetail",
					["{"] = "PrevTask",
					["}"] = "NextTask",
					["<C-k>"] = "ScrollOutputUp",
					["<C-j>"] = "ScrollOutputDown",
				},
			},
		},
	},

	--[[ Filetree ]]
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>ft", "<cmd>Neotree toggle<cr>" },
		},
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the commands with "_with_window_picker" suffix
				's1n7ax/nvim-window-picker',
				config = function()
					require 'window-picker'.setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							bo = {
								filetype = { 'neo-tree', "neo-tree-popup", "notify" },
								buftype = { 'terminal', "quickfix" },
							},
						},
						other_win_hl_color = '#e35e4f',
					})
				end,
			},
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				default_component_configs = {
					container = {
						enable_character_fade = true
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
						-- then these will never be used.
						default = "*",
						highlight = "NeoTreeFileIcon"
					},
					modified = {
						symbol = "󱇧",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = false,
						highlight = "NeoTreeFileName",
					},
					git_status = {
						symbols = {
							-- Change type
							added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted   = "󰆴", -- this can only be used in the git_status source
							renamed   = "󰁕", -- this can only be used in the git_status source
							-- Status type
							untracked = "",
							ignored   = "",
							unstaged  = "󰄱",
							staged    = "",
							conflict  = "",
						}
					},
					file_size = {
						enabled = true,
						required_width = 64, -- min width of window required to show this column
					},
					type = {
						enabled = true,
						required_width = 122, -- min width of window required to show this column
					},
					last_modified = {
						enabled = true,
						required_width = 88, -- min width of window required to show this column
					},
					created = {
						enabled = true,
						required_width = 110, -- min width of window required to show this column
					},
					filesystem = {
						hijack_netrw_behavior = "open_current",
					},
				},
			})
		end,
	},
	{
		'antosha417/nvim-lsp-file-operations',
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = true,
	},


	{
		enabled = false,
		"nvim-tree/nvim-tree.lua",
		-- event = "VeryLazy",
		keys = {
			{ "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Filetree" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "antosha417/nvim-lsp-file-operations", config = true }
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				sync_root_with_cwd = true,
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},

	--[[ Gitsigns ]]
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true,  -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			})

			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Hunk" })
			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previos Hunk" })
			vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage Hunk" })
			vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset Hunk" })
			vim.keymap.set("v", "<leader>ghs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage Hunk" })
			vim.keymap.set("v", "<leader>ghr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset Hunk" })
			vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
			vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
			vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
			vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
			vim.keymap.set("n", "<leader>ghb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame Line" })
			vim.keymap.set("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Current Blame Line" })
			vim.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diffthis" })
			vim.keymap.set("n", "<leader>ghD", function()
				gs.diffthis("~")
			end, { desc = "Diffthis (~)" })
			vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, { desc = "Deleted" })
			vim.keymap.set({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>")
		end,
	},

	--[[ Toggleterm ]]
	--
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<leader>th",
				function()
					if _Toggleterm == nil then
						_Toggleterm = require("toggleterm.terminal").Terminal:new()
					end
					_Toggleterm:toggle(0, "horizontal")
				end,
				desc = "Horizontal Terminal",
			},
			{
				"<leader>tv",
				function()
					if _Toggleterm == nil then
						_Toggleterm = require("toggleterm.terminal").Terminal:new()
					end
					_Toggleterm:toggle(0, "vertical")
				end,
				desc = "Vertical Terminal",
			},
			{
				"<leader>tf",
				function()
					if _Toggleterm == nil then
						_Toggleterm = require("toggleterm.terminal").Terminal:new({ direction = "float" })
					end
					_Toggleterm:toggle(0, "float")
				end,
				desc = "Float Terminal",
			},
			{
				"<leader>ts",
				function()
					if _Htop == nil then
						_Htop = require("toggleterm.terminal").Terminal:new({
							cmd = "htop",
							hidden = true,
							direction = "float",
						})
					end
					_Htop:toggle()
				end,
				desc = "HTop",
			},
			{
				"<leader>tm",
				function()
					if _Music == nil then
						local cmd = "ncspot";
						if vim.fn.executable("spt") == 1 then
							cmd = "spt"
						end
						_Music = require("toggleterm.terminal").Terminal:new({
							cmd = cmd,
							hidden = true,
							direction = "float",
						})
					end
					_Music:toggle()
				end,
				desc = "Music",
			},
			{
				"<leader>gl",
				function()
					if _Lazygit == nil then
						_Lazygit = require("toggleterm.terminal").Terminal:new({
							cmd = "lazygit",
							hidden = true,
							direction = "float",
						})
					end
					_Lazygit:toggle()
				end,
				desc = "LazyGit",
			},
		},
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 10
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.3
					end
					return 20
				end,
				shade_terminals = false,
				autochdir = true,
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
			})
		end,
	},

	--[[ Trouble ]]
	{
		-- TODO: Configure
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Dignostics" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostic" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },

		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			use_diagnostic_signs = true,
		},

	},
}
