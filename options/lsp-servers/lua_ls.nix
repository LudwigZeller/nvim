{ lib, ... }:
{
  plugins.treesitter.nixvimInjections = true;
  plugins = {
    lazydev.enable = true;
    otter = {
      enable = true;
      autoActivate = true;
    };
  };
  lsp.servers.lua_ls = {
    enable = true;
    settings = {

    };
  };
}
