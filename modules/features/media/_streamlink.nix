{ ... }: {
  flake.modules.homeManager.media-streamlink = { pkgs, ... }: {
    home.packages = [ pkgs.streamlink ];
  };
}
