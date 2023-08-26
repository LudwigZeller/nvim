return {
	--[[ CMP Support ]]
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",

			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			local cmp = require("cmp")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local feedkey = function(key, mode)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
			end
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
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn["vsnip#available"](1) == 1 then
							feedkey("<Plug>(vsnip-expand-or-jump)", "")
							-- elseif has_words_before() then
							-- 	cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							feedkey("<Plug>(vsnip-jump-prev)", "")
						end
					end, { "i", "s" }),
					-- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
					-- ["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					-- ["<CR>"] =  function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.confirm()
					-- 	else
					-- 		fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
					-- 	end
					-- end,
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "path",                   priority = 2,      keyword_length = 3 }, -- file paths
					{ name = "nvim_lsp",               priority = 3,      keyword_length = 1 }, -- from language server
					{ name = "nvim_lsp_signature_help" },                                  -- display function signatures with current parameter emphasized
					{ name = "nvim_lua",               keyword_length = 1 },               -- complete neovim's Lua runtime API such vim.lsp.*
					{ name = "buffer",                 priority = 1,      keyword_length = 3 }, -- source current buffer
					{ name = "vsnip",                  priority = 3,      keyword_length = 1 }, -- nvim-cmp source for vim-vsnip
					{ name = "calc" },                                                     -- source for math calculation
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
		end,
	},
	{
		'abecodes/tabout.nvim',
		event = "VeryLazy",
		dependencies = {
			'nvim-treesitter', -- or require if not used so far
			'nvim-cmp'      -- if a completion plugin is using tabs load it before
		},
		opts = {
			tabkey = '<Tab>',          -- key to trigger tabout, set to an empty string to disable
			backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
			act_as_tab = true,         -- shift content if tab out is not possible
			act_as_shift_tab = false,  -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
			default_tab = '<C-t>',     -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
			default_shift_tab = '<C-d>', -- reverse shift default action,
			enable_backwards = true,   -- well ...
			completion = true,         -- if the tabkey is used in a completion pum
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = '`', close = '`' },
				{ open = '(', close = ')' },
				{ open = '[', close = ']' },
				{ open = '{', close = '}' },
				{ open = '<', close = '>' },
				{ open = '<', close = '/>' },
			},
			ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
			exclude = {} -- tabout will ignore these filetypes

		},
		config = true,
	},
	--[[ Autopair ]]
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			-- If you want insert `(` after select function or method item
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end,
	},
}
