return {
	{ "folke/neodev.nvim", priority = 100 },

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	--[[ Window Layout after Bufferclose ]]
	{ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },

	--[[ Learn Neovim ]]
	{
		"m4xshen/hardtime.nvim",
		event = "UIEnter",
		keys = {
			{ "<leader>uh", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
		},
		opts = {},
	},

	--[[ Flash ]]
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"f",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"F",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	--[[ Nvim Surround ]]
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	--[[ Comment ]]
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				extra = {
					above = "gcO",
					below = "gco",
					eol = "gcA",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},

	--[[ Session Management ]]
	{
		"Shatur/neovim-session-manager",
		cmd = "SessionManager",
		keys = {
			{ "<leader>qs", "<cmd>SessionManager save_current_session<cr>", desc = "Save current Session" },
			{
				"<leader>qr",
				"<cmd>SessionManager load_current_dir_session<cr>",
				desc = "Restore Session based on CWD",
			},
			{ "<leader>ql", "<cmd>SessionManager load_session<cr>", desc = "List Sessions" },
			{ "<leader>qo", "<cmd>SessionManager load_last_session<cr>", desc = "Load last Sessions" },
			{ "<leader>qx", "<cmd>SessionManager delete_session<cr>", desc = "Delete Sessions" },
		},
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				sessions_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
				autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit and on session switch.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
				autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
				autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
					"gitcommit",
					"gitrebase",
				},
				autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
				autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
				max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})
		end,
	},

	--[[ Scope ]]
	{
		"tiagovla/scope.nvim",
		config = true,
	},

	--[[ Improved Macros ]]
	{
		"ecthelionvi/NeoComposer.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		event = "BufEnter",
		keys = {
			{
				"<leader>sr",
				"<cmd>Telescope macros<cr>",
				desc = "Symbols",
			},
		},
		config = function()
			require("NeoComposer").setup({
				notify = false,
				delay_timer = 150,
				colors = {
					bg = "bg",
					fg = "fg",
					red = "#ec5f67",
					blue = "#5fb3b3",
					green = "#99c794",
				},
				keymaps = {
					play_macro = "Q",
					yank_macro = "yq",
					stop_macro = "cq",
					toggle_record = "q",
					cycle_next = "<c-n>",
					cycle_prev = "<c-p>",
					toggle_macro_menu = "<m-q>",
				},
			})

			require("telescope").load_extension("macros")
		end,
	},

	--[[ makes plugins dot-repeatable ]]
	{ "tpope/vim-repeat", event = "VeryLazy" },
}
