return {
  {
    event = "VeryLazy",
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
    event = "VeryLazy",
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "simrat39/rust-tools.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
          end,
          ["lua_ls"] = function()
            -- TODO: Enforce Range Formatting
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                format = { enable = false },
              },
            })
          end,
          ["rust_analyzer"] = function()

          end,
        }
      })
    end,
  },

  --[[ Dap Config ]]
  {
    event = "VeryLazy",
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        handlers = {
          function(config) -- Default
            require("mason-nvim-dap").default_setup(config)
          end,
          ["codelldb"] = function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
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

      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DapBreakpoint", text = "●" })
      sign({ name = "DapLogPoint", text = "◆" })
      sign({ name = "DapBreakpointCondition", text = "●" })
      sign({ name = "DapBreakpointRejected", text = "󰚽" })

      vim.keymap.set("n", "<leader>dd", dap.continue, { desc = "Debug" }) -- Used for overriding
      vim.keymap.set("n", "<leader>dd", dap.terminate, { desc = "Quit" })
      vim.keymap.set("n", "<leader>do", dap.run_last, { desc = "Rerun last debug" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>d<S-s>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>d<C-s>", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
      vim.keymap.set('n', '<Leader>d<S-b>',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = "Messagepoint" }
      )
      vim.keymap.set("n", "<leader>dm", dap.run_to_cursor, { desc = "Move to cursor" })
      vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate" })
      vim.keymap.set("n", "<leader>dw", dapui.elements.watches.add, { desc = "Add watch" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle ui" })
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
