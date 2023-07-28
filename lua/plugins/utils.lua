return {
	{ "folke/neodev.nvim", opts = {},         priority = 100 },
	--[[ Flash ]]
	--
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
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
		enabled = false,
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
		"folke/persistence.nvim",
		event = "BufReadPre",                                        -- this will only start session saving when an actual file was opened
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
			options = {
				"blank",
				"buffers",
				"curdir",
				"folds",
				"help",
				"tabpages",
				"winsize",
				"winpos",
				"terminal",
				"localoptions",
			},
			pre_save = nil, -- a function to call before saving the session
		},
	},
	{
		enabled = false,
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			{ "<leader>qs", "<cmd>SessionSave<cr>",        desc = "Save current Session" },
			{ "<leader>qd", "<cmd>SessionSave<cr>",        desc = "Delete current Session" },
			{ "<leader>qr", "<cmd>SessionRestore<cr>",     desc = "Restore Session based on CWD" },
			{ "<leader>ql", "<cmd>Autosession search<cr>", desc = "List Sessions" },
			{ "<leader>qx", "<cmd>Autosession delete<cr>", desc = "Delete Sessions" },
		},
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
				auto_session_enable_last_session = false,
				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_session_create_enabled = false,
				auto_restore_enabled = false,
				auto_session_use_git_branch = false,
				cwd_change_handling = {
					restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
					pre_cwd_changed_hook = nil,   -- already the default, no need to specify like this, only here as an example
					post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
						require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
					end,
				},
			})
		end,
	},

	--[[ Scope ]]
	{
		"tiagovla/scope.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("scope").setup({})
			require("telescope").load_extension("scope")
		end,
	},

	--[[ Improved Macros ]]
	--
	{
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify", -- optional
		opts = {
			slots = { "a", "b", "c", "d", "e" },
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = "<C-q>",
				editMacro = "cq",
				yankMacro = "yq",
				addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
			},
			clear = true,
			logLevel = vim.log.levels.INFO,
			lessNotifications = false,
			useNerdfontIcons = true,
			performanceOpts = {
				countThreshold = 100,
				lazyredraw = true,    -- enable lazyredraw (see `:h lazyredraw`)
				noSystemClipboard = true, -- remove `+`/`*` from clipboard option
				autocmdEventsIgnore = { -- temporarily ignore these autocmd events
					"TextChangedI",
					"TextChanged",
					"InsertLeave",
					"InsertEnter",
					"InsertCharPre",
				},
			},
			dapSharedKeymaps = false,
		},
	},

	--[[ makes plugins dot-repeatable ]]
	--
	{ "tpope/vim-repeat",  event = "VeryLazy" },

	--[[ Lua + Nvim ]]
	--
	{ "folke/neodev.nvim" },
}
