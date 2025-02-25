{
  config,
  pkgs,
  ...
}
: let
  scriptPath = ./scripts/system-monitor.sh;
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
          "clock"
          "custom/sysmonitor"
        ];
        "modules-center" = [];
        "modules-right" = [
          "network"
          "pulseaudio"
          "battery"
        ];
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-active" = "{icon}";
        };
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "interval" = 60;
          "format" = "{:%I:%M}";
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
        "pulseaudio" = {
          "on-click" = "pavucontrol -t 3";
          "on-click-right" = "";
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
      #pulseaudio,
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
  ];
  programs.cava = {
    enable = true;
    package = pkgs.cava;
  };
}
