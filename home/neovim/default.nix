{ pkgs, ... }:

{
  # Enable neovim with neovim-unwrapped, neovim is a hyperextensible text editor
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

  };

  xdg = {
    enable = true;
    configFile = {
      "nvim/init.lua" = {
      source = ./init.lua;
      };
    };
  };
}