{ config, pkgs, wm, lib, ... }:
let
  greetImg = ../../wallpapers/greeter.png;
  regreet-override = pkgs.greetd.regreet.overrideAttrs (final: prev: {
    SESSION_DIRS = "${config.services.xserver.displayManager.sessionData.desktops}/share";
  });
in
{
  imports = [ ];
  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;

    xdgOpenUsePortal = true;

    config.common.default = [ "gnome" ];

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  environment.sessionVariables = lib.mkMerge [
    {
      XDG_SESSION_TYPE = "wayland";
    }
  ];

  services.xserver.displayManager.gdm = {
    enable = true;
  };
}
