{
  plugins.lazydev.enable = true;
  plugins.lazydev.lazyLoad.settings.ft = [
    "nix"
    "lua"
  ];
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
