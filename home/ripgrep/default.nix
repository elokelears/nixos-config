{ pkgs, ... }:

{
  # Enable ripgrep with ripgrep-all, ripgrep is a line-oriented search tool 
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep-all;
  };
}