{ lib, ... }: {
  plugins.neotest = {
    enable = true;
    adapters = [
      (lib.nixvim.mkRaw "require('rustaceanvim.neotest')")
    ];
    neotest.lazyLoad.settings = {
      cmd = "Neotest";
      keys = [
        {
          __unkeyed-1 = "<leader>ct";
          __unkeyed-3 = "<CMD>Neotest summary<CR>";
          desc = "Summary toggle";
        }
      ];
    };
  };

}
