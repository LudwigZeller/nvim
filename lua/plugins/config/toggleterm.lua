require("toggleterm").setup({
	function(term)
    if term.direction == "horizontal" then
      return vim.o.rows * 0.2
		elseif term.direction == "vertical" then
      return vim.o.columns * 0.8
    end
		return 20
  end,
})

local Terminal = require('toggleterm.terminal').Terminal

local horizontal = Terminal:new({ direction = "horizontal" })
function _horizontal_toggle() horizontal:toggle() end
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _horizontal_toggle()<CR>", { desc = 'Horizontal Terminal', noremap = true, silent = true })

local vertical = Terminal:new({ direction = "vertical" })
function _vertical_toggle() vertical:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _vertical_toggle()<CR>", { desc = 'Verical Terminal', noremap = true, silent = true })

local float = Terminal:new({ direction = "float" })
function _float_toggle() float:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _float_toggle()<CR>", { desc = 'Floating Terminal', noremap = true, silent = true })

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _lazygit_toggle() lazygit:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { desc = 'LazyGit', noremap = true, silent = true })

local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
function _htop_toggle() htop:toggle() end
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _htop_toggle()<CR>", { desc = 'HTop', noremap = true, silent = true })

local ncspot = Terminal:new({ cmd = "ncspot", hidden = true, direction = "float" })
function _ncspot_toggle() ncspot:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua _ncspot_toggle()<CR>", { desc = 'NcSpot', noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
