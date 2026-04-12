{ self, ... }: {
  imports = [ ./_spotify.nix ./_vlc.nix ./_streamlink.nix ];

  flake.modules.homeManager.media = { ... }: {
    imports = with self.modules.homeManager; [
      media-spotify
      media-vlc
      media-streamlink
    ];
  };
}
