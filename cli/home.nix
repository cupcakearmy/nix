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
        hm = "nix run home-manager/master -- switch --flake github:cupcakearmy/nix?dir=cli#${name} -b backup";
      };
      # Lists are not recursively updated, need to do by hand
      packages = common.home.packages ++ [ ];
    };
  };
  merged = lib.recursiveUpdate common overwrite;
in
merged
