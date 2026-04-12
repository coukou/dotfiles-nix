{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "xps13";
    stateVersion = "26.05";
    nixosModules = with self.modules.nixos; [
      base
      boot
      fonts
      hardware-xps13
      hardware-bluetooth
      hardware-intel-laptop
      services-wayland
      services-networking
      services-1password
      services-keyboard-zsa
      shell
      coding
      ai
      user-coukou
    ];
  };
}
