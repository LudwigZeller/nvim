{ ... }:
{
  globals = {
    mapleader = " ";
    mapleaderlocal = " ";
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
  };

  # opt.completeopt = { "menuone", "noselect", "noinsert" }
  # opt.shortmess = vim.opt.shortmess + { c = true }
}
