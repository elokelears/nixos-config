{ pkgs, ... }:

{
  # Enable Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # Install Git and VSCode
  environment.systemPackages = with pkgs; [
    git
    vscode
  ];
}