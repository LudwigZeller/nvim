{
  description = "Neovim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    inputs.flake-utils.url = "github:numtide/flake-utils";
    inputs.flake-utils.inputs.follows = "nixpkgs";
  };

  outputs = { self, stdenv, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = stdenv.mkDerivation {
      name="nvim-personal";
      src = ./.;
      BuildInputs = with pkgs;[
        neovim
        neovide
        php83
        php83Packages.composer
        nodejs
        jdk
        julia
        python312Packages.python
        python312Packages.pip
        lua54Packages.lua
        lua54Packages.luarocks
        cargo
        rustc
      ];

      installPhase = ''
        mkdir -p $out/run
        cp ./lazy-lock.json $out/run/lazy-lock.json
        cp ./init.lua $out/run/init.lua
        cp -r ./lua $out/run/lua
        ln $XDG_CONFIG_DIR/nvim $out/run

        mkdir -p $out/bin
        cp ${pkgs.neovim}/bin/nvim $out/bin
      '';
    };
  });
}
