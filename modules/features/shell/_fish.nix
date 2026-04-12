{ ... }: {
  flake.modules.homeManager.shell-fish = { ... }: {
    programs.fish.enable = true;
  };
}
