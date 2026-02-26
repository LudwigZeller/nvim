{ lib, ... }:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = lib.nixvim.mkRaw ''
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
        width = lib.nixvim.mkRaw "function() return math.ceil(vim.o.columns * 0.75) end";
        height = lib.nixvim.mkRaw "function() return math.ceil(vim.o.lines * 0.75) end";
      };
    };
  };

  keymaps = [
    {
      key = "<esc>";
      action = "<cmd>Toggleterm<cr>";
      mode = [ "t" ];
    } # Close terminal on escape
    # General Terminals
    {
      mode = "n";
      key = "<leader>th";
      action = lib.nixvim.mkRaw "function() if _Toggleterm == nil then _Toggleterm = require('toggleterm.terminal').Terminal:new() end _Toggleterm:toggle(0, 'horizontal') end";
      options.desc = "Horizontal Terminal";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = lib.nixvim.mkRaw "function() if _Toggleterm == nil then _Toggleterm = require('toggleterm.terminal').Terminal:new() end _Toggleterm:toggle(0, 'vertical') end";
      options.desc = "Vertical Terminal";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = lib.nixvim.mkRaw "function() if _Toggleterm == nil then _Toggleterm = require('toggleterm.terminal').Terminal:new({ direction = 'float' }) end _Toggleterm:toggle(0, 'float') end";
      options.desc = "Float Terminal";
    }

    # System Monitor (htop/btop)
    {
      mode = "n";
      key = "<leader>ts";
      action = lib.nixvim.mkRaw ''
        function()
          local cmd = "htop"
          if vim.fn.executable("btop") == 1 then cmd = "btop" end
          if _Htop == nil then
            _Htop = require("toggleterm.terminal").Terminal:new({ cmd = cmd, hidden = true, direction = "float" })
          end
          _Htop:toggle()
        end
      '';
      options.desc = "HTop";
    }

    # Music (ncspot/spt)
    {
      mode = "n";
      key = "<leader>tm";
      action = lib.nixvim.mkRaw ''
        function()
          if _Music == nil then
            local cmd = "ncspot"
            if vim.fn.executable("spt") == 1 then cmd = "spt" end
            _Music = require("toggleterm.terminal").Terminal:new({ cmd = cmd, hidden = true, direction = "float" })
          end
          _Music:toggle()
        end
      '';
      options.desc = "Music";
    }

    # LazyGit
    {
      mode = "n";
      key = "<leader>gl";
      action = lib.nixvim.mkRaw ''
        function()
          if _Lazygit == nil then
            _Lazygit = require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
          end
          _Lazygit:toggle()
        end
      '';
      options.desc = "LazyGit";
    }
  ];
}
