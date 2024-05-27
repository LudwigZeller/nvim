{
  description = "Neovim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
    formatter.${system} = pkgs.alejandra;
    packages.default = pkgs.stdenv.mkDerivation {
      name="nvim";
      src = ./.;
      BuildInputs = with pkgs;[
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
        cp ./lazy-lock.json $out/run
        cp ./init.lua $out/run
        cp -r ./lua $out/run
        # ln $XDG_CONFIG_HOME/nvim $out/run

        mkdir -p $out/bin
        cp ${pkgs.neovim}/bin/nvim $out/bin
        cp ${pkgs.neovide}/bin/neovide $out/bin
      '';
    };
  });
}