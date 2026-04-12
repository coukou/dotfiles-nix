{ self, ... }: {
  flake.modules.nixos.user-coukou = { pkgs, stateVersion, ... }: {
    users.users.coukou = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "docker" "audio" "video" "kvm" "tty" ];
    };

    home-manager.users.coukou = {
      imports = [ (self + /home/profiles/coukou.nix) ];
      home.stateVersion = stateVersion;
    };
  };
}
