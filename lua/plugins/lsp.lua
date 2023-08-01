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
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
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
					code_actions.refactoring,

					formatting.eslint,
					formatting.autopep8,
					formatting.stylua,

					diagnostics.luacheck,
				},
				debug = false,
			})
		end,
	},
}
