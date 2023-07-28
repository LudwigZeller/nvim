return {
	--[[ Telescope ]]
	--
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
				"<leader>uC",
				"<cmd>Telescope colorscheme enable_preview=true<cr>",
				desc = "Colorscheme with preview",
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
	--
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ident = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		},
	},

	--[[ Nvim-Tree ]]
	--
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		keys = {
			{ "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Filetree" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
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
			})
			vim.api.nvim_create_autocmd("QuitPre", {
				callback = function()
					local tree_wins = {}
					local floating_wins = {}
					local wins = vim.api.nvim_list_wins()
					for _, w in ipairs(wins) do
						local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
						if bufname:match("NvimTree_") ~= nil then
							table.insert(tree_wins, w)
						end
						if vim.api.nvim_win_get_config(w).relative ~= "" then
							table.insert(floating_wins, w)
						end
					end
					if 1 == #wins - #floating_wins - #tree_wins then
						-- Should quit, so we close all invalid windows.
						for _, w in ipairs(tree_wins) do
							vim.api.nvim_win_close(w, true)
						end
					end
				end,
			})
		end,
	},

	--[[ Gitsigns ]]
	--
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")

			gs.setup({
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
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
			})

			local Terminal = require("toggleterm.terminal").Terminal

			local horizontal = Terminal:new({ direction = "horizontal" })
			function _Horizontal_toggle()
				horizontal:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>th",
				"<cmd>lua _Horizontal_toggle()<CR>",
				{ desc = "Horizontal Terminal", noremap = true, silent = true }
			)

			local vertical = Terminal:new({ direction = "vertical" })
			function _Vertical_toggle()
				vertical:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>tv",
				"<cmd>lua _Vertical_toggle()<CR>",
				{ desc = "Verical Terminal", noremap = true, silent = true }
			)

			local float = Terminal:new({ direction = "float" })
			function _Float_toggle()
				float:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>tf",
				"<cmd>lua _Float_toggle()<CR>",
				{ desc = "Floating Terminal", noremap = true, silent = true }
			)

			local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
			function _Htop_toggle()
				htop:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>ts",
				"<cmd>lua _Htop_toggle()<CR>",
				{ desc = "HTop", noremap = true, silent = true }
			)

			local ncspot = Terminal:new({ cmd = "ncspot", hidden = true, direction = "float" })
			function _Ncspot_toggle()
				ncspot:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>tm",
				"<cmd>lua _Ncspot_toggle()<CR>",
				{ desc = "NcSpot", noremap = true, silent = true }
			)

			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
			function _Lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>gl",
				"<cmd>lua _Lazygit_toggle()<CR>",
				{ desc = "LazyGit", noremap = true, silent = true }
			)
		end,
	},

	--[[ Trouble ]]
	--
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
}
