{
  pkgs,
  lib,
  ...
}: let
  rofiThemePath =
    ./style-1.rasi;
in {
  home.pointerCursor = {
    name = lib.mkForce "Bibata-Modern-Ice";
    package = lib.mkForce pkgs.bibata-cursors;
    size = 28;
    gtk.enable = true;
    x11.enable = true;
    x11.defaultCursor = lib.mkForce "Bibata-Modern-Ice";
  };
  gtk = {
    enable = true;
    cursorTheme.name = lib.mkForce "Bibata-Modern-Ice";
    cursorTheme.size = 28;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings.exec-once = [
      "fcitx5"
      "waybar"
      "polkit_gnome"
    ];
    extraConfig = ''

            exec-once = wl-paste --type text --watch cliphist store
            exec-once = wl-paste --type image --watch cliphist store

            ################
            ### MONITORS ###
            ################

            monitor = DP-1,3840x2160,auto,2

            xwayland {
              force_zero_scaling = true
            }

            ###########
            ### env ###
            ###########

            env = ELECTRON_OZONE_PLATFORM_HINT,wayland
            env = NIXOS_OZONE_WL,1
            env = GDK_BACKEND,wayland
            env = XCURSOR_THEME,Bibata-Modern-Ice
            env = XCURSOR_SIZE,28
            env = HYPRCURSOR_THEME,Bibata-Modern-Ice
            env = HYPRCURSOR_SIZE,28
            env = GDK_SCALE,2
            env = QT_QPA_PLATFORM, wayland
            env = QT_QPA_PLATFORMTHEME, qt5ct

            ##################
            ### Auto Start ###
            ##################

            $mainMod = SUPER
            bind = $mainMod, M, exec, ./menu.sh
            bind = $mainMod, return, exec, kitty
            bind = $mainMod, Q, killactive,
            bind = $mainMod SHIFT, Q, exec, hyprctl dispatch killactive && sleep 0.1 && pkill -f $(hyprctl activewindow -j | jq -r '.class')
            bind = $mainMod, tab, exec, rofi -show drun -theme ${rofiThemePath}
            # 全屏切换
            bind = $mainMod, F, fullscreen
            # 打开Firefox
            bind = $mainMod, B, exec, firefox
            # 切换当前窗口的平铺/浮动状态
            bind = $mainMod, T, togglefloating

            # Move focus with mainMod + arrow keys
            # Changed to vim binding
            bind = $mainMod, h, movefocus, l
            bind = $mainMod, j, movefocus, d
            bind = $mainMod, k, movefocus, u
            bind = $mainMod, l, movefocus, r

            # 窗口大小调整 - Vim风格 (Super+Shift+HJKL)
            bind = $mainMod SHIFT, h, resizeactive, -20 0  # 向左缩小
            bind = $mainMod SHIFT, j, resizeactive, 0 20   # 向下扩大
            bind = $mainMod SHIFT, k, resizeactive, 0 -20  # 向上缩小
            bind = $mainMod SHIFT, l, resizeactive, 20 0   # 向右扩大

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

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            # 音量控制
            bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
            bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

            # 亮度控制
            bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
            bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

            # 媒体控制
            bind = , XF86AudioPlay, exec, playerctl play-pause
            bind = , XF86AudioNext, exec, playerctl next
            bind = , XF86AudioPrev, exec, playerctl previous
            bind = , XF86AudioStop, exec, playerctl stop

            # Window rules
            windowrule = float, ^(imv)$
            windowrule = float, ^(mpv)$
            windowrule = keepaspectratio, ^(mpv)$
            windowrule = float,title:^(Calculator)$
            windowrule = float,title:^(System Monitor)$
            windowrule = size 70% 75%,title:^(System Monitor)$
            windowrule = opacity 0.95, title:^(System Monitor)$
            windowrule = float,title:^(Network Connections)$
            windowrule = opacity 0.94, title:^(Network Connections)$
            windowrule = float,title:^(Volume Control)$
            windowrule = size 60% 65%,title:^(Volume Control)$
            windowrule = opacity 0.95, title:^(Volume Control)$
            windowrule = float,^(org.gnome.clocks)$
            # windowrule = animation popin 65%, ^(wofi)$
            windowrule = opacity 0.95, ^(nemo)$
            windowrule = opacity 0.95, ^(xed)$
            windowrule = opacity 0.95, ^(codium-url-handler)$
            windowrule = noblur,^(.*)$

            windowrule = center 1,^(org.gnome.clocks|mpv|imv|org.gnome.Calculator|org.gnome.SystemMonitor|nm-connection-editor|org.pulseaudio.pavucontrol)$

            # Window rulesv2
            windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

            # Layer rules
            layerrule = blur, logout_dialog # wlogout

            layerrule = blur, swaync-control-center
            layerrule = blur, swaync-notification-window
            layerrule = animation fade, ^(?!swaync-control-center$)(?!swaync-notification-window$).*

            layerrule = ignorezero, swaync-control-center
            layerrule = ignorezero, swaync-notification-window

            layerrule = ignorealpha 0.5, swaync-control-center
            layerrule = ignorealpha 0.5, swaync-notification-window


            input {
            # Keyboard: Add a layout and uncomment kb_options for Win+Space switching shortcut
            kb_layout = us
            # kb_options = grp:win_space_toggle
            numlock_by_default = true
            repeat_delay = 250
            repeat_rate = 35

            touchpad {
              natural_scroll = yes
              disable_while_typing = true
              clickfinger_behavior = true
              scroll_factor = 0.5
            }
            special_fallthrough = true
            follow_mouse = 1
            }

            binds {
            # focus_window_on_workspace_c# For Auto-run stuff see execs.confhange = true
            scroll_event_delay = 0
            }

      gestures {
          workspace_swipe = true
          workspace_swipe_distance = 700
          workspace_swipe_fingers = 4
          workspace_swipe_cancel_ratio = 0.2
          workspace_swipe_min_speed_to_force = 5
          workspace_swipe_direction_lock = true
          workspace_swipe_direction_lock_threshold = 10
          workspace_swipe_create_new = true
      }

      general {
          # Gaps and border
          gaps_in = 4
          gaps_out = 5
          gaps_workspaces = 50
          border_size = 1



          resize_on_border = true
          no_focus_fallback = true
          layout = dwindle

          #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
          allow_tearing = true # This just allows the `immediate` window rule to work
      }

      dwindle {
      	preserve_split = true
      	smart_split = false
      	smart_resizing = false
      }

      decoration {
          rounding = 20
          active_opacity = 0.95
          inactive_opacity = 0.75
          fullscreen_opacity = 1

          blur {
              enabled = true
              xray = true
              special = false
              new_optimizations = true
              size = 14
              passes = 4
              brightness = 1
              noise = 0.01
              contrast = 1
              popups = true
              popups_ignorealpha = 0.6
          }

          # Shadow
          shadow {
              enabled = true
              ignore_window = true
              range = 20
              offset = 0 2
              render_power = 4
              color = rgba(0000002A)
          }

          # Window Opacities
          # active_opacity = 1
          # inactive_opacity = 1
          # fullscreen_opacity = 1

          # Shader
          # screen_shader = ~/.config/hypr/shaders/nothing.frag
          # screen_shader = ~/.config/hypr/shaders/vibrance.frag

          # Dim
          dim_inactive = false
          dim_strength = 0.1
          dim_special = 0
      }

      animations {
          enabled = true
          # Animation curves

          bezier = linear, 0, 0, 1, 1
          bezier = md3_standard, 0.2, 0, 0, 1
          bezier = md3_decel, 0.05, 0.7, 0.1, 1
          bezier = md3_accel, 0.3, 0, 0.8, 0.15
          bezier = overshot, 0.05, 0.9, 0.1, 1.1
          bezier = crazyshot, 0.1, 1.5, 0.76, 0.92
          bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
          bezier = menu_decel, 0.1, 1, 0, 1
          bezier = menu_accel, 0.38, 0.04, 1, 0.07
          bezier = easeInOutCirc, 0.85, 0, 0.15, 1
          bezier = easeOutCirc, 0, 0.55, 0.45, 1
          bezier = easeOutExpo, 0.16, 1, 0.3, 1
          bezier = softAcDecel, 0.26, 0.26, 0.15, 1
          bezier = md2, 0.4, 0, 0.2, 1 # use with .2s duration
          # Animation configs
          animation = windows, 1, 3, md3_decel, popin 60%
          animation = windowsIn, 1, 3, md3_decel, popin 60%
          animation = windowsOut, 1, 3, md3_accel, popin 60%
          animation = border, 1, 10, default
          animation = fade, 1, 3, md3_decel
          # animation = layers, 1, 2, md3_decel, slide
          animation = layersIn, 1, 3, menu_decel, slide
          animation = layersOut, 1, 1.6, menu_accel
          animation = fadeLayersIn, 1, 2, menu_decel
          animation = fadeLayersOut, 1, 4.5, menu_accel
          animation = workspaces, 1, 7, menu_decel, slide
          # animation = workspaces, 1, 2.5, softAcDecel, slide
          # animation = workspaces, 1, 7, menu_decel, slidefade 15%
          # animation = specialWorkspace, 1, 3, md3_decel, slidefadevert 15%
          animation = specialWorkspace, 1, 3, md3_decel, slidevert
      }

      misc {
          vfr = 1
          vrr = 1
          animate_manual_resizes = false
          animate_mouse_windowdragging = false
          enable_swallow = false
          swallow_regex = (foot|kitty|allacritty|Alacritty)

          disable_hyprland_logo = true
          force_default_wallpaper = 0
          new_window_takes_over_fullscreen = 2
          allow_session_lock_restore = true

          initial_workspace_tracking = false
      }

      # Overview
      plugin {
          hyprexpo {
              columns = 3
              gap_size = 5
              bg_col = rgb(000000)
              workspace_method = first 1 # [center/first] [workspace] e.g. first 1 or center m+1

              enable_gesture = false # laptop touchpad, 4 fingers
              gesture_distance = 300 # how far is the "max"
              gesture_positive = false
          }
      }







    '';
  };
}
