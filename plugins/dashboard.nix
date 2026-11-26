{ lib, pkgs, ... }:
let
  # animation = "blackhole";
  mkButton =
    {
      text,
      shortcut,
      command,
    }:
    {
      type = "button";
      val = text;
      on_press = lib.nixvim.mkRaw ''function() vim.cmd("${command}") end'';
      opts = {
        keymap = [
          "n"
          shortcut
          "<CMD>${command}<CR>"
          { }
        ];
        position = "center";
        shortcut = shortcut;
        cursor = 0;
        width = 50;
        align_shortcut = "right";
        hl_shortcut = "Bold";
      };
    };
in
{
  plugins.snacks = {
    enable = true;
    settings.dashboard = {

      preset = {
        keys = [
          {
            icon = " ";
            key = "f";
            desc = "Find File";
            action = ":lua Snacks.dashboard.pick('files')";
          }
          {
            icon = " ";
            key = "n";
            desc = "New File";
            action = ":ene | startinsert";
          }
          {
            icon = " ";
            key = "g";
            desc = "Find Text";
            action = ":lua Snacks.dashboard.pick('live_grep')";
          }
          {
            icon = " ";
            key = "r";
            desc = "Recent Files";
            action = ":lua Snacks.dashboard.pick('oldfiles')";
          }
          {
            icon = " ";
            key = "c";
            desc = "Config";
            action = ":lua Snacks.dashboard.pick('files'; {cwd = vim.fn.stdpath('config')})";
          }
          {
            icon = " ";
            key = "s";
            desc = "Restore Session";
            section = "session";
          }
          {
            icon = " ";
            key = "q";
            desc = "Quit";
            action = ":qa";
          }
        ];
      };
      sections = [

        {
          section = "terminal";
          # cmd = "chafa ~/.config/wall.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1";
          cmd = "${lib.getExe pkgs.hello}";
          height = 17;
          padding = 1;
        }
        {
          pane = 2;
          __unkeyed-1 = {
            section = "keys";
            gap = 1;
            padding = 1;
          };
          __unkeyes-2 = {
            section = "startup";
          };
        }
      ];
    };
  };
}
