vim.keymap.set('i', 'jk', '<ESC>', { nowait = true, desc = 'Normal Mode' })

--[[ Buffers ]]--
vim.keymap.set('n', '<leader>bh', '<cmd>bprevious<cr>', { desc = 'Previos Buffer' })
vim.keymap.set('n', '<leader>bl', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>b<S-h>', '<cmd>bfirst<cr>', { desc = 'First Buffer' })
vim.keymap.set('n', '<leader>b<S-l>', '<cmd>blast<cr>', { desc = 'Last Buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })
vim.keymap.set('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = 'Pick Buffer' })
vim.keymap.set('n', '<leader>bk', '<cmd>BufferLinePickClose<cr>', { desc = 'Pick and Close Buffer' })
vim.keymap.set('n', '<leader>bx', '<cmd>BufferLineCloseOther<cr>', { desc = 'Close other Buffers' })

--[[ Tabs ]]--
vim.keymap.set('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previos Tab' })
vim.keymap.set('n', '<leader><tab>t', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab><S-h>', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab><S-l>', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>c', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

--[[ Hop ]]--
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', '<leader>fl', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, { desc = "Find on line after cursor", remap = true })
vim.keymap.set('', '<leader>fh', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, { desc = "Find on line before cursor", remap=true })
vim.keymap.set('', '<leader>f<S-l>', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false }) end, { desc = "Find after cursor", remap=true })
vim.keymap.set('', '<leader>f<S-h>', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false }) end, { desc = "Find before cursor", remap=true })

--[[ Toggleterm ]]--
local Terminal = require('toggleterm.terminal').Terminal

local horizontal = Terminal:new({ direction = "horizontal" })
function _Horizontal_toggle() horizontal:toggle() end
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _Horizontal_toggle()<CR>", { desc = 'Horizontal Terminal', noremap = true, silent = true })

local vertical = Terminal:new({ direction = "vertical" })
function _Vertical_toggle() vertical:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _Vertical_toggle()<CR>", { desc = 'Verical Terminal', noremap = true, silent = true })

local float = Terminal:new({ direction = "float" })
function _Float_toggle() float:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _Float_toggle()<CR>", { desc = 'Floating Terminal', noremap = true, silent = true })

local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
function _Htop_toggle() htop:toggle() end
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua _Htop_toggle()<CR>", { desc = 'HTop', noremap = true, silent = true })

local ncspot = Terminal:new({ cmd = "ncspot", hidden = true, direction = "float" })
function _Ncspot_toggle() ncspot:toggle() end
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua _Ncspot_toggle()<CR>", { desc = 'NcSpot', noremap = true, silent = true })

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _Lazygit_toggle() lazygit:toggle() end
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua _Lazygit_toggle()<CR>", { desc = 'LazyGit', noremap = true, silent = true })


