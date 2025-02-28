{
  config,
  pkgs,
  ...
}
: let
  scriptPath = ./scripts/system-monitor.sh;
  volumeControl = ./scripts/volume-control-script.sh;
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      main = {
        "layer" = "top";
        "position" = "top";
        "spacing" = 5;
        "margin-bottom" = -11;
        "modules-left" = [
          "hyprland/workspaces"
          "custom/sysmonitor"
        ];
        "modules-center" = ["custom/nixos-menu" "custom/notification" "clock" "custom/cycle_wall" "idle_inhibitor"];
        "modules-right" = [
          "tray"
          "mpris"
          "network"
          "bluetooth"
          "group/audio"
          "battery"
        ];

        "custom/nixos-menu" = {
          "format" = "<span font=\"13px\">󱄅</span>";
          "tooltip" = false;
          "menu" = "on-click";
          "menu-file" = ./nixos-menu.xml;
        };

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-active" = "{icon}";
        };

        "clock" = {
          "tooltip" = false;
          "interval" = 1;
          "format" = "{:%I:%M:%S}";
          "max-length" = 25;
        };

        "custom/sysmonitor" = {
          "interval" = 3;
          "exec" = "${pkgs.bash}/bin/bash ${scriptPath}";
          "return-type" = "json";
          "format" = "{}";
          "on-click" = "kitty -e htop";
        };

        "backlight" = {
          "interval" = 2;
          "align" = 0;
          "format-icons" = [" " " " " " "󰃝 " "󰃞 " "󰃟 " "󰃠 "];
          "format" = "{icon}";
          "tooltrip-format" = "backlight {percent}%";
          "icon-size" = 10;
        };

        "battery" = {
          "align" = 0;
          "rotate" = 0;
          "full-at" = 100;
          "design-capacity" = false;
          "interval" = 5;
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "{capacity}%";
          "format-plugged" = "󱘖 {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-full" = "{icon} Full";
          "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "format-time" = "{H}h {M}min";
          "tooltip" = true;
          "tooltip-format" = "{timeTo} {power}w";
          "on-click" = "";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = " ";
            "deactivated" = " ";
          };
        };

        "group/audio" = {
          "orientation" = "horizontal";
          "modules" = [
            "pulseaudio"
            "custom/vertical"
            "pulseaudio#microphone"
          ];
        };

        "custom/vertical" = {
          "format" = " | ";
          "tooltip" = false;
        };

        "pulseaudio" = {
          "on-click" = "pavucontrol -t 3";
          "on-click-right" = "${volumeControl} mute";
          "on-scroll-up" = "${volumeControl} up";
          "on-scroll-down" = "${volumeControl} down";
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} 󰂰 {volume}%";
          "format-muted" = "󰖁";
          "format-icons" = {
            "headphone" = "󱡏";
            "hands-free" = "";
            "headset" = "󱡏";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
              "󰕾"
            ];
          };
        };
        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "on-click" = "pavucontrol -t 4";
        };

        "network" = {
          "interval" = 1;
          "on-click" = "kitty -e nmtui";
          "tooltip-format" = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-wifi" = "{icon} {signalStrength}%";
          "format-ethernet" = "󰌘";
          "format-disconnected" = "󰌙";
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };

        "bluetooth" = {
          "format" = "";
          "format-connected" = "󰂱 {num_connections}";
          "format-disabled" = "󰂲";
          "tooltip-format" = " {device_alias}";
          "tooltip-format-connected" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = " {device_alias} 󰂄{device_battery_percentage}%";
          "tooltip" = true;
          "on-click" = "blueman-manager";
        };

        "mpris" = {
          "interval" = 1;
          "format" = "{player_icon} {status_icon}<i>{dynamic}</i>";
          "format-paused" = "{status_icon} <i>{dynamic}</i>";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "on-scroll-up" = "${volumeControl} up";
          "on-scroll-down" = "${volumeControl} down";
          "player-icons" = {
            "chromium" = "";
            "default" = "";
            "firefox" = "";
            "mopidy" = "";
            "mpv" = "󰐹";
            "spotify" = "";
            "vlc" = "󰕼";
          };
          "status-icons" = {
            "paused" = "⏸";
            "playing" = "";
            "stopped" = "";
          };
          "max-length" = 30;
        };

        "custom/notification" = {
          "tooltip" = true;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "";
            "none" = "";
            "dnd-notification" = "";
            "dnd-none" = "";
            "inhibited-notification" = "";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };

        "tray" = {
          "icon-size" = 15;
          "spacing" = 8;
        };

        "custom/playerctl" = {
          "format" = "{icon}<span>{}</span>";
          "return-type" = "json";
          "format-icons" = {
            "playing" = "";
            "stopped" = "";
            "paused" = "⏸";
          };
          "max-length" = 35;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} ~ {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "on-scroll-up" = "${volumeControl} up";
          "on-scroll-down" = "${volumeControl} down";
        };

        "custom/cycle_wall" = {
          "format" = " ";
          "exec" = "echo ; echo 󰸉 wallpaper select";
          "on-click" = "";
          "interval" = 86400;
          "tooltip" = true;
        };
      };
    };
    style = ''
      * {
          font-family: "ComicShannsMono Nerd Font";
          font-size: 13px;
        }
      #waybar {
        background-color: transparent;
      }
      #workspaces{
        background-color: transparent;
        margin-top: 5px;
        margin-bottom: 5px;
        margin-right: 10px;
        margin-left: 20px;
      }
      #workspaces button{
        box-shadow: 1px 2px 2px #101010;
        background-color: #${config.lib.stylix.colors.base04} ;
        border-radius: 20px;
        padding: 4px 9px 4px 9px;
        margin-right: 5px;
        font-weight: bolder;
        color: 	#${config.lib.stylix.colors.base0E} ;
        transition: all 0.5s ease;
      }
      #workspaces button.active{
        padding: 4px 15px 4px 15px;
        border: none;
        box-shadow: 1px 2px 2px #101010;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        background: linear-gradient(45deg, #${config.lib.stylix.colors.base09} 0%, #${config.lib.stylix.colors.base0E}, #${config.lib.stylix.colors.base01} 80%, #${config.lib.stylix.colors.base08} 100%);
        background-size: 300% 300%;
        animation: gradient 5s ease infinite;
        color: #${config.lib.stylix.colors.base04};
      }
      #clock {
          padding: 4px 10px 4px 10px;
          background: linear-gradient(118deg, #${config.lib.stylix.colors.base0B} 5%, #${config.lib.stylix.colors.base0F} 5%, #${config.lib.stylix.colors.base0F} 20%, #${config.lib.stylix.colors.base0B} 20%, #${config.lib.stylix.colors.base0B} 40%, #${config.lib.stylix.colors.base0F} 40%, #${config.lib.stylix.colors.base0F} 60%, #${config.lib.stylix.colors.base0B} 60%, #${config.lib.stylix.colors.base0B} 80%, #${config.lib.stylix.colors.base0F} 80%, #${config.lib.stylix.colors.base0F} 95%, #${config.lib.stylix.colors.base0B} 95%);
          text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
          color: #${config.lib.stylix.colors.base00};
          margin-top: 5px;
          margin-bottom: 5px;
          margin-left: 10px;
          margin-right: 10px;
          box-shadow: 1px 2px 2px #101010;
          border-radius: 20px;
          background-size: 200% 200%;
          animation: gradient_rv 3s linear infinite;
      }


      #mpris,
      #network,
      #custom-sysmonitor {
        background-color: #${config.lib.stylix.colors.base0E};
        color: #${config.lib.stylix.colors.base00};
        border-radius: 20px;
        padding: 4px 10px;
        margin: 5px 10px;
        font-weight: bold;
        box-shadow: 1px 2px 2px #101010;
      }

      #tray {
        background: linear-gradient(45deg, #${config.lib.stylix.colors.base0A} 0%, #${config.lib.stylix.colors.base0F}, #${config.lib.stylix.colors.base0A} 80%, #${config.lib.stylix.colors.base0F} 100%);
        color: #${config.lib.stylix.colors.base00};
        border-radius: 10px;
        padding: 4px 10px;
        margin: 5px 10px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        box-shadow: 1px 2px 2px #101010;
        background-size: 200% 200%;
        animation: gradient_f 4s linear infinite;
      }

      #custom-cycle_wall {
        background-color: #${config.lib.stylix.colors.base07};
        color: #${config.lib.stylix.colors.base00};
        border-radius: 10px;
        padding: 4px 10px;
        margin: 5px 10px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        box-shadow: 1px 2px 2px #101010;
      }

      #bluetooth {
        background-color: #${config.lib.stylix.colors.base0C};
        color: #${config.lib.stylix.colors.base00};
        border-radius: 10px;
        padding: 4px 10px;
        margin: 5px 10px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        box-shadow: 1px 2px 2px #101010;
        background-size: 200% 200%;
        animation: gradient_f 5s ease infinite;
      }

      #idle_inhibitor,
      #audio {
        background-color: #${config.lib.stylix.colors.base0C};
        color: #${config.lib.stylix.colors.base00};
        border-radius: 10px;
        padding: 4px 10px;
        margin: 5px 10px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        box-shadow: 1px 2px 2px #101010;
      }

      #custom-notification {
        background-color: #${config.lib.stylix.colors.base0C};
        color: #${config.lib.stylix.colors.base00};
        border-radius: 10px;
        padding: 4px 13px 4px 10px;
        margin: 5px 10px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        box-shadow: 1px 2px 2px #101010;
      }

      tooltip {
        background-color: #${config.lib.stylix.colors.base0C};
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
        color: #${config.lib.stylix.colors.base00};
      }

      #battery {
      padding: 4px 10px;
        margin: 5px 10px;
        background: #${config.lib.stylix.colors.base0F};
      /* background: linear-gradient(118deg, #${config.lib.stylix.colors.base07} 0%, #${config.lib.stylix.colors.base0F} 25%, #${config.lib.stylix.colors.base07} 50%, #${config.lib.stylix.colors.base0F} 75%, #${config.lib.stylix.colors.base07} 100%); */
      /* background: linear-gradient(118deg, #${config.lib.stylix.colors.base07} 5%, #${config.lib.stylix.colors.base0F} 5%, #${config.lib.stylix.colors.base0F} 20%, #${config.lib.stylix.colors.base07} 20%, #${config.lib.stylix.colors.base07} 40%, #${config.lib.stylix.colors.base0F} 40%, #${config.lib.stylix.colors.base0F} 60%, #${config.lib.stylix.colors.base07} 60%, #${config.lib.stylix.colors.base07} 80%, #${config.lib.stylix.colors.base0F} 80%, #${config.lib.stylix.colors.base0F} 95%, #${config.lib.stylix.colors.base07} 95%);  */
      background: linear-gradient(118deg, #${config.lib.stylix.colors.base0B} 5%, #${config.lib.stylix.colors.base0F} 5%, #${config.lib.stylix.colors.base0F} 20%, #${config.lib.stylix.colors.base0B} 20%, #${config.lib.stylix.colors.base0B} 40%, #${config.lib.stylix.colors.base0F} 40%, #${config.lib.stylix.colors.base0F} 60%, #${config.lib.stylix.colors.base0B} 60%, #${config.lib.stylix.colors.base0B} 80%, #${config.lib.stylix.colors.base0F} 80%, #${config.lib.stylix.colors.base0F} 95%, #${config.lib.stylix.colors.base0B} 95%);
      background-size: 200% 300%;
      animation: gradient_f_nh 4s linear infinite;
      color: #${config.lib.stylix.colors.base01};
      }
      #battery.charging, #battery.plugged {
        background: linear-gradient(118deg, #${config.lib.stylix.colors.base0E} 5%, #${config.lib.stylix.colors.base0D} 5%, #${config.lib.stylix.colors.base0D} 20%, #${config.lib.stylix.colors.base0E} 20%, #${config.lib.stylix.colors.base0E} 40%, #${config.lib.stylix.colors.base0D} 40%, #${config.lib.stylix.colors.base0D} 60%, #${config.lib.stylix.colors.base0E} 60%, #${config.lib.stylix.colors.base0E} 80%, #${config.lib.stylix.colors.base0D} 80%, #${config.lib.stylix.colors.base0D} 95%, #${config.lib.stylix.colors.base0E} 95%);
        background-size: 200% 300%;
        animation: gradient_rv 4s linear infinite;
      }
      #battery.full {
        background: linear-gradient(118deg, #${config.lib.stylix.colors.base0E} 5%, #${config.lib.stylix.colors.base0D} 5%, #${config.lib.stylix.colors.base0D} 20%, #${config.lib.stylix.colors.base0E} 20%, #${config.lib.stylix.colors.base0E} 40%, #${config.lib.stylix.colors.base0D} 40%, #${config.lib.stylix.colors.base0D} 60%, #${config.lib.stylix.colors.base0E} 60%, #${config.lib.stylix.colors.base0E} 80%, #${config.lib.stylix.colors.base0D} 80%, #${config.lib.stylix.colors.base0D} 95%, #${config.lib.stylix.colors.base0E} 95%);
        background-size: 200% 300%;
        animation: gradient_rv 20s linear infinite;
      }


      @keyframes gradient {
       0% {
        background-position: 0% 50%;
       }
       50% {
       	background-position: 100% 50%;
       }
       100% {
       	background-position: 0% 50%;
       }
      }
      @keyframes gradient_f {
       0% {
        background-position: 0% 200%;
       }
        50% {
          background-position: 200% 0%;
        }
       100% {
       	background-position: 400% 200%;
       }
      }
      @keyframes gradient_f_nh {
       0% {
        background-position: 0% 200%;
       }
       100% {
        background-position: 200% 200%;
       }
      }
      @keyframes gradient_rv {
        0% {
          background-position: 200% 200%;
        }
        100% {
          background-position: 0% 200%;
        }
      }

      #custom-nixos-menu {
        background-image: radial-gradient(#${config.lib.stylix.colors.base0E}, #${config.lib.stylix.colors.base0D}, #${config.lib.stylix.colors.base0B});
        color: #${config.lib.stylix.colors.base00};
        padding: 4px 13px 4px 10px;
        margin: 5px 10px;
        border-radius: 8px;
        background-size: 200% 300%;
        animation: gradient_rv 5s ease infinite;
      }

      #custom-nixos-menu:hover {
        background-color: #${config.lib.stylix.colors.base0E};
      }

       /* 菜单样式 */
      .menu {
        background-color: #${config.lib.stylix.colors.base03};
        border: 2px solid #${config.lib.stylix.colors.base06};
        border-radius: 8px;
        padding: 5px;
      }

      .menu-item {
        padding: 5px 10px;
        margin: 2px 0;
        border-radius: 5px;
      }

      .menu-item:hover {
        background-color:#${config.lib.stylix.colors.base0B};
      }
    '';
  };

  home.packages = with pkgs; [
    pango
    hyprpicker
    wl-clipboard
    htop
    mpc-qt
    pavucontrol
    blueman
    playerctl
    pulseaudioFull
    yad
    networkmanagerapplet
    iwgtk
    yt-dlp
  ];
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };
  programs.cava = {
    enable = true;
    package = pkgs.cava;
  };
  programs.yt-dlp = {
    enable = true;
    package = pkgs.yt-dlp;
    settings = {
    };
  };
}
