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

  plugins.direnv = {
    enable = true;
    settings.silent_load = 0;
  };

  #####################################
  ###          LSP Servers          ###
  #####################################
  lsp.servers = {
    nixd = {
      enable = true;
      config = {
        formatting.command = [ "nixfmt" ];
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
