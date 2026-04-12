{ ... }: {
  flake.modules.homeManager.media-vlc = { pkgs, ... }: {
    home.packages = [ pkgs.vlc ];
  };
}
