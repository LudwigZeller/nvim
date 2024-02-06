--[[ Format on Save ]]
local format_on_save = true
local function toggle_format_on_save()
  format_on_save = not format_on_save
  vim.notify("Format on Save: " .. (format_on_save and "ON" or "OFF"), vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>fp", toggle_format_on_save, { desc = "Toggle Formatting on Save" })

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if format_on_save then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

--[[ Overseer Session Restore ]]
local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  return dir:gsub("[^A-Za-z0-9]", "_")
end
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionSavePre",
  group = vim.api.nvim_create_augroup("OverseerSession", { clear = false }),
  callback = function()
    require("overseer").delete_task_bundle(get_cwd_as_name())
    require("overseer").save_task_bundle(
      get_cwd_as_name(),
      nil,
      { on_conflict = "overwrite" } -- Overwrite existing bundle, if any
    )
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPre",
  group = vim.api.nvim_create_augroup("OverseerSession", { clear = false }),
  callback = function()
    for _, task in ipairs(require("overseer").list_tasks({})) do
      task:dispose(true)
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPost",
  group = vim.api.nvim_create_augroup("OverseerSession", { clear = false }),
  callback = function()
    require("overseer").load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
  end,
})

--[[ Quit Windows ]]
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil or bufname:match("Overseer") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= "" then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	group = vim.api.nvim_create_augroup("Ufo-Folds", { clear = false }),
-- 	callback = function()
-- 		require("ufo").peekFoldedLinesUnderCursor()
-- 	end,
-- })
