{ ... }: {
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
  };
  keymaps = [
    { action = "<cmd>CodeSnap<cr>"; key = "<leader>uc"; mode = ["v"]; options = { desc = "Take Snapshot"; }; }
  ];
}
