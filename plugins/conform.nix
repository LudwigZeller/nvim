{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    nixfmt
    stylua
  ];
  plugins.conform-nvim = {
    enable = true;
    settings = {
      autoInstall = {
        enable = true;
        enableWarnings = true;
      };
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };
      formatters_by_ft = {
        nix = [
          "nixfmt"
          "injected"
        ];
        devenv = [
          "nixfmt"
          "injected"
        ];
        lua = [ "stylua" ];
        rust = [ "rustfmt" ];
        javascript = [
          "prettierd"
          "prettier"
        ];
        python = [
          "isort"
          "black"
        ];
        "_" = [ "trim_whitespace" ];
      };
    };
  };
}
