{ config, pkgs, wm, gpu, lib, nixpkgs, ... }:
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

  environment.sessionVariables = lib.mkMerge (
    [
    ] ++ (
      if gpu == "nvidia" then [
        {
          WLR_NO_HARDWARE_CURSORS = "1";
          LIBVA_DRIVER_NAME = "nvidia";
          XDG_SESSION_TYPE = "wayland";
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        }
      ] else [
        {
          # Set OZONE only if in non nvidia env, as I found xwayland is better on nvidia env
          NIXOS_OZONE_WL = "1";
        }
      ]
    )
  );

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
