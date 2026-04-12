{ self, ... }: {
  imports = [ ./_obsidian.nix ./_draw.nix ];

  flake.modules.homeManager.productivity = { ... }: {
    imports = with self.modules.homeManager; [
      productivity-obsidian
      productivity-draw
    ];
  };
}
