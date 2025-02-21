{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        userSettings = {
            "editor.formatOnSave" = true;
            "nix.enableLanguageServer" = true;
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
 "[javascript]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
        };
    };
}