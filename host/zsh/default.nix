{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}