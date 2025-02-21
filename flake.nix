{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    username = "elokelears";
    stateVersion = "24.11";
    pkgs = nixpkgs.legacyPackages.${system};
    
    home = import ./home/home.nix {
      inherit pkgs username stateVersion;
    };

  in {
    nixosConfigurations = {
      NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs username stateVersion ; };
        modules = [
          ./host
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.user.${username} = home;
          }
        ];
      };
    };
  };
}
