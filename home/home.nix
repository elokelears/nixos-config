{ username, stateVersion,  ... }:

{
  home.username = username;

  home.homeDirectory = "/home/${username}";

  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  imports = [
    ./git
    ./vscode
    ./jetbrains
    ./make
    ./ripgrep
    ./neovim
    ./gcc
    ./kitty
    ./waybar
    ./hyprland
  ];
}