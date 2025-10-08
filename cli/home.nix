{
  config,
  pkgs,
  username,
  name,
  homeDirectory,
  ...
}:

{
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "25.11";

  home.packages = (import ./pkgs.nix { inherit pkgs; });

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

      hm = "nix run home-manager/master -- switch --flake github:cupcakearmy/nix-cli/v3#${name} -b backup";
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
