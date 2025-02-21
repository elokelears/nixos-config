{ pkgs, ... }:

{ 
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile = {
    "waybar/config".source = ./config.jsonc;
  };
}