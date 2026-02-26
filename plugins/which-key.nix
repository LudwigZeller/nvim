{ ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      delay = 200;
      expand = 1;
      notify = false;
      preset = "modern";
      position = "bottom";
      win = {
        border = "rounded";
        padding = {
          __unkeyed-1 = 1;
          __unkeyed-2 = 2;
        };
      };
      layout = {
        align = "center";
      };
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
          __unkeyed-1 = "<leader>p";
          group = "Tabs";
          icon = "󰓩 ";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Terminal";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Session";
          icon = " ";
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
        {
          __unkeyed-1 = "<leader>cl";
          group = "Lsp";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "git";
          icon = " ";
        }
      ];
    };
  };
}
