{ pkgs, inputs, ... }:
let

  # Satty --copy-command does not support flags so we need to wrap wl-copy
  wlCopySattyScript = pkgs.writeShellScriptBin "wl-copy-satty" ''
    ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
  '';

  wallpaper = ../../../wallpapers/1.png;
in
{
  imports = [
    ../programs/kitty.nix
    ../programs/ghostty.nix
    ../programs/waybar
  ];

  home.packages = with pkgs; [
    jq
    socat
    wl-clipboard

    # drun for wayland
    wofi

    # browser
    firefox
    chromium

    # Filemanager
    nautilus

    # sounds
    pavucontrol

    # screenshots
    satty
    wayshot
    slurp

    # wallpaper
    swww

    # notifications
    swaynotificationcenter
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = (inputs.hyprland.packages."x86_64-linux".hyprland.override { });
    portalPackage = null;

    extraConfig = ''
      $menu = wofi --show drun
      $browser = zen
      $terminal = ghostty
      $fileManager = nautilus

      exec-once = swww init
      exec-once = swaync

      exec = sleep 1 && swww img ${wallpaper}

      monitor = ,highrr,auto,1,vrr,1

      exec-once = waybar
      blurls = waybar

      general {
        gaps_in = 4
        gaps_out = 10
        border_size = 2

        col.active_border = rgba(8241f2dd)
        col.inactive_border = rgba(ffffff20)

        layout = dwindle
      }

      windowrule = match:fullscreen_state_internal 1, border_color rgb(a541f2)

      windowrule {
        name = fix-idea-focus-issue
        match:title = ^win(.*)
        match:class = jetbrains-idea-ce

        no_initial_focus = on
      }

      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 4

        blur {
          enabled = true
          size = 2
          passes = 8
          vibrancy = 0.16574
        }

        shadow {
          enabled = true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
        }

      }

      animations {
        enabled = false

        bezier = myBezier, 0.05, 0.9, 0.1, 1.0

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 4, default, fade
      }

      input {
        repeat_delay = 250
        repeat_rate = 60
      }

      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, $terminal
      bind = $mainMod, B, exec, $browser
      bind = $mainMod, F, fullscreen, 1
      bind = $mainMod SHIFT, F, fullscreen, 0
      bind = $mainMod, Q, killactive,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, Space, togglefloating
      bind = $mainMod, D, exec, $menu
      bind = $mainMod, P, pin

      # Screenshots bindings
      bind = $mainMod SHIFT CTRL, s, exec, wayshot --stdout | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"
      bind = $mainMod CTRL, s, exec, wayshot --stdout -s "$(slurp)" | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Move window with mainMod + SHIFT + arrow keys
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d

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

      # Switch workspaces with mainMod + CTRL + arrow keys
      bind = $mainMod CTRL, left, workspace, -1
      bind = $mainMod CTRL, right, workspace, +1

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

      # Move active window to a workspace with mainMod + CTRL + arrow keys
      bind = $mainMod SHIFT CTRL, left, movetoworkspace, -1
      bind = $mainMod SHIFT CTRL, right, movetoworkspace, +1

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Resize with directions keys
      bind = $mainMod, R, submap, resize
      submap=resize

      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10

      binde=SHIFT,right,resizeactive,50 0
      binde=SHIFT,left,resizeactive,-50 0
      binde=SHIFT,up,resizeactive,0 -50
      binde=SHIFT,down,resizeactive,0 50

      bind=,RETURN,submap,reset
      bind=,ESCAPE,submap,reset
      submap=reset
    '';
  };
}
