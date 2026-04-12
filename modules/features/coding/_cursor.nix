{ ... }: {
  flake.modules.homeManager.coding-cursor = { pkgs, ... }: {
    home.packages = [ pkgs.code-cursor ];
  };
}
