{ helpers, ... }: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      # Use mkRaw so NixVim treats this as a Lua function block
      size = helpers.mkRaw ''
        function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
          end
          return 20
        end
      '';
      
      shade_terminals = false;
      autochdir = true;
      winbar.enabled = false;

      float_opts = {
        border = "curved";
        winblend = 3;
        # Inline mkRaw for shorter logic
        width = helpers.mkRaw "function() return math.ceil(vim.o.columns * 0.75) end";
        height = helpers.mkRaw "function() return math.ceil(vim.o.lines * 0.75) end";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ts";
      action = helpers.mkRaw ''
        function()
          local cmd = "htop"
          if vim.fn.executable("btop") == 1 then cmd = "btop" end
          if _Htop == nil then
            _Htop = require("toggleterm.terminal").Terminal:new({ 
              cmd = cmd, 
              hidden = true, 
              direction = "float" 
            })
          end
          _Htop:toggle()
        end
      '';
      options = {
        desc = "HTop";
        silent = true;
      };
    }
    # ... repeat for other keys using helpers.mkRaw for the action
  ];
}
