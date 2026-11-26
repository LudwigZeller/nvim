{ lib, pkgs, ... }:
let
  mkRemoveBlackBackground =
    animation:
    pkgs.runCommand "transparent-${baseNameOf animation}.gif" { } ''
      ${lib.getExe pkgs.imagemagick} ${animation} \
        -coalesce \
        -fuzz 10% \
        -transparent black \
        -layers Optimize \
        -loop 0 \
        $out
    '';

  blackhole = mkRemoveBlackBackground ../data/blackhole.gif;
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
          cmd = "${lib.getExe pkgs.chafa} --fg-only --symbols ascii -f symbols --speed 0.30 --clear -s 60x24 ${blackhole}";
          height = 24;
          width = 60;
          ttl = 0;
          padding = 1;
        }
        {
          pane = 2;
          __unkeyed-1 = {
            section = "keys";
            gap = 1;
            padding = 1;
          };
          # __unkeyed-2 = {
          #   section = "startup";
          # };
        }
      ];
    };
  };
}
