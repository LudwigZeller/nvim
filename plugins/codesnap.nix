{ ... }:
{
  plugins.codesnap = {
    enable = true;
    settings = {
      snapshot_config = {
        theme = "candy";
        window = {
          mac_window_bar = false;
        };
        watermark = {
          content = "";
        };
        background = "#00000000";
      };
    };
    lazyLoad.settings = {
      cmd = "CodeSnap";
      keys = [
        {
          __unkeyed-2 = "<cmd>CodeSnap<cr>";
          __unkeyed-1 = "<leader>uc";
          mode = [ "v" ];
          options = {
            desc = "Take Snapshot";
          };
        }
      ];
    };

  };
  keymaps = [
  ];
}
