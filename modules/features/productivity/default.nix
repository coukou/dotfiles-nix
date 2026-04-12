{ self, ... }: {
  flake.modules.homeManager.productivity = { ... }: {
    imports = with self.modules.homeManager; [
      productivity-notion
      productivity-obsidian
      productivity-gmail
      productivity-proton-pass
      productivity-draw
    ];
  };
}
