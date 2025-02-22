{ pkgs, ... }:

{ 
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile = {
    "waybar/config".source = ./config.jsonc;
  };

  home.packages = with pkgs; [
    pango
  ];
  programs.cava = {
    enable = true;
    package = pkgs.cava;
  };
}