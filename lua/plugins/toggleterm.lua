return {
	'akinsho/toggleterm.nvim',
	opts = {
		shade_terminals = true,
		winbar = {
			enabled = true,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end
		},
	}
}
