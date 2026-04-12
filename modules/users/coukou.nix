{ self, ... }: {
  flake.modules.nixos.user-coukou = { pkgs, stateVersion, ... }: {
    users.users.coukou = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
    };

    home-manager.users.coukou = {
      imports = with self.modules.homeManager; [
        base
        display
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
      home.stateVersion = stateVersion;
    };
  };
}
