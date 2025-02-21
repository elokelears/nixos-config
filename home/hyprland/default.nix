{ pkgs, ... }: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = ''
      $mainMod = SUPER
      bind = $mainMod, return, exec, kitty
      bind = $mainMod, Q, killactive,

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
    '';
  };
}