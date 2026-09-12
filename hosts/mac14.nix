{
  username = "cupcakearmy";
  hostName = "mac14";
  platform = "aarch64-darwin";
  sshKey = "legba";

  extras = {
    casks = [
      "surfshark"
      "signal"
      "discord"
      "daisydisk"
      "bambu-studio"
      "cyberduck"
      "balenaetcher"
      "datagrip"
      "transmission"
      "steam"
      "android-studio"
      "opencode-desktop"
      "anytype"
      "linear"
      "jan"
      "bitwarden"
      "freecad"
      "blender"
      "freelens"
    ];
    pkgs =
      pkgs: with pkgs; [
        docker-client
        colima
        docker-buildx
        biome
        infisical
        ffmpeg
        mkcert
	codecrafters-cli
	postgresql_18
      ];
  };
}
