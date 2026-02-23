{ lib, ... }:
let
  files = builtins.readDir ./.;
  validFiles = lib.filterAttrs (name: type:
    type == "regular" &&
    lib.hasSuffix ".nix" name &&
    name != "default.nix"
  ) files;
in
{
  imports = map (name: ./. + "/${name}") (builtins.attrNames validFiles);
}
