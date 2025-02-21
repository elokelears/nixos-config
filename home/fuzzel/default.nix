{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        use-bold = true;
        placeholder = "Have A Good Day";
      };
    };
  };
}