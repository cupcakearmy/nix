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
      ".config/omp/config.yaml".source = ../files/omp/config.yaml;
      ".config/ghostty/config".source = ../files/ghostty/config;
      ".gitconfig".source = ../files/git/gitconfig;
      ".gitignore_global".source = ../files/git/gitignore_global;
      ".gitconfig.local".source = ../files/git/config.work;
      ".config/nvim".source = ../files/nvim;

      # Secrets
      ".ssh/config".source = ../secrets/ssh/config;
    };

    shellAliases = {
      l = "eza -a1lh";
      ls = "eza";
      dc = "docker compose";
      rsync = "rsync -az --info=progress2";
      t = "tmux new-session -A -s main";
      e = "nvim";
      g = "lazygit";
      d = "lazydocker";
      vai = "sudo darwin-rebuild switch --flake ~/.config/nix-macos#${host.hostName}";

      p = "pnpm";
      px = "pnpm -s dlx";
    };
  };

  programs = {
    direnv.enable = true;
    zoxide.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        # if type -q oh-my-posh
        #   oh-my-posh init fish --config ~/.config/omp/config.yaml | source
        # end
        if type -q starship
          starship init fish | source
        end
        if type -q fnm
          fnm env --use-on-cd | source
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
