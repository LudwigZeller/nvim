{
  description = "Nixvim Flake for my personalized setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      flake-parts,
      ...
    }@inputs:
    let
      entry = ./init.nix;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [ inputs.nixvim.flakeModules.default ];

      perSystem =
        { system, pkgs, ... }:
        let
          nvimConfig = nixvim.lib.evalNixvim {
            inherit system;
            modules = [ entry ];
            # extraSpecialArgs = { };
          };
        in
        {
          formatter = pkgs.nixfmt-tree;

          nixvimConfigurations.nvim = nvimConfig;

          packages.default = nvimConfig.config.build.package;

          checks.default = nvimConfig.config.build.test;
        };

      flake = {
        nixosModules.default = {
          imports = [
            inputs.nixvim.nixosModules.nixvim
            {
              programs.nixvim = {
                enable = true;
                imports = [ entry ];
              };
            }
          ];
        };
      };
    };
}
