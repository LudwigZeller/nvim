{ lib, ... }:
{
  lsp = {
    inlayHints.enable = true;
    servers = {
      nixd = {
        enable = true;
        config = {
          nixpkgs.expr = "import <nixpkgs> { }";
          formatting.command = [ "nixfmt" ];
        };
      };
    };
    keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
        mode = [ "n" ];
      }
      {
        key = "g<s-d>";
        lspBufAction = "references";
        mode = [ "n" ];
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
        mode = [ "n" ];
      }
      {
        key = "gi";
        lspBufAction = "implementation";
        mode = [ "n" ];
      }
      {
        key = "<s-k>";
        lspBufAction = "hover";
        mode = [ "n" ];
      }
      # { # TODO Code Action
      #   key = "<leader>ck";
      #   action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
      #   mode = [ "n" ];
      #   options = {
      #     desc = "Previous diagnostic";
      #   };
      # }
      {
        key = "<leader>ck";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        mode = [ "n" ];
        options = {
          desc = "Previous diagnostic";
        };
      }
      {
        key = "<leader>cj";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        mode = [ "n" ];
        options = {
          desc = "Next diagnostic";
        };
      }
      {
        key = "<leader>clx";
        action = "<CMD>LspStop<Enter>";
        mode = [ "n" ];
        options = {
          desc = "Stop LSP";
        };
      }
      {
        key = "<leader>cls";
        action = "<CMD>LspStart<Enter>";
        mode = [ "n" ];
        options = {
          desc = "Start LSP";
        };
      }
      {
        key = "<leader>clr";
        action = "<CMD>LspRestart<Enter>";
        mode = [ "n" ];
        options = {
          desc = "Restart LSP";
        };
      }
    ];
  };
}
