{ self
, pkgs
, users
, stateVersion
, ...
}: {
  imports = [
    ./common/pkgs.nix
  ];

  # Enable flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';

    gc.automatic = true;

    optimise.automatic = true;

    settings = {
      trusted-users = [ "root" ] ++ map (user: "${user}") users;
      auto-optimise-store = true;
    };

    registry.nixpkgs.flake = self.inputs.nixpkgs;
  };

  time.timeZone = "Europe/Paris";

  users.users = builtins.listToAttrs (
    map
      (user: {
        name = user;
        value = {
          isNormalUser = true;
          shell = pkgs.fish;
          extraGroups = [ "wheel" "tty" "audio" "video" "docker" ];
        };
      })
      users
  );

  users.groups = {
    docker = { };
  };

  programs.fish.enable = true;
  hardware.keyboard.zsa.enable = true;

  system.stateVersion = stateVersion;
}
