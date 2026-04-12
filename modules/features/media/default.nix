{ self, ... }: {
  flake.modules.homeManager.media = { ... }: {
    imports = with self.modules.homeManager; [
      media-spotify
      media-vlc
      media-streamlink
    ];
  };
}
