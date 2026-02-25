{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
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
}
