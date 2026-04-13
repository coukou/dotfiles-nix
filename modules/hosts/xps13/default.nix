{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "xps13";
    stateVersion = "26.05";
    nixosModules = with self.modules.nixos; [
      base boot fonts
      hardware-xps13
      bluetooth intel-laptop
      networking onepassword keyboard-zsa
      window-manager
      shell coding ai
      user-coukou
    ];
  };
}
