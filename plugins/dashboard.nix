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
            icon = "󰙅 ";
            key = "t";
            desc = "File Tree";
            action = ":Neotree";
          }
          {
            icon = " ";
            key = "f";
            desc = "Find File";
            action = ":Telescope find_files";
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
            action = ":Telescope live_grep";
          }
          {
            icon = " ";
            key = "r";
            desc = "Recent Files";
            action = ":Telescope oldfiles";
          }
          {
            icon = " ";
            key = "s";
            desc = "Restore Session";
            action = lib.nixvim.mkRaw ''
              function()
                require("lz.n").trigger_load("projections")
                require("projections.session").restore(vim.uv.cwd())
              end
            '';
            enabled = lib.nixvim.mkRaw ''
              function()
                require("lz.n").trigger_load("projections")
                return require("projections.session").info(vim.uv.cwd()) ~= nil
              end'';
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
          # pane = 2;
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
              -- pane =  2,
              text = {
                { "❄️ NixVim loaded ", hl = "SnacksDashboardFooter" },
                { loaded .. "/" .. total, hl = "SnacksDashboardSpecial" },
                { " plugins in ", hl = "SnacksDashboardFooter" },
                { (_G.startup_ms or "󰥔 ") .. "ms", hl = "SnacksDashboardSpecial" },
                { " ⚡", hl = "SnacksDashboardFooter" },
              },
            }
          end
        '')
      ];
    };
  };

  # WITH SOME AI GENERATED HELP ON THE FFI
  extraConfigLuaPost = ''
    local ffi = require("ffi")
    ffi.cdef([[
      typedef int clockid_t;
      struct timespec { long tv_sec; long tv_nsec; };
      int clock_gettime(clockid_t clk_id, struct timespec *tp);
    ]])

    local CLOCK_PROCESS_CPUTIME_ID = jit.os == "OSX" and 12 or 2
    local ts = ffi.new("struct timespec[1]")

    local function process_cputime_ms()
      if ffi.C.clock_gettime(CLOCK_PROCESS_CPUTIME_ID, ts) == 0 then
        return tonumber(ts[0].tv_sec) * 1e3 + tonumber(ts[0].tv_nsec) / 1e6
      end
      return nil
    end

    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = function()
        if not _G.startup_ms then
          local ms = process_cputime_ms()
          if ms then
            _G.startup_ms = string.format("%.0f", ms)
            Snacks.dashboard.update()
          end
        end
      end,
    })
  '';
}
