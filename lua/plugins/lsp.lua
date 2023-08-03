return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig", "simrat39/rust-tools.nvim" },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "",
					},
				},
			})

			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["lua_ls"] = function()
					-- TODO: Enforce Range Formatting
					require("lspconfig").lua_ls.setup({
						settings = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							format = { enable = false },
						},
					})
				end,
				["rust_analyzer"] = function()
					require("rust-tools").setup({
						server = {
							settings = {
								["rust-analyzer"] = {
									checkOnSave = {
										command = "clippy",
									},
								},
							},
						},
						tools = {
							executor = require("rust-tools.executors").toggleterm,
						},
					})
				end,
			})
		end,
	},

	{
		enabled = false,
		"mfussenegger/nvim-lint",
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			null_ls.setup({
				-- add your sources / config options here
				sources = {
					-- formatting,
					-- diagnostics,
					-- code_actions,
					code_actions.refactoring,

					formatting.eslint,
					formatting.prettier,
					formatting.autopep8,
					formatting.stylua,

					diagnostics.luacheck,
				},
				debug = false,
			})
		end,
	},
}
