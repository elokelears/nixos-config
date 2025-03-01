{
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji-wayland
      rofi-calc
      rofi-power-menu
    ];
  };
  home.packages = with pkgs; [
    dmenu
  ];
}
