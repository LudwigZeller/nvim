local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--[[ Neovide ]]
if vim.g.neovide then
	require("neovide")
end

--[[ Variables ]]
require("opts")

--[[ Lazy ]]
require("lazy").setup("plugins")

--[[ Keymap ]]
require("keymap")

--[[ Autocommands ]]
require("autocmd")

-- Themery block
-- This block will be replaced by Themery.
vim.cmd("colorscheme kanagawa-wave")
-- end themery block
