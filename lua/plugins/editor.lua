return {
	--[[ Nvim-Tree ]]--
	{
		"nvim-tree/nvim-tree.lua",
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

	--[[ Toggleterm ]]--
	{
		'akinsho/toggleterm.nvim',
		opts = {
			shade_terminals = false,
		}
	},

	--[[ Trouble ]]--
	{
	 "folke/trouble.nvim",
	 dependencies = { "nvim-tree/nvim-web-devicons" },
	 opts = {
	 },
	},
}
