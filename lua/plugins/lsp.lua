local format_on_save = true

local function toggle_format_on_save()
	format_on_save = not format_on_save
	vim.notify("Format on Save: " .. (format_on_save and "ON" or "OFF"), vim.log.levels.INFO)
end

vim.keymap.set('n', 'ttt', toggle_format_on_save, { desc = 'Toggle Formatting on Save' })

return {
	{
		'williamboman/mason.nvim',
		dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig', 'simrat39/rust-tools.nvim' },
		config = function()
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

			require("mason-lspconfig").setup_handlers {
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {}
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				["rust_analyzer"] = function()
					require("rust-tools").setup {}
				end
			}
		end,
	},
	{
		{
			'jose-elias-alvarez/null-ls.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			opts = {},
			config = function()
				local null_ls = require('null-ls')
				local formatting = null_ls.builtins.formatting
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				null_ls.setup({
					-- add your sources / config options here
					sources = {
						formatting.eslint,
						formatting.autopep8,
						formatting.stylua,
					},
					debug = false,
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
							vim.api.nvim_create_autocmd("BufWritePre", {
								group = augroup,
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format({ async = false })
								end,
							})
						end
					end,
				})
			end,
			--[[ CMP Support ]] --
			{
				'hrsh7th/nvim-cmp',
				dependencies = {
					'hrsh7th/cmp-nvim-lsp',
					'hrsh7th/cmp-nvim-lsp-signature-help',
					'hrsh7th/cmp-vsnip',
					'hrsh7th/cmp-path',
					'hrsh7th/cmp-buffer',
					'hrsh7th/vim-vsnip',

					'hrsh7th/cmp-nvim-lua',
				},
				config = function()
					local cmp = require('cmp')
					cmp.setup({
						-- Enable LSP snippets
						snippet = {
							expand = function(args)
								vim.fn["vsnip#anonymous"](args.body)
							end,
						},
						mapping = cmp.mapping.preset.insert({
							['<C-p>'] = cmp.mapping.select_prev_item(),
							['<C-n>'] = cmp.mapping.select_next_item(),
							-- Add tab support
							['<S-Tab>'] = cmp.mapping.select_prev_item(),
							['<Tab>'] = cmp.mapping.select_next_item(),
							['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
							['<C-f>'] = cmp.mapping.scroll_docs(4),
							['<C-Space>'] = cmp.mapping.complete(),
							['<C-e>'] = cmp.mapping.close(),
							['<CR>'] = cmp.mapping.confirm({
								behavior = cmp.ConfirmBehavior.Insert,
								select = true,
							})
						}),
						-- Installed sources:
						sources = cmp.config.sources({
							{ name = 'path' },                                -- file paths
							{ name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
							{ name = 'nvim_lsp_signature_help' },             -- display function signatures with current parameter emphasized
							{ name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
							{ name = 'buffer',                 keyword_length = 2 }, -- source current buffer
							{ name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
							{ name = 'calc' },                                -- source for math calculation
						}),
						window = {
							completion = cmp.config.window.bordered(),
							documentation = cmp.config.window.bordered(),
						},
						formatting = {
							fields = { 'menu', 'abbr', 'kind' },
							format = function(entry, item)
								local menu_icon = {
									nvim_lsp = 'λ',
									vsnip = '⋗',
									buffer = 'Ω',
									path = '🖫',
								}
								item.menu = menu_icon[entry.source.name]
								return item
							end,
						},
					})
				end,
			},
		} }
}
