{
  username = "nicco";
  hostName = "1k5";
  platform = "aarch64-darwin";
  sshKey = "1k5";

  extras = {
    casks = [
      "notion"
      "linear-linear"
      "miro"
      "loom"
      "zed"
    ];
    pkgs =
      pkgs: with pkgs; [
        docker-client
        colima
        google-cloud-sdk
        gemini-cli
        terramate
        ffmpeg-full
        stripe-cli
      ];
  };
}
