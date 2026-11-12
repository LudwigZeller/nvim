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
        lua = [ "custom-stylua" ];
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
      formatters = {
        custom-stylua = {
          command = "stylua";
          args = [
            "--indent-type"
            "Spaces"
            "--indent-width"
            "2"
            "-"
          ];
        };

        injected = {
          # https://github.com/jmbuhr/nvim-config/blob/382b050e13eada7180ad048842386be37e820660/lua/plugins/editing.lua#L29-L81
          options = {
            # there are often non-existant errors in otter
            ignore_errors = true;
            # because some formatters care about the filename.
            lang_to_ext = {
              bash = "sh";
              c_sharp = "cs";
              elixir = "exs";
              javascript = "js";
              julia = "jl";
              latex = "tex";
              markdown = "md";
              python = "py";
              ruby = "rb";
              rust = "rs";
              teal = "tl";
              r = "r";
              typescript = "ts";
            };
            # Map of treesitter language to formatters to use
            # (defaults to the value from formatters_by_ft)
            lang_to_formatters = { };
          };
        };
      };
    };
  };
}
