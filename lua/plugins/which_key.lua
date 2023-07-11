return {
  'folke/which-key.nvim',
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
			padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 50, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			zindex = 1000, -- positive value to position WhichKey above other floating windows.
		},
	}
}
