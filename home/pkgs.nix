{ pkgs }:
with pkgs;
[
  # Base
  tmux
  git
  git-lfs
  git-crypt
  gh
  bfg-repo-cleaner
  gnutar
  gnupg
  htop
  btop
  rclone
  rename
  tmux
  tree
  wget
  woff2
  rsync
  yq
  delta

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

  # Dev
  devenv
  nixpacks
  ollama
  colima
  lazydocker
  exercism
  posting
  terraform
  k9s
  kubectl
  claude-code

  # Editor
  nvs
  neovim
  fzf
  lazygit
  lua
  luajitPackages.luarocks
  ast-grep

  # Language specific
  nixfmt-rfc-style
  fnm
  bun
  deno
  zig
  uv
  ruff
  tectonic
  tex-fmt
  rustup
  shfmt
  go

  # Fonts
  nerd-fonts.jetbrains-mono
  karla
]
