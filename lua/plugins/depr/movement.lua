return {
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
				{ desc = "Flash", remap = true },
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				{ desc = "Flash Treesitter", remap = true },
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				{ desc = "Remote Flash", remap = true },
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				{ desc = "Treesitter Search", remap = true },
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
}
