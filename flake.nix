{
  description = "Neovim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    inputs.flake-utils.url = "github:numtide/flake-utils";
    inputs.flake-utils.inputs.follows = "nixpkgs";
  };

  outputs = { self, lib, stdenv, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
    name="nvim-personal";
    src = ./;
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = stdenv.mkDerivation {

    };


  });
}
