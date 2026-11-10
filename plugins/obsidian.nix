{ pkgs, ... }: {
  plugins.render-markdown = {
    enable = true;
    settings = {
      # render_modes = true;
      # latex.enabled = false;
      completions = {
        lsp = {
          enabled = true;
        };
      };
    };

  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "render-latex.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "techwizrd";
        repo = "render-latex.nvim";
        rev = "v0.1.0-rc5";
        sha256 = "sha256-6MB36Kkrs1l93oKKoWVEkQjCa84DvXxopo3wKVfSuQE=";
      };
    })
  ];

  plugins.obsidian = {
    # enable = true;
  };
}
