{ ... }: {
  flake.modules.nixos.services-networking = {
    networking.networkmanager.enable = true;
  };
}
