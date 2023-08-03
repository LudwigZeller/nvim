return {
	--[[ CMP Support ]]
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/vim-vsnip",

			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Add tab support
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "path",                   priority = 2,      keyword_length = 2 }, -- file paths
					{ name = "nvim_lsp",               priority = 3,      keyword_length = 2 }, -- from language server
					{ name = "nvim_lsp_signature_help" },               -- display function signatures with current parameter emphasized
					{ name = "nvim_lua",               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
					{ name = "buffer",                 priority = 1,      keyword_length = 2 }, -- source current buffer
					{ name = "vsnip",                  priority = 3,      keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
					{ name = "calc" },                                  -- source for math calculation
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = "λ",
							vsnip = "⋗",
							buffer = "Ω",
							path = "🖫",
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
