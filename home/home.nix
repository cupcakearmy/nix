{ host }:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  common = (import ../common/home.nix) { inherit pkgs; };
  overwrite = {
    home.username = host.username;
    home.homeDirectory = "/Users/${host.username}";

    home.packages =
      common.home.packages
      ++ (import ./pkgs.nix { inherit pkgs; })
      ++ ((lib.attrByPath [ "extras" "pkgs" ] (pkgs: [ ]) host) pkgs);

    fonts.fontconfig.enable = true;

    home = {

      file = {
        ".config/ghostty/config".source = ../files/ghostty/config;
        ".gitconfig".source = ../files/git/gitconfig;
        ".gitignore_global".source = ../files/git/gitignore_global;
        ".gitconfig.local".source = ../secrets/git/config.${host.hostName};
        ".config/nvim".source = ../files/nvim;
        "Library/Application Support/lazydocker/config.yml".source = ../files/lazydocker/config.yml;

        # Secrets
        ".ssh/config".text = builtins.replaceStrings [ "@SSH_KEY@" ] [ host.sshKey ] (
          builtins.readFile ../secrets/ssh/config.template
        );
      };

      shellAliases = {
        p = "pnpm";
        px = "pnpm -s dlx";
        n = "fnm use --install-if-missing";
        c = "pwd | pbcopy";

        vai = "sudo darwin-rebuild switch --flake ~/.config/dotfiles#${host.hostName}";
        clean = "nix-collect-garbage -d";
      };
    };
  };

  merged = lib.recursiveUpdate common overwrite;
in
merged
