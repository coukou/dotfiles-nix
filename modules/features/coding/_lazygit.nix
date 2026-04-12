{ ... }: {
  flake.modules.homeManager.coding-lazygit = { pkgs, ... }: {
    home.packages = [ pkgs.lazygit ];
  };
}
