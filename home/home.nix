{ host }:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  # https://nix-community.github.io/home-manager
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = host.username;
  home.homeDirectory = "/Users/${host.username}";

  home.packages =
    (import ./pkgs.nix { inherit pkgs; })
    ++ ((lib.attrByPath [ "extras" "pkgs" ] (pkgs: [ ]) host) pkgs);

  fonts.fontconfig.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

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
      # Rust re-maps
      l = "eza -a1lh";
      ls = "eza";
      cat = "bat";
      cd = "z";

      # QOL
      dc = "docker compose";
      rsync = "rsync -az --info=progress2";
      t = "tmux new-session -A -s main";
      e = "nvim";
      g = "lazygit";
      d = "lazydocker";
      p = "pnpm";
      px = "pnpm -s dlx";
      n = "fnm use --install-if-missing";
      c = "pwd | pbcopy";
      k = "kubectl";

      vai = "sudo darwin-rebuild switch --flake ~/.config/nix-macos#${host.hostName}";
    };
  };

  programs = {
    direnv.enable = true;
    zoxide.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        if type -q starship
          starship init fish | source
        end
        if type -q fnm
          fnm env --use-on-cd | source
        end
        if type -q nvs
          nvs env --source | source
        end
      '';
    };
    bash = {
      enable = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      extraConfig = ''
        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # switch panes using jkhl
        bind h select-pane -L
        bind l select-pane -R
        bind j select-pane -U
        bind k select-pane -D
      '';
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
    };
  };
}
