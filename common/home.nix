{
  pkgs,
  ...
}:
{

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Base
    tmux
    git
    git-lfs
    git-crypt
    gnutar
    gnupg
    htop
    btop
    rclone
    rename
    tree
    wget
    rsync
    yq
    delta
    kubectl
    croc
    asciinema_3
    grex
    mise

    # Rust utils
    bat
    eza
    fd
    ripgrep
    ripgrep-all
    zoxide
    uutils-coreutils-noprefix
    dust
    yazi
    starship
    ouch

    # TUI
    lazydocker
    lazygit
    k9s

    # Editor
    neovim
    fzf

    # Fonts
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      # Rust re-maps
      l = "eza -a1lh";
      ls = "eza";
      cat = "bat";
      cd = "z";

      # QOL
      dc = "docker compose";
      dcl = "dc logs -f";
      dclt = "dcl --tail 100";
      dcln = "dcl --since 1m";
      rsync = "rsync -az --info=progress2";
      t = "tmux new-session -A -s main";
      e = "nvim";
      g = "lazygit";
      d = "lazydocker";
      k = "kubectl";
      colima-start = "colima start --cpu 4 --memory 8 --vm-type=vz --vz-rosetta";
    };
  };

  programs = {
    home-manager.enable = true;
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
        if type -q mise
          mise activate fish | source
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
