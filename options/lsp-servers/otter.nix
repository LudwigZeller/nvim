{
  plugins.treesitter.nixvimInjections = true;
  plugins = {
    otter = {
      enable = true;
      autoActivate = true;
      lazyLoad.settings = {
        ft = "nix";
      };
    };
  };
}
