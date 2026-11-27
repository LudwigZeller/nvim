{ lib, pkgs, ... }:
let
  mkRemoveBlackBackground =
    animation:
    pkgs.runCommand "transparent-${lib.removeSuffix ".gif" (baseNameOf animation)}.webp" { } ''
      ${lib.getExe pkgs.imagemagick} ${animation} \
        -coalesce \
        -fuzz 10% \
        -transparent black \
        -loop 0 \
        -layers Optimize \
        $out
    '';

  blackhole = mkRemoveBlackBackground ../data/blackhole.gif;
  charged-blackhole = mkRemoveBlackBackground ../data/charged-blackhole.gif;
in
{
  plugins.snacks = {
    enable = true;
    settings.dashboard = {
      width = 80;
      pane_gap = 4;

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
          cmd = "${lib.getExe pkgs.chafa} --fg-only --symbols ascii -f symbols --speed 0.30 --clear -s 80x25 ${blackhole}";
          height = 25;
          width = 80;
          ttl = 0;
          padding = 1;
        }
        {
          pane = 2;
          section = "keys";
          gap = 1;
          padding = 1;
        }
        (lib.nixvim.mkRaw ''
          function(opts)
            opts = opts or {}

            local start_plugins = vim.fn.globpath(vim.o.packpath, "pack/*/start/*", 0, 1)
            local opt_plugins = vim.fn.globpath(vim.o.packpath, "pack/*/opt/*", 0, 1)

            local rtp = "," .. vim.o.runtimepath .. ","
            local loaded = #start_plugins
            for _, path in ipairs(opt_plugins) do
              if rtp:find("," .. path .. ",", 1, true) then
                loaded = loaded + 1
              end
            end

            local total = #start_plugins + #opt_plugins
            return {
              align = "center",
              padding =  1,
              pane =  2,
              text = {
                { "❄️ NixVim loaded ", hl = "SnacksDashboardFooter" },
                { loaded .. "/" .. total, hl = "SnacksDashboardSpecial" },
                { " plugins in ", hl = "SnacksDashboardFooter" },
                { (_G.startup_ms or "NIL") .. "ms", hl = "SnacksDashboardSpecial" },
                { " ⚡", hl = "SnacksDashboardFooter" },
              },
            }
          end
        '')
      ];
    };
  };
  extraConfigLuaPre = ''
    local nvim_start_time = vim.uv.hrtime()

    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = function()
        if not _G.startup_ms and nvim_start_time then
          local elapsed = ((vim.uv or vim.loop).hrtime() - nvim_start_time) / 1e6
          _G.startup_ms = string.format("%.2f", elapsed)
        end
      end,
    })
  '';
}
