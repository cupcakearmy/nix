{ host, mole }:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  common = (import ../common/home.nix) { inherit pkgs; };
  dots = "${config.home.homeDirectory}/.config/dotfiles";
  # Symlink into the repo instead of /nix/store, so the target stays writable.
  link = rel: { source = config.lib.file.mkOutOfStoreSymlink "${dots}/${rel}"; };
  overwrite = {
    home.username = host.username;
    home.homeDirectory = "/Users/${host.username}";

    home.packages =
      common.home.packages
      ++ (import ./pkgs.nix { inherit pkgs; })
      ++ [ mole.packages.${host.platform}.mole ]
      ++ ((lib.attrByPath [ "extras" "pkgs" ] (pkgs: [ ]) host) pkgs);

    fonts.fontconfig.enable = true;

    home = {

      file = {
        # Writable symlinks into the repo
        ".config/zed" = link "secrets/zed";
        ".agents" = link "files/agents";
        ".config/opencode/AGENTS.md" = link "secrets/opencode/AGENTS.md";

        # Read Only
        ".config/ghostty/config".source = ../files/ghostty/config;
        ".gitconfig".source = ../files/git/gitconfig;
        ".gitignore_global".source = ../files/git/gitignore_global;
        ".gitconfig.local".source = ../secrets/git/config.${host.hostName};
        ".config/lazygit/config.yml".source = ../files/lazygit/config.yaml;
        ".config/lazydocker/config.yml".source = ../files/lazydocker/config.yml;

        # Secrets
        ".ssh/config".text = builtins.replaceStrings [ "@SSH_KEY@" ] [ host.sshKey ] (
          builtins.readFile ../secrets/ssh/config.template
        );
      };

      shellAliases = {
        p = "pnpm";
        px = "pnpm -s dlx";
        c = "pwd | pbcopy";

        vai = "sudo darwin-rebuild switch --flake ~/.config/dotfiles#${host.hostName}";
        clean = "nix profile wipe-history && nix store gc && nix store optimise";
      };

      sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
      };
    };
  };

  merged = lib.recursiveUpdate common overwrite;
in
merged
