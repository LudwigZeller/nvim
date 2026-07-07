{ lib, ... }: {
  plugins.flash = {
    enable = true;
  };
  keymaps = [
    {
      action = lib.nixvim.mkRaw ''function() require("flash").jump() end'';
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Flash";
      };
    }

    {
      action = lib.nixvim.mkRaw ''function() require("flash").treesitter() end'';
      key = "<S-s>";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Flash Treesitter";
      };
    }

    {
      action = lib.nixvim.mkRaw ''function() require("flash").remote() end'';
      key = "r";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Remote Flash";
      };
    }

    {
      action = lib.nixvim.mkRaw ''function() require("flash").treesitter_search() end'';
      key = "<S-r>";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Treesitter Search";
      };
    }

    {
      action = lib.nixvim.mkRaw ''function() require("flash").toggle() end'';
      key = "<C-s>";
      mode = [
        "n"
        "x"
        "o"
      ];
      options = {
        desc = "Toggle Flash Search";
      };
    }
    # { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    # { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    # { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    # { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    # { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  ];
}
