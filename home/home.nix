{ pkgs, username, stateVersion,  ... }:

{
  home.username = username;

  home.homeDirectory = "/home/${username}";

  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  imports = [
    
  ];
}