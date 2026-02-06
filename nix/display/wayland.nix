{ pkgs, lib, ... }:
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
    xdg-desktop-portal
  ];

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "hyprland" "gtk" ];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  environment.sessionVariables = lib.mkMerge [
    {
      XDG_SESSION_TYPE = "wayland";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    }
  ];
}
