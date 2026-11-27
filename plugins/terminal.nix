{ pkgs, lib, ... }:
{
  plugins.snacks = {
    enable = true;
    settings.terminal = {
    };
    settings.styles = {
      terminal_float = {
        style = "terminal";
        position = "float";
        border = "rounded";
        width = 0.75;
        height = 0.75;
      };
      lazygit = {
        position = "float";
        border = "rounded";
        width = 0.75;
        height = 0.75;
      };
      terminal = {
        bo = {
          filetype = "snacks_terminal";
        };
        wo = {
          winblend = 0;
        };
        stack = true; # when enabled; multiple split windows with the same position will be stacked together (useful for terminals)
        keys = {
          q = "hide";
          "<C-_>" = "hide";

          term_normal = {
            __unkeyed-1 = "<esc>";
            __unkeyed-2 = lib.nixvim.mkRaw ''
              function(self)
                      self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                      if self.esc_timer:is_active() then
                        self.esc_timer:stop()
                        vim.cmd("stopinsert")
                      else
                        self.esc_timer:start(200, 0, function() end)
                        return "<esc>"
                      end
                    end'';
            mode = "t";
            expr = true;
            desc = "Double escape to normal mode";
          };

          term_normal_alternative = {
            __unkeyed-1 = "jk";
            # __unkeyed-2 = lib.nixvim.mkRaw ''function() vim.cmd("stopinsert") end'';
            __unkeyed-2 = "<C-\\><C-n>";
            mode = "t";
            expr = true;
            desc = "Switch to normal mode";
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>tf";
      action = '':lua Snacks.terminal.toggle(nil, { count = 1, win = { style = "terminal_float" } })<CR>'';
      options.desc = "Floating Terminal";
    }
    {
      mode = "n";
      key = "<leader>tb";
      action = '':lua Snacks.terminal.toggle(nil, { count = 2, win = { position = "bottom" } })<CR>'';
      options.desc = "Bottom Terminal";
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = '':lua Snacks.terminal.toggle(nil, { count = 3, win = { position = "right" } })<CR>'';
      options.desc = "Right Terminal";
    }

    {
      mode = "n";
      key = "<leader>ts";
      action = '':lua Snacks.terminal.toggle("btop", { win = { style = "terminal_float" } })<CR>'';
      options.desc = "System Monitor";
    }

    {
      mode = "n";
      key = "<leader>tm";
      action = lib.nixvim.mkRaw ''function() Snacks.terminal.toggle("ncspot", { win = { style = "terminal_float", keys = { term_normal_alternative = false,  q_override = { "q", function(term) term:hide() end, mode = "t" } } } }) end'';
      options.desc = "Music";
    }

    {
      mode = "n";
      key = "<leader>gl";
      action = lib.nixvim.mkRaw ''function() Snacks.lazygit.open({ win = { style = "terminal_float", keys = { term_normal_alternative = false,  q_override = { "q", function(term) term:hide() end, mode = "t" } } } }) end'';
      options.desc = "LazyGit";
    }

    # {
    #   mode = "n";
    #   key = "<leader>gh";
    #   action = ":lua Snacks.gh.open()<CR>";
    #   options.desc = "LazyGit";
    # }
  ];
}
