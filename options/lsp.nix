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

  #####################################
  ###          LSP Servers          ###
  #####################################

  ####################
  ###     nixd     ###
  ####################
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

  ####################
  ###    devenv    ###
  ####################
  filetype.filename."devenv.nix" = "devenv";
  plugins.treesitter.languageRegister.nix = [ "devenv" ];
  autoCmd = [
    {
      event = "FileType";
      pattern = "devenv";
      desc = "Start local devenv lsp";
      callback = lib.nixvim.mkRaw ''
        function(ev)
          local root_dir = vim.fs.root(ev.buf, { "devenv.nix" })
          if not root_dir then return end
          vim.system({'devenv', '--quiet', 'lsp', '--print-config'}, { cwd = root_dir, text = true }, function(obj)
            if obj.code == 0 and obj.stdout then
              vim.schedule(function()
                local ok, devenv_settings = pcall(vim.json.decode, obj.stdout)
                if ok and devenv_settings then
                  local nixd_settings = vim.deepcopy(vim.lsp.config.nixd.settings) or { nixd = {} }
                  -- nixd_settings = { nixd = {}}
                  nixd_settings.nixd.nixpkgs = vim.deepcopy(devenv_settings.nixd.nixpkgs)
                  nixd_settings.nixd.options = vim.deepcopy(devenv_settings.nixd.options)
                  vim.lsp.start({
                    name = "devenv",
                    settings = nixd_settings,
                    root_dir = root_dir,
                    cmd = { "devenv", "lsp" },
                  }, { bufnr = ev.buf })
                end
              end)
            end
          end)
        end
      '';
    }
  ];

  ####################
  ### rust-analzer ###
  ####################
  plugins.rustaceanvim = {
    enable = true;
    settings = {
      tools = {
        executor = "toggleterm";
        crate_test_executor = "neotest";
        test_executor = "neotest";
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
