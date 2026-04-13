{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "xps13";
    stateVersion = "26.05";

    nixosModules = with self.modules.nixos; [
      systemd-boot
      theming
      hardware-xps13
      bluetooth
      intel-laptop
      networking
      onepassword
      keyboard-zsa
      window-manager
      greeter
      shell
      coding
      ai
    ];

    users = {
      coukou = {
        extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
        homeManager = {
          myConfig.protonPassVault = "Personal";
          imports = with self.modules.homeManager; [
            window-manager
            theming
            shell
            coding
            ai
            media
            browser
            productivity
            security
          ];
        };
      };
    };
  };
}
