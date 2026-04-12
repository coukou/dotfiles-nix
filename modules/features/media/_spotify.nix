{ ... }: {
  flake.modules.homeManager.media-spotify = { pkgs, ... }: {
    home.packages = [ pkgs.spotify ];
  };
}
