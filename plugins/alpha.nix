{ lib, pkgs, ... }:
let
  animation = "blackhole";
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
  extraFiles."lua/data/blackhole.json".source = ../data/blackhole.json;

  plugins.alpha = {
    enable = true;
    settings = {

      layout = [
        {
          type = "group";
          val = lib.nixvim.mkRaw ''
            (function()
              local json_path = vim.api.nvim_get_runtime_file("lua/data/${animation}.json", false)[1]

              if not json_path then
                  error("Could not find blackhole.json in runtime path!")
              end
              
              local f = io.open(json_path, "r")
              local json_content = f:read("*a")
              f:close()

              local AnimFrames = vim.json.decode(json_content)

              -- 2. Pre-cache Neovim highlight groups
              local hl_cache = {}
              local function get_hl_group(hex)
                local name = "AlphaAnim_" .. hex:gsub("#", "")
                if not hl_cache[hex] then
                  vim.api.nvim_set_hl(0, name, { fg = hex, default = true })
                  hl_cache[hex] = name
                end
                return name
              end

              for _, frame in ipairs(AnimFrames) do
                frame.alpha_hl = {}
                for _, line_colors in ipairs(frame.colors) do
                  local line_hl = {}
                  for _, color_block in ipairs(line_colors) do
                    table.insert(line_hl, { get_hl_group(color_block[1]), color_block[2], color_block[3] }) 
                  end
                  if #line_hl == 0 then
                    table.insert(line_hl, { "Normal", 0, 0 })
                  end
                  table.insert(frame.alpha_hl, line_hl)
                end
              end


              local current_frame = 1
              local timer = vim.uv.new_timer()
              local alpha_group = vim.api.nvim_create_augroup("AlphaAnimation", { clear = true })
              vim.api.nvim_create_autocmd("User", {
                group = alpha_group,
                pattern = "AlphaReady",
                callback = function() timer:start(0, 250, vim.schedule_wrap(function() 
                  current_frame = current_frame + 1
                  if current_frame > #AnimFrames then current_frame = 1 end
                  
                  pcall(function()
                    require("alpha").redraw() 
                  end)
                end)) end,
              })
              vim.api.nvim_create_autocmd("User", {
                group = alpha_group,
                pattern = "AlphaClosed",
                callback = function() timer:stop() end,
              })


              return function()
                local frame = AnimFrames[current_frame]
                return {
                  {
                    type = "text",
                    val = frame.text,
                    opts = {
                      position = "center",
                      hl = frame.alpha_hl,
                    }
                  }
                }
              end
            end)()
          '';
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            (mkButton {
              text = " Projects";
              shortcut = "p";
              command = "Telescope projections";
            })

            (mkButton {
              text = " Files";
              shortcut = "f";
              command = "Telescope fd";
            })

            (mkButton {
              text = " Search";
              shortcut = "s";
              command = "Telescope live_grep";
            })
          ];

          opts = {
            spacing = 1;
            position = "v_center";
          };
        }
        {
          type = "padding";
          val = 5;
        }
        {
          type = "text";
          val = "❤️ K.I.S.S - Keep it simple, stupid ❤️";
          opts.position = "center";
        }
      ];
    };
  };

  plugins.dashboard = {
    enable = false;
    settings = {
      hide = {
        statusline = true;
        winbar = true;
        tabline = true;
      };
      change_to_vcs_root = true;
      config = {
        header = [
          "                     `. ___                                  "
          "                    __,' __`.                _..----....____ "
          "        __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'"
          "  _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'    "
          ",'________________                          \\`-._`-','       "
          " `._              ```````````------...___   '-.._'-:         "
          "    ```--.._      ,.                     ````--...__\\-.      "
          "            `.--. `-`                       ____    |  |`    "
          "              `. `.                       ,'`````.  ;  ;`    "
          "                `._`.        __________   `.      \\'__/`     "
          "                   `-:._____/______/___/____`.     \\  `      "
          "                               |       `._    `.    \\        "
          "                               `._________`-.   `.   `.___   "
          "                                             SSt  `------'`  "
          ""
        ];
        shortcut = [
          {
            desc = "Open Projects ";
            key = "p";
            action = "Telescope projections";
          }
          {
            desc = "Find Files ";
            key = "f";
            action = "Telescope fd";
          }
          {
            desc = "Search Files ";
            key = "s";
            action = "Telescope live_grep";
          }
          # {
          #   desc = "Last Session";
          #   key = "s";
          #   action = "<leader>sr";
          # }
          # {
          #   desc = "List Sessions";
          #   key = "s";
          #   action = "<leader>sl";
          # }
        ];
        packages.enable = false;
        project = {
          enable = true;
        };
        mru = {
          enable = true;
          cwd_only = false;
        };
        footer = [
          ""
          "❤️ K.I.S.S - Keep it simple, stupid ❤️"
        ];
      };
    };
  };
}
