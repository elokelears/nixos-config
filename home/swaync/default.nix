{
  pkgs,
  lib,
  ...
}: {
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      layer = "overlay";
      control-center-layer = "top";

      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;

      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 300;
      control-center-height = 800;
      notification-window-width = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      scripts = {
        example-script = {
          exec = "echo 'Do something ...'";
          urgency = "Normal";
        };

        example-action-script = {
          exec = "echo 'Do something actionable!'";
          urgency = "Normal";
          run-on = "action";
        };
      };

      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "Low";
          app-name = "Spotify";
        };
      };

      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "󰂚  Notifications";
          clear-all-button = true;
          button-text = "󰆴  Clear All";
        };
        volume = {
          label = "";
        };
        dnd = {
          text = "   Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        "mpris" = {
          image-size = 90;
          image-radius = 6;
        };
      };
    };
  };
}
