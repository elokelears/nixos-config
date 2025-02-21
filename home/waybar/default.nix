{ pkgs, ... }:

{ 
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = import ./config.nix;
    };
  };
}