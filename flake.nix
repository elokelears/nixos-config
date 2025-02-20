{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #home-manager = {
    #  url = "github:nix-community/home-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    hostname = "NixOS";
    username = "elokelears";
    stateVersion = "24.11";

  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit hostname username stateVersion ; };
        modules = [
          ./host
          #home-manager.nixosModules.home-manager
          #{
           # home-manager.useGlobalPkgs = true;
           # home-manager.useUserPackages = true;
          #}
        ];
      };
    };
  };
}