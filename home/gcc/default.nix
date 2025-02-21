{ pkgs, ... }:

{
  # gcc is a compiler collection
  home.packages = with pkgs; [
    gcc
  ];
}