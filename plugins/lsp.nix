{ pkgs, ... }:
{
  plugins.direnv.enable = true;
  plugins.rustaceanvim = {
    enable = true;
    settings = {
      tools = {
        executor = "toggleterm";
        create_graph = {
          backend = "kitty";
        };
        enable_clippy = true;
      };
      server = {
        default_settings = {
          rust-analyzer = {
            cmd = [ "rust-analyzer" ];
            check = {
              command = "clippy";
              extraArgs = [
                "--target-dir"
                "target/nvim/"
              ];
            };
          };
        };
      };
    };
  };
}
