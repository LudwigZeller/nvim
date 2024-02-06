return {
  --[[ Rust Tools ]]
  {
    "simrat39/rust-tools.nvim",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local codelldb_path = vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")
      require("rust-tools").setup({
        capabilities = capabilities,
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(
            vim.fn.expand(codelldb_path .. "adapter/codelldb"),
            vim.fn.expand(codelldb_path .. "lldb/lib/liblldb.so")
          )
        },
        tools = {
          executor = require("rust-tools.executors").toggleterm,
        },
      })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        group = vim.api.nvim_create_augroup("FileTypeKeybinds", { clear = false }),
        pattern = "*.rs",
        callback = function(args)
          vim.keymap.set("n", "<S-k>", "<cmd>RustHoverActions<cr>",
            { buffer = args.buf, remap = true, desc = "Rust Hover" })
          vim.keymap.set("n", "<leader>dd", "<cmd>RustDebuggables<cr>",
            { buffer = args.buf, remap = true, desc = "Rust Debug" })

          require("which-key").register()
        end
      })
    end
    --[[ Rust Keybinds ]]
  },


}
