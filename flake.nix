{
  description = "Personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mole.url = "github:tw93/mole/main";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      mole,
    }:
    let
      hosts = import ./hosts;
      inherit (builtins) listToAttrs;
    in
    {
      darwinConfigurations = listToAttrs (
        map (host: {
          name = host.hostName;
          value = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit host;
              flake = self;
            };
            modules = [
              (import ./darwin.nix)
              home-manager.darwinModules.home-manager
              {
                home-manager.backupFileExtension = "backup";
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${host.username} = import ./home/home.nix { inherit host mole; };
              }
            ];
          };
        }) hosts
      );
    };
}
