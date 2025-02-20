{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #home-manager = {
    #  url = "github:nix-community/home-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    #username = "elokelears";
    #stateVersion = "24.11";

  in {
    nixosConfigurations = {
      intel = nixpkgs.lib.nixosSystem {
        inherit system;
        #specialArgs = { inherit hostname username stateVersion ; };
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
