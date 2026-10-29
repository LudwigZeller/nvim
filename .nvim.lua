vim.lsp.config("nixd", {
  settings = {
    nixd = {
      options = {
        nixvim = {
          expr = '(builtins.getFlake (builtins.toString ./.)).packages.${builtins.currentSystem}.default.options',
        },
      },
    },
  },
})
