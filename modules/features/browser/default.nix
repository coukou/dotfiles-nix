{ self, ... }: {
  flake.modules.homeManager.browser = { ... }: {
    imports = with self.modules.homeManager; [
      browser-zen
      browser-brave
    ];
  };
}
