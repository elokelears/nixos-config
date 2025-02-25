{
  pkgs,
  config,
  ...
}: let
  path = ../../../wallpaper.png;
in {
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    extraConfig = ''
      background {
        monitor =
        path = ${path}  # only png supported for now

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_size = 4
        blur_passes = 3 # 0 disables blurring
        noise = 0.0117
        contrast = 1.3000 # Vibrant!!!
        brightness = 0.8000
        vibrancy = 0.2100
        vibrancy_darkness = 0.0
      }


    '';
  };
}
