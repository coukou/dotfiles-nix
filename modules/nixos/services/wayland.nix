{ ... }: {
  flake.modules.nixos.services-wayland = { pkgs, ... }: {
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
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
      xdg-desktop-portal
    ];

    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    };
  };
}
