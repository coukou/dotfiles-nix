{ ... }:
{
  programs.hyprpanel = {
    enable = true;

    settings = {
      bar = {
        layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" "windowtitle" ];
            middle = [ "media" "notifications" ];
            right = [ "systray" "volume" "network" "clock" ];
          };
        };

        media.show_active_only = true;
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
      };

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather = {
            unit = "metric";
            location = "Montpellier";
          };
        };

        dashboard = {
          directories.enabled = false;
          stats.enable_gpu = true;
        };
      };

      theme = {
        font = {
          name = "Noto Sans Mono Regular";
          size = "18px";
        };

        bar = {
          transparent = true;
        };

        osd = {
          margins = "10px 10px 10px 10px";
        };
      };

      notifications = {
        position = "top";
        showActionsOnHover = true;
      };
    };
  };
}
