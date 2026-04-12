{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "desktop";
    stateVersion = "26.05";
    nixosModules = with self.modules.nixos; [
      base
      overlays
      hardware-desktop
      hardware-nvidia
      hardware-bluetooth
      services-wayland
      services-networking
      services-docker
      services-1password
      services-keyboard-zsa
      services-opentablet
      user-coukou
      user-coukou-work
    ];
  };
}
