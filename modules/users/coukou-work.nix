{ self, ... }: {
  flake.modules.nixos.user-coukou-work = { pkgs, stateVersion, ... }: {
    users.users.coukou-work = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
    };

    home-manager.users.coukou-work = {
      imports = [ (self + /home/profiles/coukou-work.nix) ];
      home.stateVersion = stateVersion;
    };
  };
}
