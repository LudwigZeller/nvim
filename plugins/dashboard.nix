{ pkgs, ... }:
let
  milli-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "milli.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Amansingh-afk";
      repo = "milli.nvim";
      rev = "main";
      hash = "sha256-EtrBQH8vzBMUF/Wp7t46sb39RQSPyGZWT+HucPoRxVg=";
    };
  };
in
{
  # extraPlugins = [ milli-nvim ];
  # extraConfigLua = ''
  #   require("milli").dashboard({ splash = "blackhole", loop = true })
  # '';

  # TODO Switch to alpha and import milli-nvim

  plugins.dashboard = {
    enable = true;
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
