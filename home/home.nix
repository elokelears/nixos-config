{
  username,
  stateVersion,
  ...
}: {
  home.username = username;

  home.homeDirectory = "/home/${username}";

  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  imports = [
    ./git
    ./vscode
    ./jetbrains
    ./make
    ./ripgrep
    ./neovim
    ./gcc
    ./kitty
    ./waybar
    ./hypr
    ./fuzzel
    ./rofi
    ./stylix
  ];

  # let electron support wayland
  xdg.configFile = {
    "electron-flags.conf".text = ''
      --enable-features=WaylandWindowDecorations
      --ozone-platform-hint=auto
    '';
    "electron13-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
  };
}
