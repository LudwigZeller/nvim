{
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
