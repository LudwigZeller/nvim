vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

vim.keymap.set('i', 'jk', '<ESC>', { nowait = true, desc = 'Normal Mode' })

--[[ Buffers ]]--
vim.keymap.set('n', '<M-h>', '<cmd>bprevious<cr>', { desc = '' })
vim.keymap.set('n', '<M-l>', '<cmd>bnext<cr>', { desc = '' })
vim.keymap.set('n', '<M-S-h>', '<cmd>bfirst<cr>', { desc = '' })
vim.keymap.set('n', '<M-S-l>', '<cmd>blast<cr>', { desc = '' })
vim.keymap.set('n', '<M-w>', '<cmd>enew<cr>', { desc = '' })
vim.keymap.set('n', '<M-q>', '<cmd>bdelete<cr>', { desc = '' })

--[[ Tabs ]]--
vim.keymap.set('n', '<m-s-h>', '<cmd>tabprevious<cr>', { desc = 'Previos Tab' })
vim.keymap.set('n', '<m-s-l>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<C-M-S-H>', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<C-M-S-L>', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<M-S-w>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<M-S-q>', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

