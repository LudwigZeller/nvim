{
  description = "Nixvim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

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

      perSystem =
        { system, pkgs, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit pkgs;
            module = entry;
            extraSpecialArgs = { };
          };

          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          formatter = pkgs.nixfmt-tree;

          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            default = nvim;
            neovide = pkgs.writeShellScriptBin "neovide" ''
              exec ${pkgs.neovide}/bin/neovide --neovim-bin ${nvim}/bin/nvim "$@"
            '';
          };
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
