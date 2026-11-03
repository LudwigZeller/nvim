{
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
    };
    keymaps = [
      {
        action = "<cmd>Oil<cr>";
        key = "<leader>ft";
        mode = [ "n" ];
        options = {
          desc = "File Tree";
        };
      }
    ];
  };
}
