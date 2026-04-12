{ self, ... }: {
  flake.modules.nixos.user-coukou-work = { pkgs, stateVersion, ... }: {
    users.users.coukou-work = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
    };

    home-manager.users.coukou-work = {
      myConfig.protonPassVault = "Work";
      imports = with self.modules.homeManager; [
        base
        display
        shell
        coding
        ai
        media
        communication
        browser
        productivity
        security
      ];
      home.stateVersion = stateVersion;
    };
  };
}
