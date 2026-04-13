{ ... }: {
  flake.modules.nixos.docker = {
    users.groups.docker = { };
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
