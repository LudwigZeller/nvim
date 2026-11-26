{
  plugins.lazydev.enable = true;
  lsp.servers.lua_ls = {

    enable = true;
    config = {
      diagnostics = {
        disable = [
          # "missing-name"
          # "missing-fields"
        ];
      };
    };
  };
}
