{pkgs,...}:
{
  extraPackages = with pkgs; [
    rustfmt
    nixfmt
    prettierd
    prettier
    isort
    black
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
        rust = [ "rustfmt" ];
        nix = [ "nixfmt" ];
        javascript = [ "prettierd" "prettier" ];
        python = [ "isort" "black" ];
        "_" = [ "trim_whitespace" ];
      };
    };
  };
}
