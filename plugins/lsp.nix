{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    rust-analyzer
    cargo # Usually needed for RA to work correctly
    rustc
  ];
  plugins.rustaceanvim = {
    enable = true;
    settings = {
      tools = {
        executor = "toggleterm";
        create_graph = {
          backend = "kitty";
        };
        enable_clippy = true;
      };
    };
  };
}
