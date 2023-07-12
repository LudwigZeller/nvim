return {
  'folke/which-key.nvim',
	opts = {
		window = {
		  border = "shadow", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 2, 10, 2, 10 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
			padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 50, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			zindex = 1000, -- positive value to position WhichKey above other floating windows.
		},
		plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        --["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
				["<leader>t"] = { name = "+terminal" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        --["<leader>u"] = { name = "+ui" },
        --["<leader>w"] = { name = "+windows" },
        --["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
}

