{ config, pkgs, wm, lib, ... }:
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

  environment.sessionVariables = lib.mkMerge [
    {
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
    }
  ];

  services.xserver.displayManager.gdm = {
    enable = true;
  };
}
