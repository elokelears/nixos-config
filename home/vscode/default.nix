{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        userSettings = {
          "chat.editor" = {
            fontFamily = "Comic Shanns Mono";
            fontSize = 16.0;
          };
          "debug.console" = {
            fontFamily = "Comic Shanns Mono";
            fontSize = 16.0;
          };
          "editor" = {
            fontFamily = "Comic Shanns Mono";
            fontSize = 16.0;
            inlayHints.fontFamily = "Comic Shanns Mono";
            inlineSuggest.fontFamily = "Comic Shanns Mono";
            fontLigatures = false;
          };
          "editor.minimap.sectionHeaderFontSize" = 10.285714285714286;
          "markdown.preview" = {
            fontFamily = "Noto Serif CJK SC";
            fontSize = 16.0;
          };
          "scm.input" = {
            fontFamily = "Comic Shanns Mono";
            fontSize = 14.857142857142858;
          };
          "screencastMode.fontSize" = 64.0;
          "terminal.integrated.fontSize" = 16.0;
          "workbench.colorTheme" = "Stylix";
        };
    };
}