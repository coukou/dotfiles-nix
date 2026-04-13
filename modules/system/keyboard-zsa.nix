{ ... }: {
  flake.modules.nixos.keyboard-zsa = {
    hardware.keyboard.zsa.enable = true;
  };
}
