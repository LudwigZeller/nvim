vim.lsp.config("nixd", {
  settings = {
    nixd = {
      options = {
        nixvim = {
          expr = '(builtins.getFlake (builtins.toString ./.)).nixvimConfigurations.${builtins.currentSystem}.nvim.options'
        },
      },
    },
  },
})
