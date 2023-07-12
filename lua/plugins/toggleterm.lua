return {
	'akinsho/toggleterm.nvim',
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.rows * 0.2
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
			return 20
		end,
	}
}
