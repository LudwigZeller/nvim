{ ... }:
{
  plugins.telescope = {
    enable = true;
    lazyLoad.settings = {
      cmd = "Telescope";
      keys = [
        { __unkeyed-1 = "<leader>ff"; __unkeyed-3 = "<CMD>Telescope fd<CR>"; desc = "Find files"; }
        { __unkeyed-1 = "<leader>fs"; __unkeyed-3 = "<CMD>Telescope live_grep<CR>"; desc = "Search file contents"; }
      ];
    };
  };
  keymaps = [

  ];
}
