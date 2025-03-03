{pkgs, ...}: {
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "hyprlock";
      };

      listener = {
        timeout = 600;
        on-resume = "${pkgs.libnotify}/bin/notify-send -t 5000 \"Welcome back! Be productive.\"";
        on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
      };
    };
  };
}
