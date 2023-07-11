-- Treesitter Plugin Setup 
return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	optgs = {
		ensure_installed = { "lua" },
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting=false,
		},
		ident = { enable = true },
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		}
	},
}
