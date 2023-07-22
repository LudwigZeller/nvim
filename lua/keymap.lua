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

