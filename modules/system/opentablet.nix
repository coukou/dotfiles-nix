{ ... }: {
  flake.modules.nixos.opentablet = {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
