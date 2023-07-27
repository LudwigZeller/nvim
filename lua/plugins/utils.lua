return {
{ "folke/neodev.nvim", opts = {}, priority = 100 },
	--[[ Flash ]] --
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					jump_labels = true
				}
			}
		},
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
			{
				"R",
				mode = { "o", "x" },
				function() require("flash").treesitter_search() end,
				desc =
				"Treesitter Search"
			},
			{
				"<c-s>",
				mode = { "c" },
				function() require("flash").toggle() end,
				desc =
				"Toggle Flash Search"
			},
		},
	},
	-- [[ Session Management ]]--
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
		-- stylua: ignore
		keys = {
			{ "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{ "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
		},
	},

	--[[ Scope ]] --
	{
		'tiagovla/scope.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		config = function()
			require("scope").setup({})
			require("telescope").load_extension("scope")
		end
	},

	--[[ Improved Macros ]] --
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

	--[[ makes plugins dot-repeatable ]] --
	{ "tpope/vim-repeat",  event = "VeryLazy" },

	--[[ Lua + Nvim ]] --
	{ 'folke/neodev.nvim', },

}
