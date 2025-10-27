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
      "blender"
      "bambu-studio"
      "cyberduck"
    ];
    pkgs =
      pkgs: with pkgs; [
        biome
        infisical
        ffmpeg
        pulumi
      ];
  };
}
