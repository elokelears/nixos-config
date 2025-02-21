{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
    stylix.url = "github:danth/stylix";
    
  };

  outputs = {  nixpkgs, home-manager, stylix, ... }: 
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
        specialArgs = { inherit  username stateVersion ; };
        modules = [
          stylix.nixosModules.stylix
          ./host
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "bkp";
            home-manager.useUserPackages = true;
            home-manager.users.${username} = home;
          }
        ];
      };
    };
  };
}
