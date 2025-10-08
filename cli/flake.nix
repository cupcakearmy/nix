{
  description = "Server Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      profiles = import ./profiles.nix;
    in
    {
      homeConfigurations = nixpkgs.lib.genAttrs (builtins.map (p: p.name) profiles) (
        profile:
        let
          p = (nixpkgs.lib.findFirst (p: p.name == profile) null profiles);
          system = p.architecture;
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home.nix ];

          extraSpecialArgs = {
            username = p.username;
            homeDirectory = p.homeDirectory;
            name = p.name;
          };
        }
      );
    };
}
