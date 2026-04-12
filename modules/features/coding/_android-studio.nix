{ ... }: {
  flake.modules.homeManager.coding-android-studio = { pkgs, ... }: {
    home.packages = [ pkgs.android-studio ];
  };
}
