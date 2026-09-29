{
  username = "nicco";
  hostName = "1k5";
  platform = "aarch64-darwin";
  sshKey = "1k5";

  extras = {
    casks = [
      "notion"
      "linear"
      "miro"
      "loom"
      "cursor"
      "bruno"
      "cyberduck"
      "slack"
    ];
    pkgs =
      pkgs: with pkgs; [
        docker-client
        colima
        google-cloud-sdk
        stripe-cli
      ];
  };
}
