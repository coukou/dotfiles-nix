{ pkgs, home, inputs, gpu, ... }:
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

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  home.packages = with pkgs; [
    jq
    socat
    wl-clipboard

    # drun for wayland
    wofi

    # browser
    firefox

    # Filemanager
    xfce.thunar

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
    extraConfig = builtins.concatStringsSep "\n" ([
      ''
        $menu = wofi --show drun
        $browser = firefox
        $terminal = kitty
        $fileManager = thunar

        exec-once = swww init
        exec-once = swaync

        exec = sleep 1 && swww img ${wallpaper}

        monitor=,highrr,auto,1,vrr,1

        exec-once = waybar
        blurls = waybar

        general {
          gaps_in = 5
          gaps_out = 15
          border_size = 2

          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle
        }

        decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10

          blur {
            enabled = true
            size = 2
            passes = 4

            vibrancy = 0.16574
          }

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
        }

        animations {
          enabled = true

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

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
        bind = $mainMod, V, togglefloating,
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
      ''
    ] ++ (if gpu == "nvidia" then [
      ''
        env = GDK_BACKEND,wayland,x11
        env = SDL_VIDEODRIVER,wayland
        env = CLUTTER_BACKEND,wayland
        env = MOZ_ENABLE_WAYLAND,1
        env = MOZ_DISABLE_RDD_SANDBOX,1
        env = _JAVA_AWT_WM_NONREPARENTING=1
        env = QT_AUTO_SCREEN_SCALE_FACTOR,1
        env = QT_QPA_PLATFORM,wayland
        env = LIBVA_DRIVER_NAME,nvidia
        env = GBM_BACKEND,nvidia-drm
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = WLR_NO_HARDWARE_CURSORS,1
        env = __NV_PRIME_RENDER_OFFLOAD,1
        env = __VK_LAYER_NV_optimus,NVIDIA_only
        env = PROTON_ENABLE_NGX_UPDATER,1
        env = NVD_BACKEND,direct
        env = __GL_GSYNC_ALLOWED,1
        env = __GL_VRR_ALLOWED,1
        env = WLR_DRM_NO_ATOMIC,1
        env = WLR_USE_LIBINPUT,1
        env = XWAYLAND_NO_GLAMOR,1 # with this you'll need to use gamescope for gaming
        env = __GL_MaxFramesAllowed,1
        env = WLR_RENDERER_ALLOW_SOFTWARE,1
      ''
    ] else [ ]));
  };
}
