{ ... }: {
  flake.modules.homeManager.media = { pkgs, ... }: {
    home.packages = with pkgs; [ spotify vlc streamlink ];
  };
}
