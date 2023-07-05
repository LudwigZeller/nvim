--[[ Neovide ]]--
if vim.g.neovide then require("core.neovide") end

--[[ Bootstraping ]]--
require("core.bootstrap")

--[[ Optionals ]]--
require("core.opt")

--[[ Mappings ]]--
require("core.keymap")




--[[ Mason ]]--
require("mason").setup({
    ui = {
        icons = {
         		package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()




local wk = require("which-key")
wk.register()

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})



