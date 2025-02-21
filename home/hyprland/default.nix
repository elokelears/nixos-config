{ pkgs, ... }: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}