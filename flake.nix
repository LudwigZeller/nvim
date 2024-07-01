{
  description = "Neovim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, neovim }: flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
    formatter = pkgs.alejandra;
    packages.default = neovim.packages.${system}.neovim;
    apps.default = {
      type="app";
      program = "${neovim.packages.${system}.neovim}/bin/nvim}";
    };
  });
}
