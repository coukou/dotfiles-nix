{ ... }: {
  flake.modules.nixos.services-keyboard-zsa = {
    hardware.keyboard.zsa.enable = true;
  };
}
