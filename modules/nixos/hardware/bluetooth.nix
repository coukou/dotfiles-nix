{ ... }: {
  flake.modules.nixos.hardware-bluetooth = {
    hardware.bluetooth.enable = true;
  };
}
