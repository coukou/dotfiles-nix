{ pkgs, lib, inputs, ... }:
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
      xdg-desktop-portal-gtk
    ];
  };

  environment.sessionVariables = lib.mkMerge [
    {
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
    }
  ];
}
