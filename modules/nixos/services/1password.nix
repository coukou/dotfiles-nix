{ ... }: {
  flake.modules.nixos.services-1password = {
    programs._1password.enable = true;
    programs._1password-gui.enable = true;
  };
}
