{ pkgs, lib, ... }:
{
  lsp = {
    inlayHints.enable = true;
    codelens.enable = true;
    keymaps = [
      {
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        mode = "n";
      }
      {
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        mode = "n";
      } # Fixed g<s-d>
      {
        key = "gt";
        action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
        mode = "n";
      }
      {
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        mode = "n";
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        mode = "n";
      } # Fixed <s-k>
      {
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        mode = "n";
      }
      {
        key = "<leader>ck";
        action = "<cmd>lua vim.diagnostic.jump({ count=-1, float=true })<CR>";
        mode = "n";
        options.desc = "Previous diagnostic";
      }
      {
        key = "<leader>cj";
        action = "<cmd>lua vim.diagnostic.jump({ count=1, float=true })<CR>";
        mode = "n";
        options.desc = "Next diagnostic";
      }
    ];
  };

  extraPlugins = [
    pkgs.vimPlugins.direnv-nvim
  ];

  extraConfigLua = ''
    require("direnv").setup({
      bin = "direnv",

      autoload_direnv = true,

      statusline = {
        enabled = true,
        icon = "",
      },

      notifications = {
        level = vim.log.levels.INFO,
        silent_autoload = true,
      },
      silent = false, 
    })
  '';

  autoCmd = [
    {
      event = [ "User" ];
      pattern = [ "DirenvLoaded" ];
      callback = lib.nixvim.mkRaw ''
        function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local ft = vim.bo[buf].filetype
              if ft and ft ~= "" then
                vim.api.nvim_exec_autocmds("FileType", { buffer = buf, modeline = false })
              end
            end
          end
        end
      '';

    }
  ];

  #####################################
  ###          LSP Servers          ###
  #####################################
  opts.exrc = true; # Enable support for per project nixd config - move if not only used for nixd anymore
  lsp.servers = {
    nixd = {
      enable = true;
      config = {
        settings.nixd = {
          nixpkgs.expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }";
          formatting.command = [ "nixfmt" ];
          options = {
            "flake-parts" = {
              expr = ''
                let flake = builtins.getFlake (builtins.toString ./.);
                in if flake ? debug.options then
                  flake.debug.options
                else
                  { }
              '';
            };
            "flake-parts-currentSystem" = {
              expr = ''
                let flake = builtins.getFlake (builtins.toString ./.);
                in if flake ? currentSystem.options then
                  flake.currentSystem.options
                else
                  { }
              '';
            };
          };
        };
      };
    };
  };

  plugins.rustaceanvim = {
    enable = true;
    settings = {
      tools = {
        executor = "toggleterm";
        create_graph = {
          backend = "kitty";
        };
      };
      server = {
        default_settings = {
          rust-analyzer = {
            check = {
              command = "clippy";
              # Enable if buildfile locking becomes an issue
              # extraArgs = [ "--target-dir" "target/nvim/" ]; };
            };
            lens = {
              enable = true;
              debug = true;
              run = true;
              implementations = true;
            };

            inlayHints = {
              enable = true;
              closureReturnTypeHints.enable = "always";
              lifetimeElisionHints = {
                enable = "always";
                useParameterNames = true;
              };
            };

            semanticHighlighting = {
              strings.enable = true;
              operator.enable = true;
            };
          };
        };
      };
    };
  };
}
