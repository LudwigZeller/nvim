vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

vim.keymap.set('i', 'jk', '<ESC>', { nowait = true, desc = 'Normal Mode' })

--[[ Tabs ]]--
vim.keymap.set('n', '<m-h>', '<cmd>tabprevious<cr>', { desc = 'Previos Tab' })
vim.keymap.set('n', '<m-l>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<M-S-H>', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<M-S-L>', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader>c', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

