{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      preload = ./wallpaper.jpg;
      wallpaper = ./wallpaper.jpg;
    };
  };
}
