{ lib, ... }: {
  plugins.neotest = {
    enable = true;

    settings = {
      adapters = [
        { __raw = "require('rustaceanvim.neotest')"; }
      ];
    };

    lazyLoad.settings = {
      cmd = "Neotest";
      keys = [
        {
          __unkeyed-1 = "<leader>cts";
          __unkeyed-3 = "<CMD>Neotest summary toggle<CR>";
          desc = "Show test summery";
        }

        {
          __unkeyed-1 = "<leader>ctr";
          __unkeyed-3 = "<CMD>Neotest run<CR>";
          desc = "Run test";
        }

        {
          __unkeyed-1 = "<leader>ctr";
          __unkeyed-3 = "<CMD>Neotest run file<CR>";
          desc = "Run tests in file";
        }

        {
          __unkeyed-1 = "<leader>cto";
          __unkeyed-3 = "<CMD>Neotest output_panel toggle<CR>";
          desc = "Test output panel";
        }

        {
          __unkeyed-1 = "<leader>ctf";
          __unkeyed-3 = "<CMD>Neotest output_panel toggle<CR>";
          desc = "Floating test output";
        }
      ];
    };
  };

}
