{ inputs, ... }:
{
  flake.modules.nixos.window-manager = { pkgs, system, ... }: {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
    };

    hardware.graphics.enable = true;
    security.rtkit.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.dbus.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = [ "hyprland" "gtk" ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [ xdg-utils xdg-desktop-portal ];

    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    };
  };

  flake.modules.homeManager.window-manager = { self, pkgs, ... }:
    let
      wlCopySattyScript = pkgs.writeShellScriptBin "wl-copy-satty" ''
        ${pkgs.wl-clipboard}/bin/wl-copy -t image/png
      '';
      rofiTheme = pkgs.stdenv.mkDerivation {
        name = "rofi-theme";
        src = ../_packages/display/rofi/themes;
        installPhase = "mkdir -p $out && cp * $out/";
      };
    in
    {
      home.packages = with pkgs; [
        wl-clipboard
        nautilus
        pavucontrol
        satty
        grim
        slurp
        swaynotificationcenter
      ];

      services.hyprpaper = {
        enable = true;
        settings.wallpaper = [ "${self}/wallpapers/1.png" ];
      };

      programs.rofi = {
        enable = true;
        theme = "${rofiTheme}/main.rasi";
      };

      programs.waybar = {
        enable = true;
        settings = [ (builtins.fromJSON (builtins.readFile ../_packages/display/waybar/config)) ];
        style = ../_packages/display/waybar/style.css;
      };

      programs.hyprpanel = {
        enable = true;
        settings = {
          bar = {
            layouts."0" = {
              left = [ "dashboard" "workspaces" "windowtitle" ];
              middle = [ "media" "notifications" ];
              right = [ "systray" "volume" "network" "clock" ];
            };
            media.show_active_only = true;
            launcher.autoDetectIcon = true;
            workspaces.show_numbered = true;
          };
          menus = {
            clock = {
              time = { military = true; hideSeconds = true; };
              weather = { unit = "metric"; location = "Montpellier"; };
            };
            dashboard = {
              directories.enabled = false;
              stats.enable_gpu = true;
            };
          };
          theme = {
            font = { name = "Noto Sans Mono Regular"; size = "18px"; };
            bar = { transparent = true; buttons.workspaces.fontSize = "1em"; };
            osd.margins = "10px 10px 10px 10px";
          };
          notifications = { position = "top"; showActionsOnHover = true; };
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = null;

        extraConfig = ''
          $menu = rofi -show drun
          $browser = zen
          $terminal = ghostty
          $fileManager = nautilus
          $minOpacity = 0.4
          $opacity = 0.95

          exec-once = swaync

          monitor = ,highrr,auto,1,vrr,1

          general {
            gaps_in = 4
            gaps_out = 10
            border_size = 2
            col.active_border = rgb(cba6f7)
            col.inactive_border = rgb(11111b)
            layout = dwindle
          }

          windowrule {
            name = app-blur-toggle
            match:class = .*$terminal.*
            opacity = $opacity
          }

          layerrule {
            name = layer-blur-toggle
            match:namespace = .*waybar.*|.*rofi.*|.*notifications.*
            blur = on
            ignore_alpha = $minOpacity
          }

          windowrule = match:fullscreen_state_internal 1, border_color rgb(f5e0dc)

          windowrule {
            name = fix-idea-focus-issue
            match:title = ^win(.*)
            match:class = jetbrains-idea
            no_initial_focus = on
          }

          decoration {
            rounding = 4
            blur {
              enabled = true
              size = 6
              passes = 3
              popups = true
              popups_ignorealpha = $minOpacity
              input_methods = true
              input_methods_ignorealpha = $minOpacity
              noise  = 0.0
              contrast = 1.0
              brightness = 1.0
              vibrancy = 0.3
              vibrancy_darkness = 0.3
            }
            shadow {
              enabled = true
              range = 25
              render_power = 3
              color = rgba(11111b88)
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

          bind = $mainMod, Return, exec, $terminal
          bind = $mainMod, B, exec, $browser
          bind = $mainMod, F, fullscreen, 1
          bind = $mainMod SHIFT, F, fullscreen, 0
          bind = $mainMod, Q, killactive,
          bind = $mainMod, E, exec, $fileManager
          bind = $mainMod, Space, togglefloating
          bind = $mainMod, D, exec, $menu
          bind = $mainMod, P, pin

          bind = $mainMod SHIFT CTRL, s, exec, grim - | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"
          bind = $mainMod CTRL, s, exec, grim -g "$(slurp)" - | satty --filename - --early-exit --copy-command "${wlCopySattyScript}/bin/wl-copy-satty"

          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          bind = $mainMod SHIFT, left, movewindow, l
          bind = $mainMod SHIFT, right, movewindow, r
          bind = $mainMod SHIFT, up, movewindow, u
          bind = $mainMod SHIFT, down, movewindow, d

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

          bind = $mainMod CTRL, left, workspace, -1
          bind = $mainMod CTRL, right, workspace, +1

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

          bind = $mainMod SHIFT CTRL, left, movetoworkspace, -1
          bind = $mainMod SHIFT CTRL, right, movetoworkspace, +1

          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow

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
    };
}
