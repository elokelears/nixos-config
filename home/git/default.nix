{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    
    # Basic user settings
    userName = "elokelears";
    userEmail = "elokelears@gmail.com";
    
  };
}