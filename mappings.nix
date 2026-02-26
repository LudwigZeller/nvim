{ ... }:
{
  keymaps = [
    {
      action = "<esc>";
      key = "jk";
      mode = [
        "i"
        "v"
      ];
      options = {
        nowait = true;
        desc = "Switch to normal mode";
      };
    }
    {
      action = "<cmd>noh<cr><esc>";
      key = "<esc>";
      mode = [
        "i"
        "n"
      ];
      options = {
        desc = "Clear search and escape";
      };
    }

    # Better Up/Down
    {
      action = "v:count == 0 ? 'gj' : 'j'";
      key = "j";
      mode = [
        "n"
        "x"
      ];
      options = {
        nowait = true;
        expr = true;
        silent = true;
      };
    }
    {
      action = "v:count == 0 ? 'gk' : 'k'";
      key = "k";
      mode = [
        "n"
        "x"
      ];
      options = {
        nowait = true;
        expr = true;
        silent = true;
      };
    }
    {
      action = "10j";
      key = "<C-j>";
      mode = [
        "n"
        "x"
      ];
      options = {
        nowait = true;
        silent = true;
      };
    }
    {
      action = "10k";
      key = "<C-k>";
      mode = [
        "n"
        "x"
      ];
      options = {
        nowait = true;
        silent = true;
      };
    }

    # Window Navigation
    {
      action = "<C-w>h";
      key = "<C-h>";
      mode = [
        "n"
        "t"
      ];
      options = {
        desc = "Go to left window";
        remap = true;
      };
    }
    {
      action = "<C-w>j";
      key = "<C-j>";
      mode = [
        "n"
        "t"
      ];
      options = {
        desc = "Go to lower window";
        remap = true;
      };
    }
    {
      action = "<C-w>k";
      key = "<C-k>";
      mode = [
        "n"
        "t"
      ];
      options = {
        desc = "Go to upper window";
        remap = true;
      };
    }
    {
      action = "<C-w>l";
      key = "<C-l>";
      mode = [
        "n"
        "t"
      ];
      options = {
        desc = "Go to right window";
        remap = true;
      };
    }

    # Window Resizing
    {
      action = "<cmd>resize +2<cr>";
      key = "<C-Up>";
      mode = [ "n" ];
      options = {
        desc = "Increase window height";
      };
    }
    {
      action = "<cmd>resize -2<cr>";
      key = "<C-Down>";
      mode = [ "n" ];
      options = {
        desc = "Decrease window height";
      };
    }
    {
      action = "<cmd>vertical resize -2<cr>";
      key = "<C-Left>";
      mode = [ "n" ];
      options = {
        desc = "Decrease window width";
      };
    }
    {
      action = "<cmd>vertical resize +2<cr>";
      key = "<C-Right>";
      mode = [ "n" ];
      options = {
        desc = "Increase window width";
      };
    }

    # Move Lines (Normal Mode)
    {
      action = "<cmd>m .+1<cr>==";
      key = "<A-j>";
      mode = [ "n" ];
      options = {
        desc = "Move line down";
      };
    }
    {
      action = "<cmd>m .-2<cr>==";
      key = "<A-k>";
      mode = [ "n" ];
      options = {
        desc = "Move line up";
      };
    }

    # Move Lines (Insert Mode)
    {
      action = "<esc><cmd>m .+1<cr>==gi";
      key = "<A-j>";
      mode = [ "i" ];
      options = {
        desc = "Move line down";
      };
    }
    {
      action = "<esc><cmd>m .-2<cr>==gi";
      key = "<A-k>";
      mode = [ "i" ];
      options = {
        desc = "Move line up";
      };
    }

    # Move Lines (Visual Mode)
    {
      action = "<cmd>m '>+1<cr>gv=gv";
      key = "<A-j>";
      mode = [ "v" ];
      options = {
        desc = "Move lines down";
      };
    }
    {
      action = "<cmd>m '<-2<cr>gv=gv";
      key = "<A-k>";
      mode = [ "v" ];
      options = {
        desc = "Move lines up";
      };
    }

    # Add undo break-points
    {
      action = ",<c-g>u";
      key = ",";
      mode = [ "i" ];
      options = {
        nowait = true;
        silent = true;
      };
    }
    {
      action = ".<c-g>u";
      key = ".";
      mode = [ "i" ];
      options = {
        nowait = true;
        silent = true;
      };
    }
    {
      action = ";<c-g>u";
      key = ";";
      mode = [ "i" ];
      options = {
        nowait = true;
        silent = true;
      };
    }

    # Better indenting
    {
      action = "<gv";
      key = "<";
      mode = [ "v" ];
      options = {
        nowait = true;
        silent = true;
      };
    }
    {
      action = ">gv";
      key = ">";
      mode = [ "v" ];
      options = {
        nowait = true;
        silent = true;
      };
    }

    # Tab Management
    {
      action = "<cmd>tabprevious<cr>";
      key = "<leader>th";
      mode = [ "n" ];
      options = {
        desc = "Previous tab";
      };
    }
    {
      action = "<cmd>tabnext<cr>";
      key = "<leader>tl";
      mode = [ "n" ];
      options = {
        desc = "Next tab";
      };
    }
    {
      action = "<cmd>tabnew<cr>";
      key = "<leader>tn";
      mode = [ "n" ];
      options = {
        desc = "New tab";
      };
    }
    {
      action = "<cmd>tabclose<cr>";
      key = "<leader>tc";
      mode = [ "n" ];
      options = {
        desc = "Close tab";
      };
    }
  ];
}
