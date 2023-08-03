vim.keymap.set("i", "jk", "<ESC>", { nowait = true, desc = "Normal Mode" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>write<cr>", { nowait = true, desc = "Safe Buffer" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { nowait = true, desc = "Quit Neovim" })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
vim.keymap.set(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--[[ Add undo break-points ]]
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

--[[ better indenting ]]
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

--[[ Diagnostics/Quickfix ]]
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

--[[ Terminal Mappings ]]
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

--[[ Windows ]]
vim.keymap.set("n", "<leader>ww", "<C-W>w", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wc", "<C-W>c", { desc = "Close window", remap = true })
vim.keymap.set("n", "<leader>wh", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wo", "<C-W>o", { desc = "Close all other windows", remap = true })

--[[ Buffers ]]
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-S-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-S-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previos buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>bk", "<cmd>BufferLinePickClose<cr>", { desc = "Pick and close buffer" })
vim.keymap.set("n", "<leader>bx", "<cmd>BufferLineCloseOther<cr>", { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bt", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin current buffer" })

--[[ Tabs ]]
vim.keymap.set("n", "<leader>ph", "<cmd>tabprevious<cr>", { desc = "Previos tab" })
vim.keymap.set("n", "<leader>pl", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>pn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>pc", "<cmd>tabclose<cr>", { desc = "Close tab" })

--[[ LSP ]]
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "<leader>xa", vim.lsp.buf.code_action, { desc = "Code Action" })
		vim.keymap.set("n", "<leader>xc", vim.lsp.buf.rename, { desc = "Rename Sign" })
		require("which-key").register({})
	end,
})
