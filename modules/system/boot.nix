{ ... }: {
  flake.modules.nixos.boot = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };
  };
}
