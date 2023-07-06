require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _lazygit_toggle() lazygit:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { desc = 'LazyGit', noremap = true, silent = true })

local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
function _htop_toggle() htop:toggle() end
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _htop_toggle()<CR>", { desc = 'HTop', noremap = true, silent = true })

