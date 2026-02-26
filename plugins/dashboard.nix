{ ... }:
{
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
        weekheader.enable = true;
        shortcut = [
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
        # project = {
        #   enable = true;
        #   # action = "Telescope find_files cwd=";
        # };
        mru = {
          enable = true;
          cwd_only = true;
        };
        footer = [
          ""
          "❤️ K.I.S.S - Keep it simple, stupid ❤️"
        ];
      };
    };
  };
}
