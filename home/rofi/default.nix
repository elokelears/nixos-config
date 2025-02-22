{ pkgs, ... }: 

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = ./style-2.rasi
  };
}