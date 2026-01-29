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
      # "nikitabobko/tap/aerospace"
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
