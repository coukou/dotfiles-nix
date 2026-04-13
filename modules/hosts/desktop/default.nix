{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "desktop";
    stateVersion = "26.05";
    nixosModules = with self.modules.nixos; [
      base systemd-boot theming
      hardware-desktop
      nvidia bluetooth
      networking docker onepassword keyboard-zsa opentablet
      window-manager
      shell coding ai local-ai
      user-coukou user-coukou-work
    ];
  };
}
