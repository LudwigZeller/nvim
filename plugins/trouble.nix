{ ... }:
{
  plugins.trouble = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "Trouble"
      ];
      keys = [
        {
          __unkeyed-1 = "<leader>cx";
          __unkeyed-3 = "<cmd>Trouble<cr>";
          desc = "Toggle Trouble";
        }
        {
          __unkeyed-1 = "<leader>cd";
          __unkeyed-3 = "<cmd>Trouble diagnostics<cr>";
          desc = "Diagnostic";
        }
        {
          __unkeyed-1 = "<leader>cq";
          __unkeyed-3 = "<cmd>Trouble quickfix<cr>";
          desc = "Quickfix";
        }
        {
          __unkeyed-1 = "<leader>cl";
          __unkeyed-3 = "<cmd>Trouble loclist<cr>";
          desc = "Location List";
        }
      ];
    };
  };
}
