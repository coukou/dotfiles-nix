{ config
, self
, pkgs
, user
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
      trusted-users = [ "root" "${user}" ];
      auto-optimise-store = true;
    };

    registry.nixpkgs.flake = self.inputs.nixpkgs;
  };



  time.timeZone = "Europe/Paris";

  users.users."${user}" = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "tty" "audio" "video" "docker" ];
  };

  users.groups = {
    docker = { };
  };

  programs.fish.enable = true;

  system.stateVersion = stateVersion;
}
