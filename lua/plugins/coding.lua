return {
	{
		'jose-elias-alvarez/null-ls.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
		config = function ()
			local async_formatting = function(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()

			vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    -- add your sources / config options here
    -- sources = ...,
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})
		end,

	--[[ CMP Support ]]--
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
					{ name = 'path' },                              -- file paths
					{ name = 'nvim_lsp', keyword_length = 3 },      -- from language server
					{ name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
					{ name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
					{ name = 'buffer', keyword_length = 2 },        -- source current buffer
					{ name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
					{ name = 'calc'},                               -- source for math calculation
				}),
				window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
				},
				formatting = {
						fields = {'menu', 'abbr', 'kind'},
						format = function(entry, item)
								local menu_icon ={
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


}}
