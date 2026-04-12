{ ... }: {
  flake.modules.homeManager.coding-postman = { pkgs, ... }: {
    home.packages = [ pkgs.postman ];
  };
}
