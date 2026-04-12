{ ... }: {
  flake.modules.homeManager.shell-starship = { ... }: {
    programs.starship = {
      enable = true;
      settings = { };
    };
  };
}
