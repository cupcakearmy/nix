{
  username = "cupcakearmy";
  hostName = "mac14";
  platform = "aarch64-darwin";
  sshKey = "legba";

  extras = {
    casks = [
      "surfshark"
      "visual-studio-code"
      "signal"
      "discord"
      "daisydisk"
      "bambu-studio"
      "cyberduck"
      "datagrip"
      "bruno"
      "transmission"
      "iina"
      "steam"
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
      ];
  };
}
