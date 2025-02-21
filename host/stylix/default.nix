{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK SC";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK SC";
      };

      monospace = {
        package = pkgs.nerd-fonts-comic-shanns-mono;
        name = "Comic Shanns Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

}
