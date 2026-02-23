{
  description = "Neovim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      neovim-fhs = { script }: (pkgs.buildFHSEnv {
          name = "neovim-fhs";
          targetPkgs = pkgs: with pkgs; [
            neovim neovide
            go
            cargo
            lua51Packages.lua lua51Packages.luarocks
            php php84Packages.composer
            nodePackages.nodejs nodePackages.npm
            zulu # Java + JavaC
            julia
            # python3Full
            # python314 python314Packages.pip
            python313 python313Packages.pip
            ruby
          ];

          profile = ''
            export XDG_CONFIG_HOME=${pkgs.linkFarm "nvim-config" [ { name = "nvim"; path = ./.; } ]}
          '';

          runScript = script;
        });
        in
      {
        packages = rec {
          neovim = neovim-fhs { script = "nvim"; };
          neovide = neovim-fhs { script = "neovide"; };
          default = neovim;
        };
        apps = rec {
          neovim = flake-utils.lib.mkApp { drv = self.packages.${system}.neovim; };
          neovide = flake-utils.lib.mkApp { drv = neovim-fhs {script = "neovide"; }; };
          default = neovim;
        };
      }
    );
}

