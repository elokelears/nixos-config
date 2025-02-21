{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = {  nixpkgs, home-manager, stylix, nur, ... }: 
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
          nur.modules.nixos.default
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${username} = home;
          }
        ];
      };
    };
  };
}
