{ lib, ... }: {
  plugins.mini-icons.enable = true; # Icon support
  plugins.oil-git-status.enable = true;
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      watch_for_changes = true;
      columns = [
        "icon"
        "permissions"
        "size"
        # "mtime"
      ];
      lsp_file_methods = {
        enabled = true;
        timeout_ms = 1000;
        autosave_changes = "unmodified"; # Set to "unmodified" to only save unmodified buffers
      };
      float = {
        padding = 0;
        max_width = 0;
        max_height = 0;
        border = "rounded";
        win_options = {
          # winblend = 0;
        };
        # -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = null;
        # -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto";
        override = lib.nixvim.mkRaw "function(conf) 
          vim.print(conf)
          conf.col = math.floor(vim.o.columns * 0.25)
          conf.width = math.ceil(vim.o.columns * 0.50)

          conf.row = math.floor(vim.o.lines * 0.125)
          conf.height = math.ceil(vim.o.lines * 0.75)
        end";
      };
    };
  };

  keymaps = [
    {
      action = "<cmd>lua require(\"oil\").toggle_float()<cr>";
      key = "<leader>ft";
      mode = [ "n" ];
      options = {
        desc = "File Buffer";
      };
    }
  ];
}
