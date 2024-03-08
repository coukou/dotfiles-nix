{ config, pkgs, wm, gpu, lib, ... }:
let
  greetImg = ../../wallpapers/greeter.png;
  regreet-override = pkgs.greetd.regreet.overrideAttrs (final: prev: {
    SESSION_DIRS = "${config.services.xserver.displayManager.sessionData.desktops}/share";
  });
in
{
  imports = [ ];
  hardware.opengl.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  xdg.portal.wlr.enable = true;
  services.dbus.enable = true;

  environment.sessionVariables = lib.mkMerge ([
    {
      NIXOS_OZONE_WL = "1";
    }
  ] ++ (if gpu == "nvidia" then [{

    WLR_NO_HARDWARE_CURSORS = "1";

    # https://github.com/hyprwm/Hyprland/issues/4523#issuecomment-1926460314
    OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";

  }] else [ ]));

  services.xserver.displayManager.session = [ ] ++ (if wm == "hyprland" then [
    {
      manage = "desktop";
      name = "hyprland";
      start = ''
        Hyprland &
        waitPID=$!
      '';
    }
  ] else [ ]);

  services.greetd = {
    enable = true;
  };

  programs.regreet = {
    enable = true;
    package = regreet-override;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };

      background = {
        path = greetImg;
      };
    };
  };
}
