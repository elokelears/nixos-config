{ pkgs, ... }:

{
  # Enable neovim with neovim, neovim is a hyperextensible text editor
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;

  };
}