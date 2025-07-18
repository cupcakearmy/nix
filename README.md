# Dotfiles with Nix on macOS

## Installation

```bash
# Install nix [without the --determinate flag]
# ⚠️ When asked if install the determinate version say no
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install brew [for casks]
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Get repo
git clone https://github.com/cupcakearmy/nix-macos ~/.config/nix-macos

# Unlock (Given that the base64 key is in your clipboard)
nix shell nixpkgs#git nixpkgs#git-crypt nixpkgs#coreutils
pbpaste | base64 --decode > .key
git-crypt unlock .key

# Installation
# Available hosts can be found in the ./hosts directory
sudo nix run nix-darwin -- switch --flake ~/.config/nix-macos#<host>

# After installation simply use the provided alias to rebuild
vai
```

## Documentation

- [nix-darwin](https://daiderd.com/nix-darwin/manual/index.html)

## Crypt

Files under `secrets` are encrypted using `git-crypt`.

```bash
# Save the key, when the repo is unlocked
git-crypt export-key - | base64 > .key.b64

# Decode (Given the base64 key is written to .key.b64)
cat .key.b64 | base64 --decode > .key
git-crypt unlock .key
```

## TODO

Stuff that I would like to automate, but have not found a way/time

- Disable the default Spotlight keyboard shortcut. For now manually go to Settings -> Keyboard Shortcuts -> Spotlight -> Untick
- `chsh -s /run/current-system/sw/bin/fish`
- vscodium settings (download `zokugun.sync-settings` -> open repository settings -> paste secrets/configs/vscodium-sync.yaml -> download config)
- browser extensions
  - bitwarden
  - canvas blocker
  - surfshark
  - ublock origin
  - vimium
