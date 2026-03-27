{ pkgs }:
with pkgs;
[
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
  tmux
  tree
  wget
  rsync
  yq

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
  difftastic

  # Dev
  lazydocker
  k9s
  kubectl

  # Editor
  neovim
  fzf
  lazygit

  # Fonts
  nerd-fonts.jetbrains-mono
]
