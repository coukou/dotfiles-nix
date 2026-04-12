{ self, ... }: {
  imports = [ ./_zen-browser.nix ./_brave.nix ];

  flake.modules.homeManager.browser = { ... }: {
    imports = with self.modules.homeManager; [
      browser-zen
      browser-brave
    ];
  };
}
