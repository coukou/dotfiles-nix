{ ... }: {
  flake.modules.nixos.greeter = { pkgs, ... }: {
    services.displayManager.ly.enable = true;
  };
}
