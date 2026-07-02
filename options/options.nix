{ ... }:
{
  globals = {
    mapleader = " ";
    mapleaderlocal = " ";

    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
  };

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  opts = {
    termguicolors = true;

    linespace = 2;
    breakindent = true;
    hlsearch = false;
    ignorecase = true;
    mouse = "a";
    number = true;
    smartcase = true;
    wrap = true;
    tabstop = 2;
    expandtab = true;
    shiftwidth = 2;
    relativenumber = true;
    timeoutlen = 1000;
    autoread = true;

    shell = "fish";
    mousemodel = "extend";

    fillchars = "eob: ";

    winminwidth = 10;
    winblend = 30;
    sessionoptions = [
      "blank" # Keep empty windows
      "buffers" # Remember all open files/buffers
      "curdir" # Crucial: Remember the current working directory (the project root)
      "folds" # Remember folded code blocks
      "help" # Remember the help window
      "tabpages" # Keep all your open tabs
      "winsize" # Restore window sizes
      "winpos" # Restore window positions
      "localoptions" # Crucial for Projections: Remember local buffer/window options
    ];
  };

  # opt.completeopt = { "menuone", "noselect", "noinsert" }
  # opt.shortmess = vim.opt.shortmess + { c = true }
}
