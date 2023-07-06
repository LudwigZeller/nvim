--[[ ToggleTerm ]]--
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _lazygit_toggle() lazygit:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { desc = 'LazyGit', noremap = true, silent = true })

local htop = Terminal:new({ cmd = "htop", hidden = true })
function _htop_toggle() htop:toggle() end
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _htop_toggle()<CR>", { desc = 'HTop', noremap = true, silent = true })

--[[ Hop ]]––
local asdhop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, {remap=true})
vim.keymap.set('', 'F', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, {remap=true})
vim.keymap.set('', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, {remap=true})
vim.keymap.set('', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end, {remap=true})
