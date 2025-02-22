{ pkgs, lib, ... }: 

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    theme = lib.mkForce ./rofi-theme/files/launchers/type-6/style-10.rasi;
  };
}