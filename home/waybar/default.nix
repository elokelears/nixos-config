{ pkgs, ... }:

{ 
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    style = ./style.css;
    settings = {
      mainBar = import ./config.nix;
    };
  };
}