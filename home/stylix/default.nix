{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../../wallpaper.png;

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK SC";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK SC";
      };

      monospace = {
        package = pkgs.nerd-fonts.comic-shanns-mono;
        name = "ComicShannsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets = {
      waybar.enable = false;
      vscode.enable = false;
    };
  };
}
