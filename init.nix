{ pkgs, ... }:
{
  # colorschemes.catppuccin.enable = true;

  plugins.lz-n.enable = true; # Enable Lazy-Loading

  luaLoader.enable = true;
  performance.byteCompileLua = {
    enable = true;
    configs = true;
    plugins = true;
  };

  extraPackages = with pkgs; [
    ripgrep
    fd
    lazygit
    btop-rocm
  ];

  imports = [
    ./options
    ./plugins
    ./mappings.nix
  ];
}
