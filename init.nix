{ pkgs, ... }:
{
  # colorschemes.catppuccin.enable = true;

  plugins.lz-n.enable = true; # Enable Lazy-Loading

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
