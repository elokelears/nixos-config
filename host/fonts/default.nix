{ pkgs, ... }:

{
  fonts = {
    package = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.comic-shanns-mono
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Comic Shanns Mono" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
      };
    };
  };
}