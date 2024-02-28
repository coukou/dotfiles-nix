{ config, pkgs, wm, ... }:
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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

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
