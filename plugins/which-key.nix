{ ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      delay = 200;
      expand = 1;
      notify = false;
      preset = false;
      replace = {
        desc = [
          [
            "<space>"
            "SPACE"
          ]
          [
            "<leader>"
            "SPACE"
          ]
          [
            "<[cC][rR]>"
            "RETURN"
          ]
          [
            "<[tT][aA][bB]>"
            "TAB"
          ]
          [
            "<[bB][sS]>"
            "BACKSPACE"
          ]
        ];
      };
      spec = [
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffers";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Tabs";
          icon = "󰓩 ";
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "Visuals";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "Files";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
          icon = " ";
        }
      ];
      win = {
        # border = "rounded";
        # border = "shadow"; # none; single; double; shadow
        # position = "bottom"; # bottom; top
        # margin = { __unkeyed-1 = 2;__unkeyed-2 = 10;__unkeyed-3 = 2;__unkeyed-4 = 10; }; # extra window margin [top; right; bottom; left].
        # padding = { __unkeyed-1 = 1; __unkeyed-2 =2;__unkeyed-3 = 1;__unkeyed-4 = 2; };  # extra window padding [top; right; bottom; left]
        # zindex = 1000; # positive value to position WhichKey above other floating windows.
      };
    };
  };
}
