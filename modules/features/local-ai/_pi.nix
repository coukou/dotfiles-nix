{ ... }: {
  flake.modules.homeManager.local-ai-pi = { pkgs, ... }: {
    home.packages = [ pkgs.pi ];
  };
}
