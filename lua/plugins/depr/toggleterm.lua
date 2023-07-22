return {
	'akinsho/toggleterm.nvim',
	version = '*',
	opts = {
		size = function(term)
			if term.direction == "vertical" then
				return vim.o.columns * 0.4
			elseif term.direction == "horizontal" then
				return 15
			end
		end,
		shade_terminals = false,
	}
}
