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

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    nur,
    hyprpanel,
    ...
  }: let
    system = "x86_64-linux";
    username = "elokelears";
    stateVersion = "24.11";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        hyprpanel.overlay
        nur.overlay
      ];
    };

    home = import ./home/home.nix {
      inherit pkgs username stateVersion;
    };
  in {
    nixosConfigurations = {
      NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit username stateVersion;};
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
