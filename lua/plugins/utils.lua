return {
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

	--[[ makes plugins dot-repeatable ]] --
	{ "tpope/vim-repeat",  event = "VeryLazy" },

	--[[ Lua + Nvim ]] --
	{ 'folke/neodev.nvim', },

}
