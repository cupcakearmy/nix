{ pkgs }:
with pkgs;
[
  # Base
  gh
  bfg-repo-cleaner
  woff2

  # Dev
  devenv
  nixpacks
  posting
  terraform
  opencode

  # Editor
  nvs
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
  karla
]
