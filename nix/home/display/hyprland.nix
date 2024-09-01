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
    plugins = [ inputs.hy3.packages.x86_64-linux.hy3 ];
    extraConfig = ''
      $menu = wofi --show drun
      $browser = firefox
      $terminal = kitty
      $fileManager = nautilus

      exec-once = swww init
      exec-once = swaync

      exec = sleep 1 && swww img ${wallpaper}

      monitor=,highrr,auto,1,vrr,1

      exec-once = waybar
      blurls = waybar

      general {
        gaps_in = 4
        gaps_out = 4
        border_size = 2

        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = hy3
        # layout = dwindle
      }

      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 0

        blur {
          enabled = true
          size = 2
          passes = 8

          vibrancy = 0.16574
        }

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
      }

      animations {
        enabled = true

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
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, Q, killactive,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, Space, togglefloating
      bind = $mainMod, D, exec, $menu
      bind = $mainMod, P, pin
      bind = $mainMod, G, hy3:makegroup, tab
      bind = $mainMod, H, hy3:makegroup, h
      bind = $mainMod, V, hy3:makegroup, v

      # Screenshots bindings
      bind = $mainMod SHIFT CTRL, s, exec, wayshot --stdout | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"
      bind = $mainMod CTRL, s, exec, wayshot --stdout -s "$(slurp)" | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"

      # Move focus with mainMod + arrow keys
      # bind = $mainMod, left, movefocus, l
      # bind = $mainMod, right, movefocus, r
      # bind = $mainMod, up, movefocus, u
      # bind = $mainMod, down, movefocus, d
      bind = $mainMod, left, hy3:movefocus, l
      bind = $mainMod, right, hy3:movefocus, r
      bind = $mainMod, up, hy3:movefocus, u
      bind = $mainMod, down, hy3:movefocus, d

      # Move window with mainMod + SHIFT + arrow keys
      # bind = $mainMod SHIFT, left, movewindow, l
      # bind = $mainMod SHIFT, right, movewindow, r
      # bind = $mainMod SHIFT, up, movewindow, u
      # bind = $mainMod SHIFT, down, movewindow, d
      bind = $mainMod SHIFT, left, hy3:movewindow, l
      bind = $mainMod SHIFT, right, hy3:movewindow, r
      bind = $mainMod SHIFT, up, hy3:movewindow, u
      bind = $mainMod SHIFT, down, hy3:movewindow, d

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

      plugin {
        hy3 {
          # disable gaps when only one window is onscreen
          # 0 - always show gaps
          # 1 - hide gaps with a single window onscreen
          # 2 - 1 but also show the window border
          no_gaps_when_only = 0

          # policy controlling what happens when a node is removed from a group,
          # leaving only a group
          # 0 = remove the nested group
          # 1 = keep the nested group
          # 2 = keep the nested group only if its parent is a tab group
          node_collapse_policy = 0

          # tab group settings
          tabs {
            # height of the tab bar
            height = 20 # default: 15

            # padding between the tab bar and its focused node
            padding = 0 # default: 5

            # the tab bar should animate in/out from the top instead of below the window
            # from_top = <bool> # default: false

            # rounding of tab bar corners
            rounding = 0 # default: 3

            # render the window title on the bar
            render_text = true # default: true

            # font to render the window title with
            text_font = <string> # default: Sans

            # height of the window title
            text_height = 12 # default: 8

            # left padding of the window title
            # text_padding = <int> # default: 3

            # active tab bar segment color
            # col.active = <color> # default: 0xff32b4ff

            # urgent tab bar segment color
            # col.urgent = <color> # default: 0xffff4f4f

            # inactive tab bar segment color
            # col.inactive = <color> # default: 0x80808080

            # active tab bar text color
            # col.text.active = <color> # default: 0xff000000

            # urgent tab bar text color
            # col.text.urgent = <color> # default: 0xff000000

            # inactive tab bar text color
            # col.text.inactive = <color> # default: 0xff000000
          }
        }
      }
    '';
  };
}
