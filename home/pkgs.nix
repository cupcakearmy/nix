{ pkgs }:
with pkgs;
[
  # Base
  tmux
  oh-my-posh
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
  bat
  rsync
  yq

  # Dev
  devenv
  nixpacks
  ollama
  colima
  lazydocker
  exercism

  # Editor
  neovim
  fzf
  lazygit
  lua
  luajitPackages.luarocks
  ast-grep
  ripgrep

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
  ruby
  ruby-lsp
  rubyPackages.prism
  go

  # Fonts
  nerd-fonts.jetbrains-mono
]
