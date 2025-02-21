{
  layer = "top";
      margin-bottom = -10;
      margin-top = 10;
      modules-left = [ "custom/launcher" "cpu" "memory" "network" "custom/spotify" "tray" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "backlight" "pulseaudio" "clock" "battery" "custom/power" ];
      
      pulseaudio = {
        tooltip = false;
        scroll-step = 5;
        format = "{icon} {volume}%";
        format-muted = "{icon} {volume}%";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        format-icons = {
          default = [ "" "" "" ];
        };
      };

      network = {
        format-wifi = "";
        format-ethernet = "";
        tooltip-format = "{essid} ({signalStrength}%)";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "⚠";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };

      backlight = {
        tooltip = false;
        format = " {}%";
        interval = 1;
        on-scroll-up = "light -A 5";
        on-scroll-down = "light -U 5";
      };

      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 20;
        };
        format = "{icon}  {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{time} {icon}";
        format-icons = [ "" "" "" "" "" ];
      };

      tray = {
        icon-size = 18;
        spacing = 10;
      };

      clock = {
        format = "{: %I:%M %p   %d/%m/%Y}";
      };

      cpu = {
        interval = 15;
        format = " {}%";
        max-length = 10;
      };

      memory = {
        interval = 30;
        format = " {}%";
        max-length = 10;
      };

      "custom/spotify" = {
        interval = 1;
        return-type = "json";
        exec = "~/.config/waybar/scripts/spotify.sh";
        exec-if = "pgrep spotify";
        escape = true;
      };

      "custom/launcher" = {
        format = " ";
        on-click = "rofi -show drun";
        on-click-right = "killall rofi";
      };

      "custom/power" = {
        format = " ";
        on-click = "bash ~/.config/rofi/leave/leave.sh";
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        on-click = "activate";
      };
}