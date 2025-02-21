{ pkgs, ... }:

{
  # Enable Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

}