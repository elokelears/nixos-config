{
  pkgs,
  config,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    extraConfig = ''
      background {
        monitor =
        path = ../../../wallpaper.png   # only png supported for now

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_size = 4
        blur_passes = 3 # 0 disables blurring
        noise = 0.0117
        contrast = 1.3000 # Vibrant!!!
        brightness = 0.8000
        vibrancy = 0.2100
        vibrancy_darkness = 0.0
      }

      # Hours
      label {
        monitor =
        text = cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"
        color = ${config.lib.stylix.colors.base0E}
        font_size = 112
        font_family = ComicShanns Mono Nerd Font 10
        shadow_passes = 3
        shadow_size = 4

        position = 0, 220
        halign = center
        valign = center
      }

      # Minutes
      label {
          monitor =
          text = cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
          color = ${config.lib.stylix.colors.base0E}
          font_size = 112
          font_family = Geist Mono 10
          shadow_passes = 3
          shadow_size = 4

          position = 0, 80
          halign = center
          valign = center
      }

      # Today
      label {
          monitor =
          text = cmd[update:18000000] echo "<b><big> "$(date +'%A')" </big></b>"
          color = ${config.lib.stylix.colors.base06}
          font_size = 22
          font_family = ComicShanns Mono Nerd Font 10

          position = 0, 30
          halign = center
          valign = center
      }

      # Week
      label {
          monitor =
          text = cmd[update:18000000] echo "<b> "$(date +'%d %b')" </b>"
          color = ${config.lib.stylix.colors.base06}
          font_size = 18
          font_family = ComicShanns Mono Nerd Font 10

          position = 0, 6
          halign = center
          valign = center
      }

      # Degrees
      label {
          monitor =
          text = cmd[update:18000000] echo "<b>Feels like<big> $(curl -s 'wttr.in?format=%t' | tr -d '+') </big></b>"
          color = ${config.lib.stylix.colors.base06}
          font_size = 18
          font_family = ComicShanns Mono Nerd Font 10

          position = 0, 40
          halign = center
          valign = bottom
      }

      input-field {
          monitor =
          size = 250, 50
          outline_thickness = 3

          dots_size = 0.26 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          dots_rouding = -1

          rounding = 22
          outer_color = $color0
          inner_color = $color0
          font_color = $color6
          fade_on_empty = true
          placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.

          position = 0, 120
          halign = center
          valign = bottom
      }
    '';
  };
}
