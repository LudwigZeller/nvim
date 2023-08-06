return {
	{
		"williamboman/mason.nvim",
		dependencies = {},
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
		end,
	},

	--[[ Lsp Config ]]
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "simrat39/rust-tools.nvim" },
		config = function()
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

	--[[ Dap Config ]]
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"simrat39/rust-tools.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				handlers = {
					function(config) -- Default
						require("mason-nvim-dap").default_setup(config)
					end,
					-- ["codelldb"] = function(config)
					-- vim.print(config)
					-- require("rust-tools").setup({
					-- 	dap = {
					-- 		type = "executable",
					-- 		command = config.adapters.command,
					-- 		name = config.name,
					-- 	}
					-- })
					-- end,
				},
			})
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	--[[ Null Ls ]]
	{
		enabled = false,
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
