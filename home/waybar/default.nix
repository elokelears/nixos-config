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
          "custom/nixos-menu"
          "hyprland/workspaces"
          "clock"
          "custom/sysmonitor"
        ];
        "modules-center" = ["custom/cycle_wall"];
        "modules-right" = [
          "tray"
          "mpris"
          "network"
          "group/audio"
          "battery"
        ];

        "custom/nixos-menu" = {
          "format" = "<span font=\"26px\">󱄅</span>";
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
            "pulseaudio#microphone"
          ];
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
                margin-right: 20px;
                box-shadow: 1px 2px 2px #101010;
                border-radius: 20px;
                background-size: 200% 200%;
                animation: gradient_rv 3s linear infinite;
            }
            #network,
            #custom-sysmonitor {
              background-color: #${config.lib.stylix.colors.base0E};
              color: #${config.lib.stylix.colors.base00};
              border-radius: 20px;
              padding: 4 10px;
              margin: 5px 10px;
              font-weight: bold;
              box-shadow: 1px 2px 2px #101010;
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
        background-color: #5e81ac;
        color: #eceff4;
        padding: 0 10px;
        margin: 4px;
        border-radius: 8px;
      }

      #custom-nixos-menu:hover {
        background-color: #81a1c1;
      }

      /* 菜单样式 */
      .menu {
        background-color: #2e3440;
        border: 2px solid #5e81ac;
        border-radius: 8px;
        padding: 5px;
      }

      .menu-item {
        padding: 5px 10px;
        margin: 2px 0;
        border-radius: 5px;
      }

      .menu-item:hover {
        background-color: #5e81ac;
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
  ];
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };
  programs.cava = {
    enable = true;
    package = pkgs.cava;
  };
}
