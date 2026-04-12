{ ... }: {
  flake.modules.nixos.shell-fish = {
    programs.fish.enable = true;
  };

  flake.modules.homeManager.shell-fish = { ... }: {
    programs.fish.enable = true;
  };
}
