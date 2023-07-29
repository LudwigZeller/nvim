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
		vim.lsp.buf.format({ async = false })
	end,
})
