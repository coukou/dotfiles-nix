{ self, ... }: {
  flake.nixosConfigurations = self.utils.mkNixos {
    name = "desktop";
    stateVersion = "26.05";

    nixosModules = with self.modules.nixos; [
      systemd-boot
      theming
      hardware-desktop
      nvidia-driver
      bluetooth
      networking
      docker
      onepassword
      keyboard-zsa
      opentablet
      window-manager
      shell
      coding
      ai
      local-ai
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
            local-ai
            media
            communication
            browser
            productivity
            security
          ];
        };
      };

      coukou-work = {
        extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
        homeManager = {
          myConfig.protonPassVault = "Work";
          imports = with self.modules.homeManager; [
            window-manager
            theming
            shell
            coding
            ai
            media
            communication
            browser
            productivity
            security
          ];
        };
      };
    };
  };
}
