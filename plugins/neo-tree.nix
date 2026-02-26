{ pkgs, ... }:
{
  plugins.image.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    nvim-lsp-file-operations
    nvim-window-picker
  ];

  extraConfigLua = ''
    require("lsp-file-operations").setup({
      display_operations = true,
    })
    require("window-picker").setup({})
  '';

  plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        hijackNetrwBehavior = "open_current"; # Options: "open_current", "open_default", "disabled"
        useLibuvFileWatcher = true;           # Better performance for large projects
      };
      close_if_last_window = true;
      popup_border_style = "rounded";
      enable_git_status = true;
      enable_diagnostics = true;
      window = {
        position = "float";
        width = 80;
      };
      file_size = {
        enabled = true;
        required_width = 64;
      };
      last_modified = {
        enabled = true;
        required_width = 88;
      };
      created = {
        enabled = true;
        required_width = 110;
      };
      type = {
        enabled = true;
        required_width = 122;
      };
    };
  };
  keymaps = [
    {
      action = "<cmd>Neotree toggle<cr>";
      key = "<leader>ft";
      mode = [ "n" ];
      options = {
        desc = "File Tree";
      };
    }
  ];
}
