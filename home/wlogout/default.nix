{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "loginctl kill-session $XDG_SESSION_ID";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
    ];
  };
}
