{
  pkgs,
  username,
  name,
  homeDirectory,
  lib,
  ...
}:
let
  common = (import ../common/home.nix) { inherit pkgs; };
  overwrite = {
    home.username = username;
    home.homeDirectory = homeDirectory;
    home = {
      shellAliases = {
        hm = "nix run home-manager/master -- switch --flake github:cupcakearmy/nix-cli/v3#${name} -b backup";
      };
    };
  };
in
lib.recursiveUpdate common overwrite
